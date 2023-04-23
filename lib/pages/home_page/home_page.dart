//ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/main_home_page_bloc.dart';
import 'package:photo_just_for_fun/pages/home_page/widgets/photo_home_page_loading_widget.dart';
import 'package:photo_just_for_fun/pages/home_page/widgets/photo_home_page_widget.dart';
import 'package:photo_just_for_fun/utils/firebase_auth_fun.dart';
import 'package:photo_just_for_fun/widgets/icon_button_widget.dart';
import 'package:photo_just_for_fun/widgets/loading_progress_widget.dart';
import 'package:photo_just_for_fun/widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  final PersistentTabController persistentNavController;

  const HomePage({Key? key, required this.persistentNavController})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        context.read<MainHomePageBloc>().add(PaginateHomePageEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainHomePageBloc, HomePageBlocStates>(
        builder: (context, state) {
      var current_state = state.photoStateModel;
      return SafeArea(
          child: Scaffold(
              appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: const TextWidget(
                      text: "Photos",
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      size: 24),
                  actions: [
                    IconButtonWidget(
                        voidCallback: () async {
                          FirebaseAuthFunc.phoneFirebaseAuth("915172589")
                              .then((value) async {
                            await Future.delayed(const Duration(seconds: 5));
                            await FirebaseAuthFunc.verifyFirebaseAuth(
                                value['verificationId'], '511111');
                          });
                        },
                        icon: CupertinoIcons.search,
                        iconColor: Colors.black)
                  ]),
              body: Padding(
                  padding: const EdgeInsets.only(left: 7, right: 10, top: 0),
                  child: RefreshIndicator(
                    color: Colors.amberAccent.shade200,
                    onRefresh: () async => context
                        .read<MainHomePageBloc>()
                        .add(RefreshHomePageEvent()),
                    child: ListView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [
                          if (state is HomePageLoadingState)
                            ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 15),
                                itemCount: 15,
                                itemBuilder: (context, index) =>
                                    const PhotoHomePageLoadingWidget())
                          else if (state is HomePageInitialState)
                            Column(children: [
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 20),
                                  itemCount: current_state.photo_list.length,
                                  itemBuilder: (context, index) {
                                    var photo = current_state.photo_list[index];
                                    return PhotoHomePageWidget(
                                        persistentNavController:
                                            widget.persistentNavController,
                                        photoModel: photo);
                                  }),
                              const SizedBox(height: 10),
                              LoadingProgressWidget(
                                  showProgress: current_state.hasMore)
                            ]),
                          const SizedBox(height: 15)
                        ]),
                  ))));
    });
  }
}

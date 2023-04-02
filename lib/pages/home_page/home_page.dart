//ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_just_for_fun/api/utils/permanent_functions.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/main_home_page_bloc.dart';
import 'package:photo_just_for_fun/pages/home_page/widgets/photo_home_page_widgetg.dart';
import 'package:photo_just_for_fun/widgets/animted_app_bar.dart';
import 'package:photo_just_for_fun/widgets/cache_network_image_widget.dart';
import 'package:photo_just_for_fun/widgets/loading_progress_widget.dart';
import 'package:photo_just_for_fun/widgets/shimmer_container.dart';
import 'package:photo_just_for_fun/widgets/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

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
                      size: 24)),
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
                                    const ShimmerContainer(
                                        width: double.maxFinite,
                                        height: 200,
                                        borderRadius: 10))
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

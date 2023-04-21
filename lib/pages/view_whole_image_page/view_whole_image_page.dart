import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/main_log_reg_bloc.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/main_home_page_bloc.dart';
import 'package:photo_just_for_fun/models/photo_models/photo_model.dart';
import 'package:photo_just_for_fun/utils/permanent_functions.dart';
import 'package:photo_just_for_fun/widgets/animated_heart_container.dart';
import 'package:photo_just_for_fun/widgets/cache_network_image_widget.dart';
import 'package:photo_just_for_fun/widgets/text_widget.dart';
import 'package:photo_view/photo_view.dart';

class ViewWholeImagePage extends StatelessWidget {
  final PhotoModel photoModel;
  final PersistentTabController persistentNavController;

  const ViewWholeImagePage(
      {Key? key,
      required this.photoModel,
      required this.persistentNavController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLogRegBloc, LogRegBlocStates>(
        builder: (context, regState) => Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
                backgroundColor: Colors.black.withOpacity(0.1),
                elevation: 0,
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new)),
                iconTheme: const IconThemeData(color: Colors.white)),
            body: Stack(children: [
              Hero(
                  tag: "photo_${photoModel.id}",
                  child: PhotoView(
                    imageProvider:
                        NetworkImage("${photoModel.photoSrc?.portrait ?? ''}"),
                    minScale: PhotoViewComputedScale.contained,
                    // initialScale: PhotoViewComputedScale.covered,
                    loadingBuilder: (context, event) {
                      return Container(
                          color: Colors.black,
                          child: const Center(
                              child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                      color: Colors.amber, strokeWidth: 2))));
                    },
                  )),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          color: Colors.black.withOpacity(0.2)),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  TextWidget(
                                      text: photoModel.photographer ?? '',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      size: 16),
                                  TextWidget(
                                      text: photoModel.alt ?? '',
                                      color: Colors.white)
                                ])),
                            InkWell(
                                onTap: () {
                                  if (regState is LogRegBlocRegisteredState) {
                                    context.read<MainHomePageBloc>().add(
                                        (photoModel.liked ?? false)
                                            ? RemoveLikeEvent(
                                                photoModel: photoModel)
                                            : ClickLikeEvent(
                                                photoModel: photoModel));
                                  } else {
                                    PermanentFunctions.showToast(
                                        message: "You are not registered",
                                        error: true);
                                  }
                                },
                                child: Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle),
                                    child: Icon(CupertinoIcons.heart_fill,
                                        color: (photoModel.liked ?? false)
                                            ? Colors.amber
                                            : Colors.white)))
                          ])))
            ])));
  }
}

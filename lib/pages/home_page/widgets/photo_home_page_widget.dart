import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/main_log_reg_bloc.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_events.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/home_page_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/main_home_page_bloc/main_home_page_bloc.dart';
import 'package:photo_just_for_fun/models/photo_models/photo_model.dart';
import 'package:photo_just_for_fun/pages/view_whole_image_page/view_whole_image_page.dart';
import 'package:photo_just_for_fun/widgets/animated_heart_container.dart';
import 'package:photo_just_for_fun/widgets/cache_network_image_widget.dart';
import 'package:photo_just_for_fun/widgets/text_widget.dart';

class PhotoHomePageWidget extends StatefulWidget {
  final PersistentTabController persistentNavController;
  final PhotoModel photoModel;

  const PhotoHomePageWidget(
      {Key? key,
      required this.persistentNavController,
      required this.photoModel})
      : super(key: key);

  @override
  State<PhotoHomePageWidget> createState() => _PhotoHomePageWidgetState();
}

class _PhotoHomePageWidgetState extends State<PhotoHomePageWidget> {
  bool tap = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLogRegBloc, LogRegBlocStates>(
        builder: (context, state) => InkWell(
              onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
                  withNavBar: false,
                  screen: ViewWholeImagePage(
                      photoModel: widget.photoModel,
                      persistentNavController: widget.persistentNavController),
                  pageTransitionAnimation: PageTransitionAnimation.fade),
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  margin: tap
                      ? EdgeInsets.all(5)
                      : EdgeInsets.only(left: 3, right: 3),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      border: tap ? Border.all(color: Colors.grey[300]!) : null,
                      boxShadow: tap
                          ? []
                          : [
                              BoxShadow(
                                  spreadRadius: 2,
                                  offset: const Offset(1, 2),
                                  color: Colors.grey[300]!,
                                  blurRadius: 3),
                              BoxShadow(
                                  spreadRadius: 2,
                                  offset: const Offset(-0.2, -0.3),
                                  color: Colors.grey[300]!,
                                  blurRadius: 1)
                            ]),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // CachedNetworkImageWidget(
                        //     height: 250,
                        //     width: double.maxFinite,
                        //     url: photoModel.photoSrc?.large ?? ''),
                        Listener(
                          onPointerDown: (details) => setState(() {
                            tap = true;
                          }),
                          onPointerUp: (details) => setState(() {
                            tap = false;
                          }),
                          child: Hero(
                            tag: "photo_${widget.photoModel.id}",
                            child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    topLeft: Radius.circular(15)),
                                child: ImageLoaderWidget(
                                    boxFit: BoxFit.cover,
                                    height: 250,
                                    width: double.infinity,
                                    url:
                                        widget.photoModel.photoSrc?.large ?? '',
                                    errorPictureUrl:
                                        "assets/images/placeholder-image.png")),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                        TextWidget(
                                            text: widget
                                                    .photoModel.photographer ??
                                                '',
                                            fontWeight: FontWeight.bold,
                                            size: 16),
                                        TextWidget(
                                            text: widget.photoModel.alt ?? ''),
                                        const SizedBox(height: 10),
                                      ])),
                                  AnimatedHeartContainer(
                                      photoModel: widget.photoModel,
                                      onTap: () {
                                        if (state
                                            is LogRegBlocRegisteredState) {
                                          context.read<MainHomePageBloc>().add(
                                              (widget.photoModel.liked ?? false)
                                                  ? RemoveLikeEvent(
                                                      photoModel:
                                                          widget.photoModel)
                                                  : ClickLikeEvent(
                                                      photoModel:
                                                          widget.photoModel));
                                        } else {
                                          widget.persistentNavController
                                              .jumpToTab(3);
                                        }
                                      })
                                ]))
                      ])),
            ));
  }
}

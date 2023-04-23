import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/log_reg_bloc_states.dart';
import 'package:photo_just_for_fun/bloc/log_reg_bloc/main_log_reg_bloc.dart';
import 'package:photo_just_for_fun/widgets/cache_network_image_widget.dart';

class ProfileCircleImage extends StatefulWidget {
  const ProfileCircleImage({Key? key}) : super(key: key);

  @override
  State<ProfileCircleImage> createState() => _ProfileCircleImageState();
}

class _ProfileCircleImageState extends State<ProfileCircleImage> {
  bool taped = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLogRegBloc, LogRegBlocStates>(
        builder: (context, state) {
      var getState = state.logRegStateModel;
      return ClipOval(
          child: Listener(
              onPointerDown: (v) => setState(() => taped = true),
              onPointerUp: (v) => setState(() => taped = false),
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: taped ? 105 : 110,
                  height: taped ? 105 : 110,
                  color: Colors.white,
                  child: Center(
                      child: Hero(
                    tag: "user_profile_image",
                    child: ClipOval(
                        child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: taped ? 90 : 95,
                            height: taped ? 90 : 95,
                            child: ImageLoaderWidget(
                                url: getState.userModel?.img_url ?? '',
                                errorPictureUrl:
                                    'assets/images/placeholder-image.png',
                                boxFit: BoxFit.cover))),
                  )))));
    });
  }
}

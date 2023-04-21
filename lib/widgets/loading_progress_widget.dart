import 'package:flutter/material.dart';
import 'package:photo_just_for_fun/utils/constant.dart';

class LoadingProgressWidget extends StatelessWidget {
  final bool showProgress;
  final Color? progressColor;

  const LoadingProgressWidget(
      {Key? key, required this.showProgress, this.progressColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showProgress == true) {
      return Center(
          child: Container(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                  color: progressColor ?? app_color, strokeWidth: 2)));
    } else {
      return Container();
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_just_for_fun/models/photo_models/photo_model.dart';

class AnimatedHearContainer extends StatefulWidget {
  final PhotoModel photoModel;
  final VoidCallback onTap;

  const AnimatedHearContainer(
      {Key? key, required this.photoModel, required this.onTap})
      : super(key: key);

  @override
  State<AnimatedHearContainer> createState() => _AnimtedHearContainerState();
}

class _AnimtedHearContainerState extends State<AnimatedHearContainer> {
  bool startedFunc = false;
  bool clickedWork = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onTap,
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            // color: Colors.amber,
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.shade500,
                      blurRadius: 11,
                      offset: const Offset(2, 2)),
                  const BoxShadow(
                      color: Colors.white,
                      blurRadius: 15,
                      offset: Offset(-2, -2))
                ]),
            child: Icon(
              CupertinoIcons.heart_fill,
              size: 20,
              color: (widget.photoModel.liked ?? false)
                  ? Colors.amber
                  : Colors.black,
            )));
  }
}

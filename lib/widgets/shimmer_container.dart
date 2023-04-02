import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final double? borderRadius;
  final Color? baseColor;
  final Color? highLightColor;

  const ShimmerContainer(
      {Key? key,
      required this.width,
      required this.height,
      this.borderRadius,
      this.baseColor,
      this.highLightColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(borderRadius ?? 0))));
  }
}

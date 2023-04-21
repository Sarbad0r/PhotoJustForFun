import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoaderWidget extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final EdgeInsets? marginShimmerContainer;
  final EdgeInsets? paddingShimmerContainer;

  const ImageLoaderWidget(
      {Key? key,
      required this.url,
      this.height,
      this.width,
      this.boxFit,
      this.marginShimmerContainer,
      this.paddingShimmerContainer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        height: height,
        width: width,
        fit: boxFit ?? BoxFit.scaleDown,
        placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.white,
            child: Container(
                margin: marginShimmerContainer,
                padding: paddingShimmerContainer,
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(5)))),
        errorWidget: (context, url, error) => Image.asset(
            'assets/pictures/defaults/no_photo_256.png',
            height: height,
            width: width,
            fit: BoxFit.scaleDown));
  }
}

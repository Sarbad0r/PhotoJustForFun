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
  final String errorPictureUrl;
  final Widget? errorWidget;

  const ImageLoaderWidget(
      {Key? key,
      required this.url,
      required this.errorPictureUrl,
      this.height,
      this.width,
      this.boxFit,
      this.marginShimmerContainer,
      this.paddingShimmerContainer,
      this.errorWidget})
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
        errorWidget: (context, url, error) =>
            errorWidget ??
            Image.asset(errorPictureUrl,
                height: height, width: width, fit: boxFit ?? BoxFit.scaleDown));
  }
}

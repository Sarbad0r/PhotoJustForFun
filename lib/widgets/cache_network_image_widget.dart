import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final Color? plColor;

  const CachedNetworkImageWidget(
      {Key? key, required this.url, this.width, this.height, this.plColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (width == 0 && height == 0) {
      return CachedNetworkImage(
          placeholder: (context, url) {
            return Container(color: plColor ?? Colors.grey[200]);
          },
          errorWidget: (context, url, error) {
            return Container(color: Colors.grey[200]);
          },
          imageUrl: url,
          fit: BoxFit.fitWidth);
    } else if (height == 0) {
      return CachedNetworkImage(
          placeholder: (context, url) {
            return Container(width: width, color: plColor ?? Colors.grey[200]);
          },
          errorWidget: (context, url, error) {
            return Container(width: width, color: Colors.grey[200]);
          },
          imageUrl: url,
          fit: BoxFit.fitWidth,
          width: width);
    } else {
      return CachedNetworkImage(
          placeholder: (context, url) {
            return Container(
              width: width,
              height: height,
              color: plColor ?? Colors.grey[200],
            );
          },
          errorWidget: (context, url, error) {
            return Container(
                width: width, height: height, color: Colors.grey[200]);
          },
          imageUrl: url,
          fit: BoxFit.fitWidth,
          width: width,
          height: height);
    }
  }
}

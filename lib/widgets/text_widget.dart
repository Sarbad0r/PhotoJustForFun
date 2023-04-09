import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextDecoration? textDecoration;
  final TextOverflow? overFlow;
  final TextAlign? textAlign;

  const TextWidget(
      {Key? key,
      required this.text,
      this.size,
      this.color,
      this.fontWeight,
      this.maxLines,
      this.textDecoration,
      this.overFlow,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(
            color: color ?? Colors.black,
            fontSize: size ?? 14,
            fontWeight: fontWeight ?? FontWeight.normal,
            decoration: textDecoration,
            overflow: overFlow));
  }
}

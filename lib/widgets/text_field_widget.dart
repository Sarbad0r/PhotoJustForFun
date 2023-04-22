import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hintOrLableText;
  final Widget? childWiget;
  final bool hasPaddingAtStart;
  final Color? beforUnderLineColor;
  final Color? afterUnderLineColor;
  final List<TextInputFormatter>? textInputFormatter;
  final Color? textStyleColor;
  final Color? hintTextColor;
  final FontWeight? textStyleFontWeight;

  const TextFieldWidget(
      {Key? key,
      required this.controller,
      required this.textInputType,
      required this.hintOrLableText,
      required this.hasPaddingAtStart,
      this.childWiget,
      this.textInputFormatter,
      this.beforUnderLineColor,
      this.afterUnderLineColor,
      this.textStyleColor,
      this.hintTextColor,
      this.textStyleFontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: hasPaddingAtStart ? 30 : 0, right: 30),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          if (childWiget != null)
            Row(children: [
              childWiget!,
              const SizedBox(width: 20),
            ]),
          Expanded(
              child: TextField(
                  inputFormatters: textInputFormatter,
                  keyboardType: textInputType,
                  style: TextStyle(
                      color: textStyleColor ?? Colors.black,
                      fontWeight: textStyleFontWeight ?? FontWeight.normal),
                  controller: controller,
                  decoration: InputDecoration(
                      labelText: hintOrLableText,
                      labelStyle:
                          TextStyle(color: hintTextColor ?? Colors.black),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5,
                              color: beforUnderLineColor ?? Colors.grey)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.5,
                              color: afterUnderLineColor ?? Colors.black)))))
        ]));
  }
}

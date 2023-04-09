import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWithoutPaddings extends StatelessWidget {
  final TextEditingController controller;
  final List<TextInputFormatter>? textInputFormatters;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? hintText;
  final double? textSize;
  final double? hintTextSize;
  final Color? textColor;
  final Color? hintTextColor;
  final bool? autoFocus;
  final Widget? prefixIcon;

  const TextFieldWithoutPaddings({Key? key,
    required this.controller,
    this.textInputFormatters,
    this.focusNode,
    this.keyboardType,
    this.hintText,
    this.textSize,
    this.hintTextSize,
    this.textColor,
    this.hintTextColor,
    this.autoFocus, this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
        inputFormatters: textInputFormatters,
        focusNode: focusNode,
        controller: controller,
        autofocus: autoFocus ?? false,
        keyboardType: keyboardType,
        onSubmitted: (value) {},
        maxLines: 1,
        style: TextStyle(
            fontSize: textSize ?? 14, color: textColor ?? Colors.black),
        decoration: InputDecoration(
          // prefixIcon: Icon(Icons.search,
          //     color: Colors.grey[500], size: 18),
            prefixIcon: prefixIcon ?? null,
            contentPadding: const EdgeInsets.all(0),
            isDense: true,
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(5))),
            // filled: true,
            // fillColor: Colors.grey[200],
            hintStyle: TextStyle(
                color: hintTextColor ?? Colors.grey,
                fontSize: hintTextSize ?? 14),
            hintText: hintText ?? ''));
  }
}

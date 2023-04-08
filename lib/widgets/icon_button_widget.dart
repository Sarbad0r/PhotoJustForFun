import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback voidCallback;
  final IconData icon;
  final double? size;
  final Color? iconColor;

  const IconButtonWidget(
      {Key? key,
      required this.voidCallback,
      required this.icon,
      this.size,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: voidCallback,
        icon: Icon(icon, size: size ?? 25, color: iconColor));
  }
}

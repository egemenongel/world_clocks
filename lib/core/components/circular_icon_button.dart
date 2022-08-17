import 'package:world_clocks/core/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton(
      {Key? key,
      required this.iconData,
      required this.voidCallback,
      this.iconColor,
      this.backgroundColor})
      : super(key: key);
  final IconData iconData;
  final VoidCallback voidCallback;
  final Color? backgroundColor;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingNormal,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: backgroundColor != null
            ? backgroundColor!.withOpacity(0.2)
            : context.colors.onPrimary,
        child: CircleAvatar(
          backgroundColor: backgroundColor ?? context.colors.primary,
          radius: 20,
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(iconData),
            color: iconColor ?? context.colors.onPrimary,
            onPressed: voidCallback,
          ),
        ),
      ),
    );
  }
}

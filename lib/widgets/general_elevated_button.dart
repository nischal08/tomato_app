import 'package:flutter/material.dart';

import 'package:tomato_app/contants/color_properties.dart';

class GeneralElevatedButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color? fgColor;
  final onPressed;
  final double? borderRadius;
  final bool isDisabled;
  GeneralElevatedButton({
    Key? key,
    required this.title,
    required this.bgColor,
    this.fgColor,
    this.borderRadius,
    this.isDisabled = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
            isDisabled ? Theme.of(context).disabledColor : bgColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
      ),
      onPressed: isDisabled ? (){} : onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: fgColor ?? kColorWhiteText, fontWeight: FontWeight.bold),
      ),
    );
  }
}

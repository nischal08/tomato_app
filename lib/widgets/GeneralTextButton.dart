import 'package:flutter/material.dart';
import 'package:tomato_app/contants/color_properties.dart';

class GeneralTextButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color? fgColor;
  final onPressed;
  final double? borderRadius;
  GeneralTextButton({
    Key? key,
    required this.title,
    required this.bgColor,
    this.fgColor,
    this.onPressed,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(bgColor),
        side: MaterialStateProperty.all<BorderSide>(
          BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: Theme.of(context).textTheme.subtitle1!.copyWith(
            color: fgColor ?? kColorWhiteText, fontWeight: FontWeight.bold),
      ),
    );
  }
}

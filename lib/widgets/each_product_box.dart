import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';

class EachProductBox extends StatelessWidget {
  var _theme;
  final IconData? icon;
  final String? label;
  final onPressed;
  final bool isSelected;
  EachProductBox({
    this.icon,
    this.label,
    required this.onPressed,
    this.isSelected = false,
  });
  @override
  Widget build(BuildContext context) {
    _theme = Theme.of(context);
    return GestureDetector(
        onTap: onPressed,
        child: Container(
          height: 40,
          width: 38,
          alignment: Alignment.center,
          margin: EdgeInsets.only(right: 4),
          decoration: BoxDecoration(
            boxShadow: [kBoxShadowSmallBtn],
            borderRadius: BorderRadius.circular(10),
            color:
                isSelected ? Theme.of(context).accentColor : _theme.cardColor,
          ),
          child: icon != null
              ? Icon(
                  icon,
                  size: 18,
                  color: isSelected ? _theme.cardColor : kColorBlackText,
                )
              : Text(
                  label!,
                  style: GoogleFonts.lato(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? _theme.cardColor : kColorBlackText,
                  ),
                ),
        ));
  }
}


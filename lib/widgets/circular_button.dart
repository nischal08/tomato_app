import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_app/contants/color_properties.dart';

class CircularButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final onPressed;
  final Color? fgColor;

  const CircularButton(
      {Key? key,
      required this.title,
      required this.bgColor,
      this.onPressed,
      this.fgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      
      
      
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onPressed: onPressed,
      color: bgColor,
      child: Text(
        title,
        style: GoogleFonts.raleway(
          color: fgColor ?? kColorWhiteText,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
    );
  }
}

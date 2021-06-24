import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final onPressed;
  final Color? fgColor;

  const BuyButton(
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
      
      minWidth: 155,
      
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      onPressed: onPressed,
      color: bgColor,
      child: Text(
        title,
        style: GoogleFonts.raleway(
          color: fgColor ?? Theme.of(context).cardColor,
          fontWeight: FontWeight.w600,
          fontSize: 17,
        ),
      ),
    );
  }
}

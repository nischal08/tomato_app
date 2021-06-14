import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_app/constant/customColor.dart';

Widget BuyAddToCart(context,
    {required String title, required Color bgColor, required onPressed}) {
  return MaterialButton(
    height: 45,
    minWidth: 168,
    elevation: 5.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    onPressed: onPressed,
    color: bgColor,
    child: Text(
      title,
      style: GoogleFonts.raleway(
        color: Theme.of(context).cardColor,
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
    ),
  );
}

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
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? CustomColors.lightRed : _theme.cardColor,
          ),
          child: icon != null
              ? Icon(
                  icon,
                  size: 18,
                  color: isSelected
                      ? _theme.cardColor
                      : CustomColors.unselectedColor,
                )
              : Text(
                  label!,
                  style: GoogleFonts.raleway(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? _theme.cardColor
                        : CustomColors.unselectedColor,
                  ),
                ),
        ));
  }
}

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Function? onPressed;
  final double? paddingLeft;
  final double? paddingRight;

  var _themeData;
  CustomIcon(
      {this.onPressed,
      required this.icon,
      this.paddingLeft,
      this.paddingRight});
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: 50,
        height: 50,
      ),
      child: RawMaterialButton(
        elevation: 0.3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: _themeData.cardColor,
        onPressed: () {
          onPressed!();
        },
        child: Container(
          padding: EdgeInsets.only(
            left: paddingLeft ?? 0,
            right: paddingRight ?? 0,
          ),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

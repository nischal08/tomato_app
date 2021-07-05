import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final Function? onPressed;
  final double? paddingLeft;
  final double? paddingRight;
  final double? elevation;

  var _themeData;
  CustomIconButton({
    required this.icon,
    this.onPressed,
    this.paddingLeft,
    this.paddingRight,
    this.elevation,
  });
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: 50,
        height: 50,
      ),
      child: RawMaterialButton(
        elevation: elevation ?? 4,
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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tomato_app/contants/color_properties.dart';

BoxShadow kBoxShadowMeduimChipCard = BoxShadow(
    blurRadius: 1, spreadRadius: 0, offset: Offset(1, 2), color: Colors.grey);
BoxShadow kBoxShadowBigCard = BoxShadow(
    blurRadius: 2, spreadRadius: 1, offset: Offset(3, 2), color: Colors.grey);
BoxShadow kBoxShadowSmallBtn = BoxShadow(
    blurRadius: 0, spreadRadius: 0, offset: Offset(0.5, 1), color: Colors.grey);

const kSendButtonTextStyle = TextStyle(
  color: Colors.lightBlueAccent,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your value',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);
  InputDecoration kSearchBarDecoration = InputDecoration(
  enabled: true,
  fillColor: Colors.white,
  focusColor: Colors.white,
  filled: true,
  hintText: "Search",
  contentPadding: EdgeInsets.only(top: 5),
  hintStyle: TextStyle(
    color: kColorLightGrey,
  ),
  prefixIcon: Padding(
    padding: const EdgeInsets.only(left: 8.0),
    child: Icon(Icons.search),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(
      color: kColorLightGrey!,
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: kColorLightGrey!.withOpacity(0.8), width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: BorderSide(color: Colors.red, width: 1),
  ),
  // disabledBorder: OutlineInputBorder(
  //   borderRadius: BorderRadius.circular(15),
  //   borderSide: BorderSide(color: Theme.of(context).accentColor, width: 1.2),
  // ),
);
DecorationImage kGeneralBackgroundImage = DecorationImage(
  colorFilter: ColorFilter.mode(
    Colors.red,
    BlendMode.hue,
  ),
  fit: BoxFit.cover,
  image: AssetImage(
    "assets/images/background.jpg",
  ),
);

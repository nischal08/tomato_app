import 'package:flutter/material.dart';

class GeneralBackgroundImage extends StatelessWidget {
  const GeneralBackgroundImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.indigo,
            BlendMode.hue,
          ),
          fit: BoxFit.fitHeight,
          image: NetworkImage(
            "https://www.kolpaper.com/wp-content/uploads/2019/12/kawaii-food-wallpaper.jpg",
          ),
        ),
      ),
    );
  }
}

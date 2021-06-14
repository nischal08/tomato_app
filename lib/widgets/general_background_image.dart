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
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.indigo,
            BlendMode.hue,
          ),
          fit: BoxFit.cover,
          image: AssetImage(
            "assets/images/background.jpg",
          ),
        ),
      ),
    );
  }
}

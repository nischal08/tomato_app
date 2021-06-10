import 'package:flutter/material.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/widgets/GeneralElevatedButton.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.indigoAccent.withBlue(100),
              BlendMode.colorBurn,
            ),
            fit: BoxFit.fitHeight,
            image: NetworkImage(
              "https://www.kolpaper.com/wp-content/uploads/2019/12/kawaii-food-wallpaper.jpg",
            ),
          ),
        ),
        child: Column(
          children: [
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Food Delievery',
                  style: Theme.of(context)
                      .textTheme
                      .headline4!
                      .copyWith(color: kColorWhiteText),
                ),
                Text(
                  'We deliver food at any ponit of the Nepal in 30 minutes',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: kColorWhiteText),
                ),
                SizedBox(
                  height: 60,
                  child: GeneralElevatedButton(
                    // onPressed: () {},
                    title: "Log in",
                    fgColor: Theme.of(context).primaryColor,
                    bgColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 60,
                  child: GeneralElevatedButton(
                    // onPressed: () {},
                    title: "Sign up",
                    fgColor: Colors.white,
                    bgColor: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

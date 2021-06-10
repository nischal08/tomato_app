import 'package:flutter/material.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/widgets/GeneralBackgroundImage.dart';
import 'package:tomato_app/widgets/GeneralElevatedButton.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [GeneralBackgroundImage(), _infoBody(context)],
      ),
    );
  }

  Container _infoBody(BuildContext context) {
    return Container(
      color: Colors.black26.withOpacity(0.50),
      padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: Text(
              'Tomato',
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: kColorWhiteText),
            ),
          ),
          Spacer(),
          Text(
            'Food Delievery',
            style: Theme.of(context)
                .textTheme
                .headline4!
                .copyWith(color: kColorWhiteText),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'We deliver food at any ponit of the Nepal in 30 minutes',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: kColorWhiteText),
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 55,
            child: GeneralElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              title: "Log in",
              fgColor: Theme.of(context).primaryColor,
              bgColor: Colors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 55,
            child: GeneralElevatedButton(
              // onPressed: () {},

              title: "Sign up",
              fgColor: Colors.white,
              bgColor: Theme.of(context).primaryColor.withOpacity(0.95),
            ),
          )
        ],
      ),
    );
  }
}

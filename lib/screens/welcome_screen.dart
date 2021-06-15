import 'package:flutter/material.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/widgets/general_background_image.dart';
import 'package:tomato_app/widgets/general_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = "/";
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              GeneralBackgroundImage(),
              _infoBody(context),
            ],
          ),
        ),
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
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: kColorWhiteText,
                  ),
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
            'We deliver food at any point of the Nepal in 30 minutes',
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
              fgColor: Theme.of(context).primaryColorDark,
              bgColor: Colors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          SizedBox(
            height: 55,
            child: GeneralElevatedButton(
             onPressed: () {
                Navigator.pushNamed(context, '/register');
              },

              title: "Sign up",
              fgColor: Colors.white,
              bgColor: Theme.of(context).primaryColorDark,
            ),
          )
        ],
      ),
    );
  }
}

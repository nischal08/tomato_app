import 'package:flutter/material.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/widgets/GeneralBackgroundImage.dart';
import 'package:tomato_app/widgets/GeneralElevatedButton.dart';
import 'package:tomato_app/widgets/GeneralTextButton.dart';
import 'package:tomato_app/widgets/GeneralTextField.dart';
import 'package:tomato_app/widgets/curve_painter.dart';
import 'package:tomato_app/widgets/horizontal_line_between_word.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            GeneralBackgroundImage(),
            _body(context),
          ]),
        ),
      ),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      color: Colors.black26.withOpacity(0.50),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: Text(
                """Hello Again!
Welcome 
back """,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: kColorWhiteText),
              ),
            ),
          ),
          Container(
            // color: Colors.white,
            child: CustomPaint(
              painter: CurvePainter(),
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    GeneralTextField(
                      labelText: "Email Address",
                      obscureText: false,
                      preferIcon: Icons.email_outlined,
                      suffixIcon: null,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GeneralTextField(
                      labelText: "Password",
                      obscureText: true,
                      preferIcon: Icons.lock_outline,
                      suffixIcon: null,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Forgot password?",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Theme.of(context).primaryColorDark),
                      textAlign: TextAlign.end,
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
                        bgColor: Theme.of(context).primaryColor,
                        fgColor: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    HorizontalLineBetweenWord(label: "or", height: 40),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 55,
                      child: GeneralTextButton(
                        // onPressed: () {},

                        title: "Sign up",
                        bgColor: Colors.white,
                        fgColor:
                            Theme.of(context).primaryColor.withOpacity(0.95),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

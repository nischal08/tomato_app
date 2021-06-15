import 'package:flutter/material.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/screens/login_screen.dart';
import 'package:tomato_app/widgets/curve_painter_register.dart';
import 'package:tomato_app/widgets/general_background_image.dart';
import 'package:tomato_app/widgets/general_elevated_button.dart';
import 'package:tomato_app/widgets/general_text_button.dart';
import 'package:tomato_app/widgets/general_textfield.dart';
import 'package:tomato_app/widgets/horizontal_line_between_word.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          SingleChildScrollView(child: GeneralBackgroundImage()),
          SingleChildScrollView(child: _body(context)),
        ]),
      ),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black26.withOpacity(0.50),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: SizedBox(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
            child: Text(
              """Create 
Account """,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: kColorWhiteText),
            ),
          ),
          Container(
            // color: Colors.white,
            child: CustomPaint(
              painter: CurvePainterRegister(),
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    GeneralTextField(
                      labelText: "Name",
                      obscureText: false,
                      preferIcon: Icons.person_outline,
                      suffixIcon: null,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GeneralTextField(
                      labelText: "Email",
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
                      height: 40,
                    ),
                    SizedBox(
                      height: 55,
                      child: GeneralElevatedButton(
                        onPressed: () {
                          //This where you submit the form for register
                        },
                        title: "Sign up",
                        bgColor:  Theme.of(context).primaryColorDark,
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
                        onPressed: () {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        },
                        title: "Log in",
                        bgColor: Colors.white,
                        fgColor:
                             Theme.of(context).primaryColorDark,
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

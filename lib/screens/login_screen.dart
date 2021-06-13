import 'package:flutter/material.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/screens/register_screen.dart';
import 'package:tomato_app/widgets/general_background_image.dart';
import 'package:tomato_app/widgets/general_text_button.dart';
import 'package:tomato_app/widgets/general_textfield.dart';
import 'package:tomato_app/widgets/curve_painter_login.dart';
import 'package:tomato_app/widgets/horizontal_line_between_word.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool changebuttonAnimation = false;

  void _onClickLoginBtn() {
    setState(() {
      changebuttonAnimation = true;
    });
  }

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
            _body(context, changebuttonAnimation),
          ]),
        ),
      ),
    );
  }

  Container _body(BuildContext context, bool changebuttonAnimation) {
    return Container(
      color: Colors.black26.withOpacity(0.50),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: SizedBox(),
          ),
          Padding(
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
          Container(
            // color: Colors.white,
            child: CustomPaint(
              painter: CurvePainterLogin(),
              child: Padding(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: Column(
                  crossAxisAlignment: changebuttonAnimation
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 60,
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
                    Row(
                      children: [
                        Spacer(),
                        Text(
                          "Forgot password?",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(
                                  color: Theme.of(context).primaryColorDark),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Material(
                      borderRadius:
                          BorderRadius.circular(changebuttonAnimation ? 50 : 8),
                      color: Theme.of(context).primaryColor,
                      child: InkWell(
                        onTap: () => _onClickLoginBtn(),
                        child: AnimatedContainer(
                          alignment: Alignment.center,
                          duration: Duration(seconds: 2),
                          height: 55,
                          width: changebuttonAnimation ? 55 :250,
                          child: changebuttonAnimation
                              ? Icon(
                                  Icons.check,
                                  color: Colors.white,
                                )
                              : Text(
                                  "Log in",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                          color: kColorWhiteText,
                                          fontWeight: FontWeight.w600),
                                ),
                        ),
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
                      width: double.infinity,
                      child: GeneralTextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RegisterScreen.routeName);
                        },
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

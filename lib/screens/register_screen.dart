import 'package:flutter/material.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/screens/home.dart';
import 'package:tomato_app/screens/login_screen.dart';
import 'package:tomato_app/widgets/curve_painter_register.dart';
import 'package:tomato_app/widgets/general_elevated_button.dart';
import 'package:tomato_app/widgets/general_text_button.dart';
import 'package:tomato_app/widgets/general_textfield.dart';
import 'package:tomato_app/widgets/horizontal_line_between_word.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailController;
  late TextEditingController _nameController;
  late TextEditingController _passwordController;
  bool changebuttonAnimation = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  bool showSpinner = false;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  Future<void> _submit() async {
    // setState(() {
    //   changebuttonAnimation = true;
    // });

    setState(() {
      showSpinner = true;
    });
    await Future.delayed(
      Duration(seconds: 2),
    );

    Navigator.pushNamed(context, HomeScreen.routeName);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 1500),
        backgroundColor: Colors.white.withOpacity(0.9),
        content: Container(
          height: 60,
          alignment: Alignment.center,
          child: Text(
            "You have been registered. Welcome Unknown User",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Theme.of(context).accentColor,
                ),
          ),
        ),
      ),
    );
    setState(() {
      showSpinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
              image: kGeneralBackgroundImage,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: showSpinner
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  )
                // : Text(
                //     "Register",
                //   )
            : _body(context),
            ),
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
                      onSave: (value) {
                        //Save it
                      },
                      focusNode: _nameFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _authData['name'] = value;
                      },
                      keywordType: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Name is empty';
                        }
                      },
                      onClickPsToggle: () {},
                      controller: _nameController,
                      labelText: "Name",
                      obscureText: false,
                      preferIcon: Icons.person_outline,
                      suffixIcon: null,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GeneralTextField(
                      onSave: (value) {
                        //Save it
                      },
                      focusNode: _emailFocusNode,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        _authData['email'] = value;
                      },
                      keywordType: TextInputType.emailAddress,
                      validate: (String value) {
                        if (value.isEmpty || !value.contains("@")) {
                          return 'Invalid email!';
                        }
                      },
                      onClickPsToggle: () {},
                      controller: _emailController,
                      labelText: "Email",
                      obscureText: false,
                      preferIcon: Icons.email_outlined,
                      suffixIcon: null,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GeneralTextField(
                      onSave: (value) {
                        //Save it
                      },
                      focusNode: _passwordFocusNode,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        _authData['password'] = value;
                      },
                      keywordType: TextInputType.visiblePassword,
                      validate: (String value) {
                        if (value.isEmpty || value.length < 5) {
                          return 'Password is too short';
                        }
                      },
                      onClickPsToggle: () {},
                      controller: _passwordController,
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
                        onPressed: _submit,
                        title: "Sign up",
                        bgColor: Theme.of(context).primaryColorDark,
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
                        fgColor: Theme.of(context).primaryColorDark,
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/controller/auth.dart';
import 'package:tomato_app/screens/login_screen.dart';
import 'package:tomato_app/widgets/curve_painter_register.dart';
import 'package:tomato_app/widgets/general_elevated_button.dart';
import 'package:tomato_app/widgets/general_text_button.dart';
import 'package:tomato_app/widgets/general_textfield.dart';
import 'package:tomato_app/widgets/straightLine_betw_word.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool changebuttonAnimation = false;
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _fnFocusNode = FocusNode();
  final FocusNode _lnFocusNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey();

  bool showSpinner = false;
  Map<String, String> _authData = {
    'fn': '',
    'ls': '',
    'email': '',
    'password': '',
  };

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  _onSubmit() {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    print("onSubmit form Login page !!!!");
    print(_authData);
    Provider.of<Auth>(context, listen: false).registerUser( 
      context,
      email: _authData['email']!,
      password: _authData['password']!,
      firstname: _authData['fn']!,
      lastname: _authData['ln']!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: kGeneralBackgroundImage,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Consumer<Auth>(
            builder: (_, auth, __) => auth.showRegisterSpinner
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  )
                : _body(context),
          ),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      GeneralTextField(
                        onSave: (value) {
                          _authData['fn'] = value;
                        },
                        focusNode: _fnFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmit: (value) {
                          _fieldFocusChange(
                              context, _fnFocusNode, _lnFocusNode);
                        },
                        keywordType: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'First name is empty';
                          }
                        },
                        onClickPsToggle: null,
                        labelText: "First Name",
                        obscureText: false,
                        preferIcon: Icons.person_outline,
                        suffixIcon: null,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GeneralTextField(
                        onSave: (value) {
                          _authData['ln'] = value;
                        },
                        focusNode: _lnFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmit: (value) {
                          _fieldFocusChange(
                              context, _lnFocusNode, _emailFocusNode);
                        },
                        keywordType: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Last name is empty';
                          }
                        },
                        onClickPsToggle: null,
                        labelText: "Last Name",
                        obscureText: false,
                        preferIcon: Icons.person_outline,
                        suffixIcon: null,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GeneralTextField(
                        onSave: (value) {
                          _authData['email'] = value;
                        },
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmit: (value) {
                          _fieldFocusChange(
                              context, _emailFocusNode, _passwordFocusNode);
                        },
                        keywordType: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty || !value.contains("@")) {
                            return 'Invalid email!';
                          }
                        },
                        onClickPsToggle: null,
                        labelText: "Email Address",
                        obscureText: false,
                        preferIcon: Icons.email_outlined,
                        suffixIcon: null,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GeneralTextField(
                        onSave: (value) {
                         _authData['password'] = value;
                        },
                        focusNode: _passwordFocusNode,
                        textInputAction: TextInputAction.done,
                        onFieldSubmit: (value) {
                         _passwordFocusNode.unfocus();
                          _onSubmit();
                        },
                        keywordType: TextInputType.visiblePassword,
                        validate: (String value) {
                          if (value.isEmpty || value.length < 5) {
                            return 'Password is too short';
                          }
                        },
                        onClickPsToggle: null,
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
                          onPressed: _onSubmit,
                          title: "Sign up",
                          bgColor: Theme.of(context).primaryColorDark,
                          fgColor: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      StraightLineBetwWord(label: "or", height: 40),
                      SizedBox(
                        height: 8,
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
          ),
        ],
      ),
    );
  }
}

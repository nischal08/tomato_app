import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/contants/constant.dart';
import 'package:tomato_app/controller/auth_controller.dart';
import 'package:tomato_app/screens/register_screen.dart';
import 'package:tomato_app/widgets/general_text_button.dart';
import 'package:tomato_app/widgets/general_textfield.dart';
import 'package:tomato_app/widgets/curve_painter_login.dart';
import 'package:tomato_app/widgets/horizontal_line_between_word.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool passwordVisibility = false;
  bool changebuttonAnimation = false;
 

  void onTogglePasswordVisibility() {
    print("password visbilty !!!");
    passwordVisibility = !passwordVisibility;
    setState(() {});
  }

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
    Provider.of<AuthController>(context, listen: false).loginUser(
      context,
      email: _authData['email']!,
      password: _authData['password']!,
    );
  }

  @override
  Widget build(BuildContext context) {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: kGeneralBackgroundImage,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: 
          
           Consumer<AuthController>(
             builder: (_, auth, __) => 
             auth.showLoginSpinner
                ? Center(
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  )
                : _body(
                    context,
                  ),
           ),
        ),
      ),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      color: Colors.black26.withOpacity(0.50),
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    // crossAxisAlignment: auth.changebuttonAnimation
                    //     ? CrossAxisAlignment.center :
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 60,
                      ),
                      GeneralTextField(
                        onSave: (String value) {
                          print(value);
                          _authData['email'] = value;
                        },
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: () {
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
                        // controller: _emailController,
                        labelText: "Email Address",
                        obscureText: false,
                        preferIcon: Icons.email_outlined,
                        suffixIcon: null,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                     GeneralTextField(
                          onSave: (String value) {
                            _authData['password'] = value;
                          },
                          focusNode: _passwordFocusNode,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (value) {
                            _passwordFocusNode.unfocus();
                            _onSubmit();
                          },
                          keywordType: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty || value.length < 5) {
                              return 'Password is too short';
                            }
                          },
                          // controller: _passwordController,
                          labelText: "Password",
                          obscureText: passwordVisibility ? false : true,
                          preferIcon: Icons.lock_outline,
                          onClickPsToggle: onTogglePasswordVisibility,
                          suffixIcon: passwordVisibility
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
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
                        borderRadius: BorderRadius.circular(
                            // auth.changebuttonAnimation ? 50 :
                            8),
                        color: Theme.of(context).primaryColorDark,
                        child: InkWell(
                          onTap: _onSubmit,
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: Duration(seconds: 2),
                            height: 55,
                            width:
                                // auth.changebuttonAnimation ? 55 :
                                250,
                            child:
                                // auth.changebuttonAnimation
                                //     ? Icon(
                                //         Icons.check,
                                //         color: Colors.white,
                                //       )
                                //     :
                                Text(
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

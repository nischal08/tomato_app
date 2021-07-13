import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/auth_controller.dart';
import 'package:tomato_app/widgets/general_elevated_button.dart';
import 'package:tomato_app/widgets/general_text_button.dart';
import 'package:tomato_app/widgets/general_textfield.dart';

class VerificationScreen extends StatelessWidget {
  static const routeName = "register/verfication";
  late String userMail;
  late String verificationCode;

  late AuthController _authController;

  void _onSubmit() {}

  @override
  Widget build(BuildContext context) {
    userMail = ModalRoute.of(context)!.settings.arguments as String;
    // print(number + "userId" + userRegisteredId);
    _authController = Provider.of<AuthController>(context);
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom,
        margin: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              _backBtn(context),
              _otpImage(),
              SizedBox(
                height: 20,
              ),
              _otpInfoAndTextField(context),
            ],
          ),
        ),
      ),
    );
  }

  Column _otpInfoAndTextField(context) {
    return Column(
      children: [
        Text(
          "Email Verification",
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: kColorBlackText,
              ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          // width: MediaQuery.of(context).size.width*0.80,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter the Verification Code sent to ",
                // softWrap: false,
                // style: Theme.of(context).textTheme.subtitle2,
              ),
              Text(
                userMail,
                style: TextStyle(fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _otpTextField(context),
        SizedBox(
          height: 30,
        ),
        _sendBtn(context),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  SizedBox _sendBtn(context) {
    return SizedBox(
      height: 55,
      width: double.infinity,
      child: GeneralElevatedButton(
        onPressed: _onSubmit,
        title: "Send",
        fgColor: Colors.white,
        bgColor: Theme.of(context).primaryColorDark,
      ),
    );
  }

  Widget _otpTextField(context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: GeneralTextField(
          onSave: (String value) {
            verificationCode = value;
          },
          focusNode: null,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) {
            // _onSubmit();
          },
          keywordType: TextInputType.text,
          validate: (String value) {
            if (value.isEmpty || value.length < 5) {
              return 'Password is too short';
            }
          },
          // controller: _passwordController,
          labelText: "Verification Code",
          obscureText: false,
          preferIcon: Icons.vpn_key_outlined,
          onClickPsToggle: null,
          suffixIcon: null,
        ),
      ),
    );
  }

  Widget _backBtn(context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: CircleAvatar(
        child: Icon(Icons.arrow_back),
      ),
    );
  }
}

Widget _otpImage() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Image.asset(
      "assets/images/message.png",
    ),
  );
}

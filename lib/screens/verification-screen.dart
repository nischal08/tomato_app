import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/contants/color_properties.dart';
import 'package:tomato_app/controller/auth.dart';
import 'package:tomato_app/widgets/general_elevated_button.dart';
import 'package:tomato_app/widgets/general_text_button.dart';
import 'package:tomato_app/widgets/general_textfield.dart';

class VerificationScreen extends StatelessWidget {
  static const routeName = "register/verfication";
  late Map _userCredential;
  late String verificationCode;
  late FocusNode _codeFocusNode;

  final GlobalKey<FormState> _formKey = GlobalKey();
  void _onSubmit(context) {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    Provider.of<Auth>(context, listen: false).verifyUser(
      context,
      password: _userCredential['password']!.trim(),
      email: _userCredential['email']!.trim(),
      code: verificationCode.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    _codeFocusNode = FocusNode();
    _userCredential =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    // print(number + "userId" + userRegisteredId);
    return Scaffold(
      body: Provider.of<Auth>(context).showVerifyCodeSpinner
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _body(context),
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
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: kColorBlackText, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 25,
        ),
        Container(
          // width: MediaQuery.of(context).size.width*0.80,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter the Verification Code sent to ",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                _userCredential["email"],
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Form(
          key: _formKey,
          child: _otpTextField(context),
        ),
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
        onPressed: () => _onSubmit(context),
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
          focusNode: _codeFocusNode,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) {
            _codeFocusNode.unfocus();
            _onSubmit(context);
          },
          keywordType: TextInputType.text,
          validate: (String value) {
            if (value.isEmpty || value.length < 20) {
              return 'Code is too short';
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

import 'package:flutter/material.dart';
import 'package:tomato_app/widgets/GeneralBackgroundImage.dart';
import 'package:tomato_app/widgets/GeneralTextField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
     
     GeneralBackgroundImage(),
        _body(context),
      ]),
    );
  }

  SafeArea _body(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              """Hello Again!
Welcome 
back """,
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
            SizedBox(
              height: 30,
            ),
            GeneralTextField(),
            SizedBox(
              height: 30,
            ),
            GeneralTextField(),
            SizedBox(
              height: 30,
            ),
            GeneralTextField(),
          ],
        ),
      ),
    );
  }
}

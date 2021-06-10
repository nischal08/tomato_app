import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tomato_app/screens/login_screen.dart';
import 'package:tomato_app/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tomato',
      theme: ThemeData(
        fontFamily: GoogleFonts.lato().fontFamily,
        textTheme: TextTheme(
          overline: TextStyle(color: Colors.black),
          caption: TextStyle(color: Colors.black),
          button: TextStyle(color: Colors.black),
          bodyText1: TextStyle(color: Colors.black),
          bodyText2: TextStyle(color: Colors.black),
          subtitle1: TextStyle(color: Colors.black, fontSize: 18),
          subtitle2: TextStyle(color: Colors.black, fontSize: 16),
          headline6: TextStyle(color: Colors.black),
          headline5: TextStyle(color: Colors.black),
          headline4: TextStyle(color: Colors.black),
          headline3: TextStyle(color: Colors.black),
          headline2: TextStyle(color: Colors.black),
          headline1: TextStyle(color: Colors.black),
        ),
        primarySwatch: Colors.indigo,
        accentColor: Colors.deepOrangeAccent
      ),
      routes: {
        "/": (context) => WelcomeScreen(),
        "/login": (context) => LoginScreen(),
      },
    );
  }
}

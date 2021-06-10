import 'package:flutter/material.dart';
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
        
        primarySwatch: Colors.blue,
      ),
      home:WelcomeScreen(),
    );
  }
}


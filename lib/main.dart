import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tomato_app/controller/auth_controller.dart';
import 'package:tomato_app/controller/food_controller.dart';
import 'package:tomato_app/screens/cart_screen.dart';
import 'package:tomato_app/screens/food_screen.dart';
import 'package:tomato_app/screens/home.dart';
import 'package:tomato_app/screens/login_screen.dart';
import 'package:tomato_app/screens/product_detail_screen.dart';
import 'package:tomato_app/screens/register_screen.dart';
import 'package:tomato_app/screens/restaurant_list_screen.dart';
import 'package:tomato_app/screens/restaurant_menu.dart';
import 'package:tomato_app/screens/welcome_screen.dart';

import 'controller/home_controller.dart';
import 'controller/carts.dart';
import 'controller/product_detail_controller.dart';
import 'controller/products.dart';
import 'controller/restaurant_controller.dart';

void main() {
  runApp(MyApp());

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.purple,
  // ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => RestaurantController(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductDetailController(),
        ),
        ChangeNotifierProvider(
          create: (_) => Carts(),
        ),
        ChangeNotifierProvider(
          create: (_) => FoodController(),
        ),
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tomato',
        theme: ThemeData(
          cardColor: Colors.white,
          canvasColor: Color(0xFFF6F6F8),
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
          primarySwatch: Colors.red,
          accentColor: Colors.deepOrangeAccent,
        ),
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          CartScreen.routeName:(context)=>CartScreen(),
          RestaurantMenu.routeName:(context)=>RestaurantMenu(),
          RestaurantListScreen.routeName:(context)=>RestaurantListScreen(),
          ProductDetailScreen.routeName:(context)=>ProductDetailScreen(),
          FoodScreen.routeName:(context)=>FoodScreen()
        },
      ),
    );
  }
}

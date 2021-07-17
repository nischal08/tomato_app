import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tomato_app/controller/auth.dart';
import 'package:tomato_app/screens/cart_screen.dart';
import 'package:tomato_app/screens/food_screen.dart';
import 'package:tomato_app/screens/home.dart';
import 'package:tomato_app/screens/login_screen.dart';
import 'package:tomato_app/screens/product_detail_screen.dart';
import 'package:tomato_app/screens/register_screen.dart';
import 'package:tomato_app/screens/restaurant_list_screen.dart';
import 'package:tomato_app/screens/restaurant_menu.dart';
import 'package:tomato_app/screens/verification-screen.dart';
import 'package:tomato_app/screens/welcome_screen.dart';

import 'controller/carts.dart';
import 'controller/home_controller.dart';
import 'controller/product_detail_controller.dart';
import 'controller/products.dart';
import 'controller/restaurants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? accessToken = sharedPreferences.getString("accessToken");
  print(accessToken);
  runApp(
    MyApp(
      shoudShowOnboardingPage: accessToken == null ? true : false,
    ),
  );

  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.purple,
  // ));
}

class MyApp extends StatelessWidget {
  final bool? shoudShowOnboardingPage;
  const MyApp({
    Key? key,
    required this.shoudShowOnboardingPage,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeController(),
        ),
        ChangeNotifierProvider(
          create: (_) => Restaurants(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductDetailController(),
        ),
        ChangeNotifierProvider(
          create: (_) => Carts(),
        ),
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Auth(),
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
        initialRoute: shoudShowOnboardingPage!
            ? WelcomeScreen.routeName
            : HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (context) => HomeScreen(),
          WelcomeScreen.routeName: (context) => WelcomeScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          RestaurantMenu.routeName: (context) => RestaurantMenu(),
          RestaurantListScreen.routeName: (context) => RestaurantListScreen(),
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          FoodScreen.routeName: (context) => FoodScreen(),
          VerificationScreen.routeName: (context) => VerificationScreen(),
        },
      ),
    );
  }
}

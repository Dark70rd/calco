import 'package:flutter/material.dart';

final ThemeData appThemeData = ThemeData(
  // Define your theme here
  useMaterial3: true,
  //colorScheme: Colors.grey[900],
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  //primaryColor: Colors.black,
  visualDensity: VisualDensity.adaptivePlatformDensity,

  //textTheme: const TextTheme(
  //  bodyText1: TextStyle(color: Colors.white),
  //  bodyText2: TextStyle(color: Colors.white),
  //  headline1: TextStyle(color: Colors.white),
  //  headline2: TextStyle(color: Colors.white),
  //  headline3: TextStyle(color: Colors.white),
  //  headline4: TextStyle(color: Colors.white),
  //  headline5: TextStyle(color: Colors.white),
  //  headline6: TextStyle(color: Colors.white),
  //  subtitle1: TextStyle(color: Colors.white),
  //  subtitle2: TextStyle(color: Colors.white),
  //  caption: TextStyle(color: Colors.white),
  //  button: TextStyle(color: Colors.white),
  //  overline: TextStyle(color: Colors.white),
  //),
);

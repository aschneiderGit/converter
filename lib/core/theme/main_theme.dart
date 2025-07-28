import 'package:flutter/material.dart';

ThemeData mainTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.blueGrey[800],
    foregroundColor: Colors.blueGrey[800],
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blueGrey[600],
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: Colors.black),
    headlineMedium: TextStyle(color: Colors.blueGrey[800], fontSize: 24),
  ),
  brightness: Brightness.light,
);

import 'package:flutter/material.dart';

final bytebankTheme = ThemeData(
  primaryColor: Colors.green[900],
  appBarTheme: AppBarTheme(color: Colors.green[900]),
  //primarySwatch não aceita Colors.green[900]. Somente Colors.green
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.blueAccent[700],
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    primary: Colors.blueAccent[700],
  )),
  buttonTheme: ButtonThemeData(
      buttonColor: Colors.blueAccent[700], textTheme: ButtonTextTheme.normal),
);

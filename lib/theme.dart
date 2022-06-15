import 'package:flutter/material.dart';

final kLightTheme = ThemeData(
  primaryColor: const Color.fromRGBO(238, 238, 238, 1),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color.fromRGBO(144, 188, 218, 1.0)),
  textTheme: const TextTheme(
    titleLarge: TextStyle(color: Color.fromRGBO(58, 56, 57, 1.0), fontSize: 55),
    titleMedium: TextStyle(color: Color.fromRGBO(58, 56, 57, 1.0)),
    titleSmall: TextStyle(color: Color.fromRGBO(58, 56, 57, 1.0)),
    bodyLarge: TextStyle(color: Color.fromRGBO(58, 56, 57, 1.0)),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromRGBO(240, 208, 169, 1.0),
    foregroundColor: Color.fromRGBO(58, 56, 57, 1.0),
    titleTextStyle: TextStyle(color: Color.fromRGBO(58, 56, 57, 1.0),
  )
  )
);

const kAppBarTitleTheme = TextStyle(color: Color.fromRGBO(58, 56, 57, 1.0), fontSize: 25);

final kButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(123, 173, 156, 1.0)),
  textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
);
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      scaffoldBackgroundColor: Color(0xFF14279A),
      primaryColor: Color(0xFF0B27EA),
      buttonColor: Color(0xFF05158A),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Color(0xFF05158A),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(40.0),
            ),
          )
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.white),
        bodyText2: TextStyle(color: Colors.white),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
              primary: Colors.white
          )
      ),
    );
  }
}
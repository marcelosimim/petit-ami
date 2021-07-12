import 'package:flutter/material.dart';
import 'package:petitami/screens/splash_screen.dart';
import 'package:petitami/theme/theme.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: AppTheme.mainTheme));
}

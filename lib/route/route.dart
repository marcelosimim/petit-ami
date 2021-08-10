import 'package:flutter/material.dart';
import 'package:petitami/screens/account_configuration.dart';
import 'package:petitami/screens/exercise.dart';
import 'package:petitami/screens/home.dart';
import 'package:petitami/screens/home_content.dart';
import 'package:petitami/screens/initial.dart';
import 'package:petitami/screens/login.dart';
import 'package:petitami/screens/register.dart';
import 'package:petitami/screens/splash_screen.dart';
import 'package:petitami/screens/unit.dart';

const String splashScreen = 'splash_screen';
const String initialPage = 'initial';
const String loginPage = 'login';
const String registerPage = 'register';
const String homePage = 'home';
const String homeContentPage = 'home_content';
const String unitPage = 'unit';
const String exercisePage = 'exercise';
const String accountConfigPage = 'account_config';

Route<dynamic> controller(RouteSettings setting){

  switch(setting.name){
    case splashScreen:
      return MaterialPageRoute(builder: (context) => SplashScreen());
    case initialPage:
      return MaterialPageRoute(builder: (context) => Initial());
    case loginPage:
      return MaterialPageRoute(builder: (context) => Login());
    case registerPage:
      return MaterialPageRoute(builder: (context) => Register());
    case homePage:
      return MaterialPageRoute(builder: (context) => Home());
    case homeContentPage:
      return MaterialPageRoute(builder: (context) => HomeContent());
    case unitPage:
      return MaterialPageRoute(builder: (context) => Unit());
    case exercisePage:
      return MaterialPageRoute(builder: (context) => Exercise());
    case accountConfigPage:
      return MaterialPageRoute(builder: (context) => AccountConfiguration());
    default:
      throw ('PAGE NOT FOUND!');
  }
}


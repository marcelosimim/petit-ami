import 'package:flutter/material.dart';
import 'package:petitami/screens/splash_screen.dart';
import 'package:petitami/theme/theme.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petitami/route/route.dart' as route;

import 'models/user_model.dart';

/*void main() async {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: AppTheme.mainTheme));
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
            theme: AppTheme.mainTheme,
            onGenerateRoute: route.controller,
            initialRoute: route.splashScreen,
        ));
  }
}

/*void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return ScopedModel<UserModel>(
            model: UserModel(),
            child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: SplashScreen(),
                theme: AppTheme.mainTheme));
      },
      future: Firebase.initializeApp(),
    );
  }
}*/

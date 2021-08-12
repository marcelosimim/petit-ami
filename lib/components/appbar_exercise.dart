import 'package:flutter/material.dart';
import 'package:petitami/route/route.dart' as route;

AppBar appbar_exercise(BuildContext context){
  return AppBar(
    title: Image.asset('assets/images/logo.png',
        fit: BoxFit.contain, height: 60),
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, route.homePage);
        },
        icon: Icon(Icons.exit_to_app), color: Colors.red,)
    ],
  );
}


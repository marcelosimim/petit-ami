import 'package:flutter/material.dart';

AppBar appbar(){
  return AppBar(
    title: Image.asset('assets/images/logo.png',
        fit: BoxFit.contain, height: 60),
    centerTitle: true,
  );
}


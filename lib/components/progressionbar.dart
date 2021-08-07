import 'package:flutter/material.dart';

LinearProgressIndicator linearProgressIndicator(int userCurrentUnity){
  return LinearProgressIndicator(
    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2440FF)),
    backgroundColor: Colors.redAccent,
    value: userCurrentUnity/96,
    minHeight: 40,
  );
}
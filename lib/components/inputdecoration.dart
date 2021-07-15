import 'package:flutter/material.dart';

InputDecoration textFormFieldInputDecoration(Icon icon){
  return InputDecoration(
    prefixIcon: icon,
    helperText: ' ',
    filled: true,
    fillColor: Color(0xFF05158A),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.blue),
        borderRadius: BorderRadius.circular(15)),
    enabledBorder: OutlineInputBorder(
        borderSide:
        BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(15)),
  );
}
import 'package:flutter/material.dart';

class FrenchLevel{

  int? _level;

  FrenchLevel(int? level){
    this._level = level;
  }

  String getLevel(){
      if(_level! <= 36){
          return 'Básico';
      }else if(_level! <= 71){
        return 'Intermediário';
      }else{
        return 'Avançado';
      }
  }

  int getBook(){
      if(_level! <= 4){
          return 1;
      }else if(_level! <= 8){
        return 2;
      }else if(_level! <= 12){
        return 3;
      }else if(_level! <= 16){
        return 4;
      }else if(_level! <= 20){
        return 5;
      }else if(_level! <= 24){
        return 6;
      }else if(_level! <= 28){
        return 7;
      }else if(_level! <= 32){
        return 8;
      }else if(_level! <= 36){
        return 9;
      }else if(_level! <= 40){
        return 10;
      }else{
        return 11;
      }
  }
}
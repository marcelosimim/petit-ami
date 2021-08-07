import 'package:flutter/material.dart';

class FrenchLevel{

  int? _level;

  FrenchLevel(int level){
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
}
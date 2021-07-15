import 'package:flutter/material.dart';

class RegisterFunctions{

  bool _languageControl = true;
  String _emailQuestion = "Entrer l'email:";
  String _nameQuestion = 'Insérez votre nom:';
  String _passwordQuestion = 'Entrer un mot de passe: ';
  String _passwordConfirmationQuestion = 'Confirmez le mot de passe: ';

  String get emailQuestion => _emailQuestion;
  String get nameQuestion => _nameQuestion;
  String get passwordQuestion => _passwordQuestion;
  String get passwordConfirmationQuestion => _passwordConfirmationQuestion;
  bool get languageControl => _languageControl;

  void translate(){
    if (_languageControl) {
      _emailQuestion = 'Insira o email:';
      _nameQuestion = 'Insira seu nome:';
      _passwordQuestion = 'Insira uma senha:';
      _passwordConfirmationQuestion = 'Confirme a senha:';
      _languageControl = false;
    } else {
      _emailQuestion = "Entrer l'email:";
      _nameQuestion = 'Insérez votre nom:';
      _passwordQuestion = 'Entrer un mot de passe: ';
      _passwordConfirmationQuestion =
      'Confirmez le mot de passe: ';
      _languageControl = true;
    }
  }
}
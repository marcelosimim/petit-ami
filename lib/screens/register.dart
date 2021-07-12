import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/components/AppBar.dart';

import 'home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _languageControl = true;
  String _emailQuestion = "Entrer l'email:";
  String _nameQuestion = 'Insérez votre nom:';
  String _passwordQuestion = 'Entrer un mot de passe: ';
  String _passwordConfirmationQuestion = 'Confirmez le mot de passe: ';
  String? _password;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: header(),
        body: Form(
            key: _formKey,
            child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          translate();
                        });
                      },
                      child: Text('Clique aqui para traduzir',
                          style: GoogleFonts.imprima(fontSize: 15)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100),
                      child: Text(_emailQuestion,
                          style: GoogleFonts.imprima(fontSize: 20)),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        width: 300,
                        height: 60,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 15),
                          //controller: null,
                          decoration: InputDecoration(
                            helperText: ' ',
                            filled: true,
                            fillColor: Color(0xFF05158A),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Campo obrigatório';
                            } else if (EmailValidator.validate(value)) {
                              print(value);
                              return null;
                            }
                            return 'Email inválido!';
                          },
                        ),
                      ),
                    ),
                    Text(_nameQuestion,
                        style: GoogleFonts.imprima(fontSize: 20)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Container(
                        width: 300,
                        height: 60,
                        child: TextFormField(
                          style: TextStyle(fontSize: 15),
                          //controller: null,
                          decoration: InputDecoration(
                            helperText: ' ',
                            filled: true,
                            fillColor: Color(0xFF05158A),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Text(_passwordQuestion,
                        style: GoogleFonts.imprima(fontSize: 20)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Container(
                        width: 300,
                        height: 60,
                        child: TextFormField(
                          obscureText: true,
                          style: TextStyle(fontSize: 15),
                          //controller: null,
                          decoration: InputDecoration(
                            helperText: ' ',
                            filled: true,
                            fillColor: Color(0xFF05158A),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (value) {
                            _password = value;
                            if (value == null || value == '') {
                              return 'Campo obrigatório';
                            } else if (value.length < 8) {
                              return 'Insira pelo menos 8 caracteres';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Text(_passwordConfirmationQuestion,
                        style: GoogleFonts.imprima(fontSize: 20)),
                    Padding(
                      padding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Container(
                        width: 300,
                        height: 60,
                        child: TextFormField(
                          obscureText: true,
                          style: TextStyle(fontSize: 15),
                          //controller: null,
                          decoration: InputDecoration(
                            helperText: ' ',
                            filled: true,
                            fillColor: Color(0xFF05158A),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          validator: (value) {
                            if (value == null || value == '') {
                              return 'Campo obrigatório';
                            } else if (value != _password) {
                              print(_password);
                              return 'As senhas não coincidem';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Home()));
                          } else {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => Home()));
                            print('ixi');
                          }
                        },
                        child: Text('ENVIAR'))
                  ],
                ))));
  }
}

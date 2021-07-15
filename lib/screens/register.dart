import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/components/appbar.dart';
import 'package:petitami/components/inputdecoration.dart';
import 'package:petitami/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:petitami/functions/register_functions.dart';

import 'home.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final registerFunctions = new RegisterFunctions();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: appbar(),
        body: ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              return Form(
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
                                registerFunctions.translate();
                              });
                            },
                            child: Text('Clique aqui para traduzir',
                                style: GoogleFonts.imprima(fontSize: 15)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 100),
                            child: Text(registerFunctions.emailQuestion,
                                style: GoogleFonts.imprima(fontSize: 20)),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              width: 300,
                              height: 60,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(fontSize: 15, color: Colors.white),
                                controller: _emailController,
                                decoration: textFormFieldInputDecoration(Icon(Icons.email,color: Colors.white70)),
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
                          Text(registerFunctions.nameQuestion,
                              style: GoogleFonts.imprima(fontSize: 20)),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            child: Container(
                              width: 300,
                              height: 60,
                              child: TextFormField(
                                style: TextStyle(fontSize: 15, color: Colors.white),
                                controller: _nameController,
                                decoration: textFormFieldInputDecoration(Icon(Icons.drive_file_rename_outline,color: Colors.white70)),
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Text(registerFunctions.passwordQuestion,
                              style: GoogleFonts.imprima(fontSize: 20)),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            child: Container(
                              width: 300,
                              height: 60,
                              child: TextFormField(
                                obscureText: true,
                                style: TextStyle(fontSize: 15, color: Colors.white),
                                controller: _passController,
                                decoration: textFormFieldInputDecoration(Icon(Icons.lock_open,color: Colors.white70)),
                                validator: (value) {
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
                          Text(registerFunctions.passwordConfirmationQuestion,
                              style: GoogleFonts.imprima(fontSize: 20)),
                          Padding(
                            padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                            child: Container(
                              width: 300,
                              height: 60,
                              child: TextFormField(
                                obscureText: true,
                                style: TextStyle(fontSize: 15, color: Colors.white),
                                //controller: null,
                                decoration: textFormFieldInputDecoration(Icon(Icons.lock_outline,color: Colors.white70)),
                                validator: (value) {
                                  if (value == null || value == '') {
                                    return 'Campo obrigatório';
                                  } else if (value != _passController) {
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
                                  Map<String, dynamic> userData = {
                                    "name": _nameController.text,
                                    "email": _emailController.text,
                                    "current_unit": 1.0,
                                    "current_exercise": 1,
                                  };
                                  model.signUp(
                                      userData: userData,
                                      pass: _passController.text,
                                      onSuccess: _onSuccess,
                                      onFail: _onFail
                                  );
                                } else {
                                  _onFail();
                                }
                              },
                              child: Text('ENVIAR'))
                        ],
                      ))
              );
            })
    );
  }

  void _onSuccess(){
    print('sucess');
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });

    Navigator.pushReplacement(context,
        MaterialPageRoute(
            builder: (context) => Home()));
  }

  void _onFail(){
    print('fail');
  }
}

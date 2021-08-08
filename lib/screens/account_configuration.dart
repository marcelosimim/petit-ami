import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/components/appbar.dart';
import 'package:petitami/components/inputdecoration.dart';
import 'package:petitami/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class AccountConfiguration extends StatefulWidget {
  const AccountConfiguration({Key? key}) : super(key: key);

  @override
  _AccountConfigurationState createState() => _AccountConfigurationState();
}

class _AccountConfigurationState extends State<AccountConfiguration> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _password;
  var _showPassword = Icons.visibility;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbar(),
        body: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircleAvatar(
                      backgroundColor: Color(0xFF0B27EA),
                      radius: 50,
                      child: Image.asset(
                        'assets/images/french_white_man.png',
                        height: 160,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Nome:',
                      style: GoogleFonts.imprima(fontSize: 20),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                      child: Container(
                        width: 200,
                        height: 70,
                        child: TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          decoration: textFormFieldInputDecoration(
                              Icon(Icons.account_circle)),
                          controller: _nameController,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Senha:',
                      style: GoogleFonts.imprima(fontSize: 20),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10, left: 95),
                      child: Row(
                        children: [
                          Container(
                              width: 200,
                              height: 70,
                              child: TextFormField(
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                                obscureText: _obscureText,
                                decoration: textFormFieldInputDecoration(
                                    Icon(Icons.lock)),
                                controller: _passwordController,
                                validator: (value) {
                                  _password = value;
                                  if (value!.length > 0 && value.length < 8) {
                                    return 'Insira pelo menos 8 caracteres';
                                  }
                                },
                              )),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: IconButton(
                              icon: Icon(_showPassword),
                              color: Colors.white70,
                              onPressed: () {
                                if (_showPassword.toString() ==
                                    'IconData(U+0E6BD)') {
                                  setState(() {
                                    _showPassword = Icons.visibility_off;
                                    _obscureText = false;
                                  });
                                } else {
                                  setState(() {
                                    _showPassword = Icons.visibility;
                                    _obscureText = true;
                                  });
                                }
                              },
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Confirme a senha:',
                      style: GoogleFonts.imprima(fontSize: 20),
                    ),
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                      child: Container(
                          width: 200,
                          height: 70,
                          child: TextFormField(
                            obscureText: _obscureText,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                            decoration:
                                textFormFieldInputDecoration(Icon(Icons.lock)),
                            validator: (value) {
                              if (_password!.length > 0 &&
                                  value != _passwordController.text) {
                                return 'As senhas não coincidem';
                              }
                            },
                          ))),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          model.updateUserData(_nameController.text, _passwordController.text);
                        }
                      },
                      child: Text('ENVIAR'))
                ],
              ),
            )),
      );
    });
  }
}

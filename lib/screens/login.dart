import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _email;
  String? _password;
  var _showPassword = Icons.visibility;
  bool _obscureText = true;

  Map<String, dynamic> ?_userData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
        title: Image.asset('assets/images/logo.png',
            fit: BoxFit.contain, height: 60),
        //backgroundColor: Color(0xFF0B27EA),
        centerTitle: true,
      ),
      //backgroundColor: Color(0xFF14279A),
      body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
        return Form(
          key: _formKey,
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Email:',
                    style:
                    GoogleFonts.imprima(color: Colors.white, fontSize: 20)),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    width: 250,
                    height: 70,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white70,
                        ),
                        helperText: '  ',
                        filled: true,
                        fillColor: Color(0xFF05158A),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(15)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(15)),
                      ),
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'Campo obrigatório';
                        } else if (EmailValidator.validate(value)) {
                          return null;
                        }
                        return 'Email inválido!';
                      },
                    ),
                  ),
                ),
                Text('Senha:',
                    style:
                    GoogleFonts.imprima(color: Colors.white, fontSize: 20)),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 250,
                        height: 70,
                        child: TextFormField(
                          obscureText: _obscureText,
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          controller: _passwordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white70,
                            ),
                            helperText: '  ',
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
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: IconButton(
                          icon: Icon(_showPassword),
                          color: Colors.white70,
                          onPressed: (){
                            if(_showPassword.toString() == 'IconData(U+0E6BD)'){
                              setState(() {
                                _showPassword = Icons.visibility_off;
                                _obscureText = false;
                              });
                            }else{
                              setState(() {
                                _showPassword = Icons.visibility;
                                _obscureText = true;
                              });
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Color(0xFF0B27EA)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('na validação, recuperando o model -> ${model.userData}');
                        _userData = model.userData;
                        model.signIn(
                            email: _emailController.text,
                            pass: _passwordController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail);
                        print('na validação, recuperando o model 2 -> ${model.userData}');
                      }
                      else {
                        print('falha na validação ');
                      }
                    },
                    child: Text('ENTRAR'))
              ],
            ),
          ));
          }
          )
    );
  }

  void _onSuccess(){
    print('sucess no login! -> _userData: $_userData');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => Home()));
  }

  void _onFail(){
    print('Fail');
  }
}

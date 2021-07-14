import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/screens/register.dart';
import 'package:petitami/components/AppBar.dart';

import 'login.dart';

class Initial extends StatelessWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                  'Bonjour, mon ami! Bienvenue sur votre app française.',
                  style:
                  GoogleFonts.imprima(fontSize: 36)),
            ),
            Padding(
              padding:
              EdgeInsets.only(top: 100, left: 40, right: 40, bottom: 5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text('CADASTRAR'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/google_icon.png',
                  height: 35,
                ),
                label: Text('ENTRAR COM GOOGLE'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Image.asset(
                  'assets/images/facebook_logo.png',
                  height: 30,
                ),
                label: Text('ENTRAR COM FACEBOOK'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text('ENTRAR'),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/components/appbar.dart';
import 'package:petitami/components/inputdecoration.dart';

class AccountConfiguration extends StatelessWidget {
  const AccountConfiguration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar(),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: CircleAvatar(
                backgroundColor: Color(0xFF0B27EA),
                radius: 100,
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
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                child: TextFormField(
                  decoration: textFormFieldInputDecoration(Icon(Icons.account_circle)),
                )),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Senha:',
                style: GoogleFonts.imprima(fontSize: 20),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                child: TextFormField(
                    decoration:
                        textFormFieldInputDecoration(Icon(Icons.lock)))),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Confirme a senha:',
                style: GoogleFonts.imprima(fontSize: 20),
              ),
            ),
            Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 80),
                child: TextFormField(
                    decoration:
                    textFormFieldInputDecoration(Icon(Icons.lock)))),
            ElevatedButton(
                onPressed: () {
                },
                child: Text('ENVIAR'))
          ],
        ),
      ),
    );
  }
}

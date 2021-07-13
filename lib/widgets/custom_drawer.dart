import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xFF05158A),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Seja bem-vindo(a) User!',
                style: GoogleFonts.imprima(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: CircleAvatar(
                child: Image.asset(
                  'assets/images/french_white_man.png',
                  height: 250,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Unidade atual: ',
                style: GoogleFonts.imprima(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Exercício atual: ',
                style: GoogleFonts.imprima(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Nível do francês: ',
                style: GoogleFonts.imprima(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Nível do francês: ',
                style: GoogleFonts.imprima(fontSize: 20),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 320, bottom: 20),
                child: Row(
                  children: [
                    TextButton(onPressed: (){}, child: Text('EDITAR PERFIL', style: GoogleFonts.imprima(fontSize: 15),)),
                    TextButton(onPressed: (){}, child: Text('SAIR', style: GoogleFonts.imprima(fontSize: 15),))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/models/user_model.dart';
import 'package:petitami/screens/initial.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(child:
        ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        color: Color(0xFF05158A),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Seja bem-vindo(a) ${model.userData == null ? "NULL" : model.userData["name"]}',
                style: GoogleFonts.imprima(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 100),
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
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Unidade atual: ${model.userData == null ? "NULL" : model.userData["current_unit"].toString().replaceAll('.0', '')}',
                style: GoogleFonts.imprima(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Exercício atual: ${model.userData == null ? "NULL" : model.userData["current_exercise"]}',
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
                padding: EdgeInsets.only(top: 120, bottom: 20, left: 20),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'EDITAR PERFIL',
                          style: GoogleFonts.imprima(fontSize: 15),
                        )),
                    TextButton(
                        onPressed: () {
                          model.signOut();
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Initial()));
                        },
                        child: Text(
                          'SAIR',
                          style: GoogleFonts.imprima(fontSize: 15),
                        ))
                  ],
                )),
          ],
        ),
      );
    }));
  }
}

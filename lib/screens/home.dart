import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/components/AppBar.dart';
import 'package:petitami/components/progressionbar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Text(
                'Concluído:',
                style: GoogleFonts.imprima(fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 40, left: 40, bottom: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: linearProgressIndicator(48),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30, bottom: 20),
              child: Text(
                'Continue estudando: ',
                style: GoogleFonts.imprima(fontSize: 25),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 120, left: 120, bottom: 30),
                child: IconButton(
                  icon: Image.network(
                    'https://drive.google.com/uc?export=view&id=1kuRsV6aoYv_jS_6xvBt8lJKSdgK6OepR',
                  ),
                  iconSize: 150,
                  onPressed: (){

                  },
                )
            ),
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30, bottom: 20),
              child: Text(
                'Quanto tempo falta: ',
                style: GoogleFonts.imprima(fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30, bottom: 20),
              child: Text(
                'Dados última unidade: ',
                style: GoogleFonts.imprima(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

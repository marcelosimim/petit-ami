import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'initial.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //esse aqui viu? backgroundColor: Color(0xFF14279A),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Initial()
                ));
          }, icon: Image.asset('assets/images/logo.png'), iconSize: 500,),
          Text(
            'Petit Ami',
            style: GoogleFonts.architectsDaughter(
              fontSize: 60,
            ),
          ),
        ],
      ),
    );
  }
}

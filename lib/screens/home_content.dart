import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/components/progressionbar.dart';
import 'package:petitami/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'exercise.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String _cover = '';

  Future<String> _setCover(String unit) async {
    unit = unit.replaceAll('.', '').replaceAll('0', '');
    final DocumentReference document =
    FirebaseFirestore.instance.collection("unit").doc('unit${unit}');
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      Map<String, dynamic> data = snapshot.data! as Map<String, dynamic>;
      _cover = data['cover'];
      //print(_cover);
    });

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
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
                child: linearProgressIndicator(model.userData['current_unit']),
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
              child: FutureBuilder(
                  future: _setCover(model.userData['current_unit'].toString()),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        );
                      default:
                        if (snapshot.hasError)
                          return Container();
                        else
                          return IconButton(
                            icon: Image.network(_cover),
                            iconSize: 150,
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Exercise()));
                            },
                          );
                    }
                  }),
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
      );
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/components/progressionbar.dart';
import 'package:petitami/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'exercise.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String _cover = '';


  Future<String> _setCover(int unit) async {
    Reference ref = FirebaseStorage.instance
        .ref().child('cover').child('/capa${unit}.png');
    _cover = ref.getDownloadURL().toString();
    return ref.getDownloadURL();
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
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
                  future: _setCover(model.userData['current_unit']),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Center(child: CircularProgressIndicator(
                          valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 5.0,
                        ),);
                      default:
                        if (snapshot.hasError)
                          return Container(
                            child: Text('error')
                          );
                        else
                          return IconButton(
                            icon: Image.network(snapshot.data.toString()),
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

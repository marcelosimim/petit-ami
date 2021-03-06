import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/components/progressionbar.dart';
import 'package:petitami/functions/exercises_functions.dart';
import 'package:petitami/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petitami/route/route.dart' as route;


class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final Exercises functions = new Exercises();
  bool? _exerciseType;
  String _cover = '';

  Future<String> _setCover(int unit) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('cover').child('/capa${unit}.png');
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
                'Progresso do curso:',
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
                  future: _setCover(model.userData['current_unit']),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError)
                          return Container(child: Text('error'));
                        else
                          return IconButton(
                            icon: Image.network(snapshot.data.toString()),
                            iconSize: 150,
                            onPressed: () async {
                              _exerciseType = await functions.getExerciseType(
                                  model.userData['current_unit'],
                                  model.userData['current_exercise']);
                              _exerciseType == true
                                  ? Navigator.pushNamedAndRemoveUntil(context,
                                      route.questionPage, (route) => false)
                                  : Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      route.listenAndRepeatPage,
                                      (route) => false);
                            },
                          );
                    }
                  }),
            ),
            /*Padding(
              padding: EdgeInsets.only(right: 30, left: 30, bottom: 20),
              child: Text(
                'Quanto tempo falta: ',
                style: GoogleFonts.imprima(fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30, bottom: 20),
              child: Text(
                'Dados ??ltima unidade: ',
                style: GoogleFonts.imprima(fontSize: 25),
              ),
            ),*/
          ],
        ),
      );
    });
  }
}

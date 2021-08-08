import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:petitami/functions/exercises_functions.dart';
import 'package:petitami/models/user_model.dart';
import 'package:petitami/widgets/image_exercise.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'home.dart';

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  bool _isListening = false;
  final _speech = new SpeechToText();
  double _confidence = 1.0;
  String? _text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Image.asset('assets/images/logo.png',
              fit: BoxFit.contain, height: 60),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context, new Exercise());
                },
                icon: Icon(Icons.refresh))
          ],
        ),
        resizeToAvoidBottomInset: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Colors.redAccent,
          endRadius: 75.0,
          //duration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(
              Icons.mic,
            ),
            onPressed: () {
              _listen();
            },
          ),
        ),
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return Container(
            width: double.infinity,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ImageExercise(model.userData['current_unit'],
                      model.userData['current_exercise']),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {

                      });
                    },
                    child: Text('ÉCOUTEZ'),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),
                Container(
                  width: 250,
                  height: 100,
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: _text,
                      hintStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Color(0xFF05158A),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(15)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? _check;
                    final DocumentReference document = FirebaseFirestore.instance
                        .collection("exercises")
                        .doc('u${model.userData['current_unit']}_e${model.userData['current_exercise']}');
                    await document
                        .get()
                        .then<dynamic>((DocumentSnapshot snapshot) async {
                      print('snapshot ${snapshot['check']}');
                      _check = snapshot['check'];
                    });
                    if (_text == _check) {
                      model.setExercise(1);
                      Navigator.push(context, new MaterialPageRoute(builder: (context) => Exercise()));
                    } else {
                      print('falso');
                    }
                  },
                  child: Text('ENVIAR'),
                ),
              ],
            ),
          );
        }));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
          localeId: 'fr-FR',
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }
}

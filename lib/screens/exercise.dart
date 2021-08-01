import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petitami/components/appbar.dart';
import 'package:petitami/components/inputdecoration.dart';
import 'package:petitami/functions/exercises_functions.dart';
import 'package:petitami/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'home.dart';

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  final _exercises_functions = new Exercises();
  final _speech = new SpeechToText();
  bool _isListening = false;
  bool _imageSetted = false;
  String? _imageValue;
  String? _text;
  double _confidence = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png',
            fit: BoxFit.contain, height: 60),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            print(_imageValue);
            setState(() {
                _imageSetted = false;
            });
          }, icon: Icon(Icons.refresh))
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
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return Container(
          width: double.infinity,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        if (model.userData['current_exercise'] > 1) {
                          int e = model.setExercise(model.userData['current_exercise'], '-');
                          final DocumentReference document = Firestore.instance
                              .collection("exercises")
                              .document('u${model.userData['current_unit']}_e${e}');
                          await document
                              .get()
                              .then<dynamic>((DocumentSnapshot snapshot) async {
                            print('img: ' + snapshot.data['img']);
                            _imageValue = 'https://drive.google.com/uc?export=view&id=' + snapshot.data['img'];
                            print(_imageValue);
                          });
                        }
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.red,
                        size: 30,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 290),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => Home()));
                        },
                        icon: Icon(
                          Icons.cancel_sharp,
                          color: Colors.red,
                          size: 30,
                        )),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: _imageSetted
                    ? Image.network(
                        _imageValue!,
                        height: 200,
                        //width: 350,
                      )
                    : FutureBuilder(
                        future: _exercises_functions.recoverExerciseImg(
                            model.userData['current_unit'].toString(),
                            model.userData['current_exercise'].toString()),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                              return Container(
                                height: 200,
                              );
                            default:
                              if (snapshot.hasError)
                                return Container();
                              else
                                _imageSetted = true;
                              _imageValue = snapshot.data.toString();
                              return Image.network(
                                _imageValue!,
                                height: 200,
                                //width: 350,
                              );
                          }
                        }),
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
                  _imageSetted = false;
                  String? _check;
                  String unit = model.userData['current_unit']
                      .toString()
                      .replaceAll('.', '')
                      .replaceAll('0', '');
                  String exercise = model.userData['current_unit']
                      .toString()
                      .replaceAll('.', '')
                      .replaceAll('0', '');
                  final DocumentReference document = Firestore.instance
                      .collection("exercises")
                      .document('u${unit}_e${exercise}');
                  await document
                      .get()
                      .then<dynamic>((DocumentSnapshot snapshot) async {
                    print('snap: ' + snapshot.data['check']);
                    _check = snapshot.data['check'];
                  });
                  if (_text == _check) {
                    int e = model.setExercise(model.userData['current_exercise'], '+');
                    final DocumentReference document = Firestore.instance
                        .collection("exercises")
                        .document('u${unit}_e${['current_exercise']}');
                    await document
                        .get()
                        .then<dynamic>((DocumentSnapshot snapshot) async {
                      print('img: ' + snapshot.data['img']);
                      _imageValue = 'https://drive.google.com/uc?export=view&id=' + snapshot.data['img'];
                      print(_imageValue);
                        });
                    setState(() {

                    });
                  } else {
                    print('falso');
                  }
                },
                child: Text('ENVIAR'),
              ),
            ],
          ),
        );
      }),
    );
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

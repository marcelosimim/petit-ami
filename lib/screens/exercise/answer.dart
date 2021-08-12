import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petitami/components/appbar_exercise.dart';
import 'package:petitami/functions/exercises_functions.dart';
import 'package:petitami/models/user_model.dart';
import 'package:petitami/widgets/image_exercise.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:petitami/route/route.dart' as route;

class Answer extends StatefulWidget {
  const Answer({Key? key}) : super(key: key);

  @override
  _AnswerState createState() => _AnswerState();
}

class _AnswerState extends State<Answer> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _answerController = TextEditingController();
  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  final Exercises functions = new Exercises();
  bool _isPlaying = false;
  String? _currentAudio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar_exercise(context),
        resizeToAvoidBottomInset: true,
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: ImageExercise(model.userData['current_unit'],
                      model.userData['current_exercise']),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () async {
                      String url = await functions.getAudioUrl(
                          model.userData['current_unit'],
                          model.userData['current_exercise']);
                      playAudio(url);
                    },
                    child: Text('ÉCOUTEZ'),
                    //child: Icon(Icons.play_circle_fill),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    width: 250,
                    height: 100,
                    child: TextFormField(
                      controller: _answerController,
                      decoration: InputDecoration(
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
                ),
                ElevatedButton(
                  onPressed: () async {
                    String? _check;
                    final DocumentReference document =
                        FirebaseFirestore.instance.collection("exercises").doc(
                            'u${model.userData['current_unit']}_e${model.userData['current_exercise']}');
                    await document
                        .get()
                        .then<dynamic>((DocumentSnapshot snapshot) async {
                      print('snapshot ${snapshot['check']}');
                      _check = snapshot['check'];
                      _check = await functions.getAnswer(1, 1);
                    });
                    if (_answerController.text.toLowerCase() == _check) {
                      model.setExercise(1);
                      Navigator.pushNamedAndRemoveUntil(
                          context, route.exercisePage, (route) => false);
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

  void playAudio(String url) async {
    if (_isPlaying) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          _currentAudio = url;
        });
      }
    } else if (!_isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          _isPlaying = true;
        });
      }
    }
  }
}

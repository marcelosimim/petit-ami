import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petitami/components/appbar_exercise.dart';
import 'package:petitami/functions/exercises_functions.dart';
import 'package:petitami/models/user_model.dart';
import 'package:petitami/widgets/image_exercise.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:petitami/route/route.dart' as route;

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _answerController = TextEditingController();
  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  final Exercises functions = new Exercises();
  bool _isPlaying = false;
  String? _currentAudio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('EXERCICIO DE PERGUNTA??/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar_exercise(context),
        resizeToAvoidBottomInset: false,
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    width: 350,
                    child: ImageExercise(model.userData['current_unit'],
                        model.userData['current_exercise']),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: ElevatedButton(
                    child: Text('ÉCOUTEZ'),
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.white,
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        )),
                    onPressed: () async {
                      String url = await functions.getAudioUrl(
                          model.userData['current_unit'],
                          model.userData['current_exercise']);
                      playAudio(url);
                    },
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
                    _check = await functions.getAnswer(model.userData['current_unit'], model.userData['current_exercise']+1);
                    if (_answerController.text.toLowerCase().replaceAll(",", '') == _check.toString().toLowerCase()) {
                      bool _unitEnd = await functions.changeUnit(model.userData['current_unit'], model.userData['current_exercise']);
                      if(_unitEnd){
                        model.setUnit(1);
                        Navigator.pushNamedAndRemoveUntil(
                            context, route.homePage, (route) => false);
                      }else{
                        model.setExercise(1);
                        Navigator.pushNamedAndRemoveUntil(
                            context, route.answerPage, (route) => false);
                      }
                    } else {
                      _onFail();
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

  void _onFail(){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Color(0xFF0B27EA),
        content: Text(
          'Resposta incorreta. Tente novamente!',
        ),
      ),
    );
    print('Fail');
  }
}

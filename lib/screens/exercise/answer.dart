import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:petitami/components/appbar.dart';
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
  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  final Exercises functions = new Exercises();
  bool _isPlaying = false;
  String? _currentAudio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('EXERCICIO DE RESPOSTA/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
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
                    print(model.userData['current_exercise']);
                    /*
                    String url = await functions.getAudioUrl(
                        model.userData['current_unit'],
                        model.userData['current_exercise']);
                    playAudio(url);*/
                  },
                  child: Text('ÉCOUTEZ'),
                  //child: Icon(Icons.play_circle_fill),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
              ),
              ElevatedButton(
                onPressed: () async{
                  model.setExercise(1);
                  bool? next = await functions.getExerciseType(model.userData['current_unit'],  model.userData['current_exercise']);
                  next == true? Navigator.pushReplacementNamed(context, route.questionPage)
                      : Navigator.pushReplacementNamed(
                      context,
                      route.listenAndRepeatPage);
                },
                child: Text('PRÓXIMO'),
              ),
            ],
          ),
        );
      }),
    );
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

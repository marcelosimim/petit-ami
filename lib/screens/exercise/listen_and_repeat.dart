import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:petitami/components/appbar_exercise.dart';
import 'package:petitami/functions/exercises_functions.dart';
import 'package:petitami/models/user_model.dart';
import 'package:petitami/route/route.dart' as route;
import 'package:petitami/widgets/image_exercise.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ListenAndRepeat extends StatefulWidget {
  const ListenAndRepeat({Key? key}) : super(key: key);

  @override
  _ListenAndRepeatState createState() => _ListenAndRepeatState();
}

class _ListenAndRepeatState extends State<ListenAndRepeat> {
  AudioPlayer audioPlayer = new AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  final Exercises functions = new Exercises();
  final _speech = new SpeechToText();
  double _confidence = 1.0;
  bool _isListening = false;
  String _speechText = '';
  bool _isPlaying = false;
  String? _currentAudio;
  String? _check;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('EXERCICIO DE ESCUTA E REPETICAO');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar_exercise(context),
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
              setState(() {
                if(!_isListening)
                _speechText = '';
              });
              _listen();
            },
          ),
        ),
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
                    onPressed: () async{
                      String url = await functions.getAudioUrl(model.userData['current_unit'], model.userData['current_exercise']);
                      playAudio(url);
                    },
                    child: Text('ÉCOUTEZ'),
                    //child: Icon(Icons.play_circle_fill),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_speechText == '' ? '' : 'Texto falado: '),
                    Text(_speechText),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: ElevatedButton(
                    onPressed: () async{
                      _check = await functions.getAnswer(model.userData['current_unit'], model.userData['current_exercise']);
                      print(_check.toString().toLowerCase());
                      print(_speechText.toLowerCase());
                      if(_check.toString().toLowerCase() == _speechText.toLowerCase()){
                        model.setExercise(1);
                        bool? next = await functions.getExerciseType(model.userData['current_unit'],  model.userData['current_exercise']);
                        next == true? Navigator.pushReplacementNamed(context, route.questionPage)
                          : Navigator.pushReplacementNamed(
                      context,
                      route.listenAndRepeatPage);
                      }
                    },
                    child: Text('CONFIRMAR'),
                    //child: Icon(Icons.play_circle_fill),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                  ),
                ),
              ],
            ),
          );
        })
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
            _speechText = val.recognizedWords;
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

  void playAudio(String url) async{
    if(_isPlaying){
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if(result == 1){
        setState(() {
          _currentAudio = url;
        });
      }
    }else if(!_isPlaying){
      int result = await audioPlayer.play(url);
      if(result == 1){
        setState(() {
          _isPlaying = true;
        });
      }
    }
  }
}

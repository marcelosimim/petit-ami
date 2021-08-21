import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        body:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return Container(
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                      'Unité ${model.userData['current_unit']} - ${model.userData['current_exercise']}', style:  GoogleFonts.imprima(color: Colors.white, fontSize: 20),),
                ),
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
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_speechText == '' ? '' : 'Texto falado: '),
                    Text(_speechText),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 80, bottom: 20),
                  child: AvatarGlow(
                    animate: _isListening,
                    glowColor: Colors.redAccent,
                    endRadius: 75.0,
                    repeat: true,
                    child: FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(
                        Icons.mic,
                      ),
                      onPressed: () async {
                        setState(() {
                          if (!_isListening) _speechText = '';
                        });
                        if (!_isListening) {
                          bool available = await _speech.initialize(
                            onStatus: (val) => print('onStatus: $val'),
                            onError: (val) {
                              print('onError: $val');
                              setState(() {
                                _isListening = false;
                              });
                            },
                          );
                          if (available) {
                            setState(() {
                              _isListening = true;
                            });
                            _speech.listen(
                              localeId: 'fr-FR',
                              onResult: (val) => setState(
                                () async {
                                  setState(() {
                                    _speechText = val.recognizedWords;
                                  });

                                  if (val.hasConfidenceRating &&
                                      val.confidence > 0) {
                                    _confidence = val.confidence;
                                  }
                                  if (val.finalResult) {
                                    _isListening = false;
                                    _check = await functions.getAnswer(
                                        model.userData['current_unit'],
                                        model.userData['current_exercise']);
                                    print(_check.toString().toLowerCase());
                                    print(_speechText.toLowerCase());
                                    if (_check.toString().toLowerCase() ==
                                        _speechText.toLowerCase()) {
                                      bool _unitEnd =
                                          await functions.changeUnit(
                                              model.userData['current_unit'],
                                              model.userData[
                                                  'current_exercise']);
                                      if (_unitEnd) {
                                        model.setUnit(1);
                                      } else {
                                        model.setExercise(1);
                                      }
                                      bool? next =
                                          await functions.getExerciseType(
                                              model.userData['current_unit'],
                                              model.userData[
                                                  'current_exercise']);
                                      next == true
                                          ? Navigator.pushReplacementNamed(
                                              context, route.questionPage)
                                          : Navigator.pushReplacementNamed(
                                              context,
                                              route.listenAndRepeatPage);
                                    } else {
                                      _onFail();
                                    }
                                  }
                                },
                              ),
                            );
                          }
                        } else {
                          setState(() {
                            _isListening = false;
                          });
                          _speech.stop();
                        }
                      },
                    ),
                  ),
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

  void _onFail() {
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

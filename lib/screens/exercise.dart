import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petitami/components/appbar_exercise.dart';
import 'package:petitami/functions/exercises_functions.dart';
import 'package:petitami/models/user_model.dart';
import 'package:petitami/route/route.dart' as route;
import 'package:petitami/widgets/image_exercise.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:speech_to_text/speech_to_text.dart';


class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  final Exercises functions = new Exercises();
  bool? _answer;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
       return Container();
    });
  }
}

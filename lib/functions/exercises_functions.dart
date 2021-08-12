import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class Exercises {
  Future<String> getAudioUrl(int u, int e) async{
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('exercises')
        .child('/unit${u}')
        .child('/audios')
        .child('${e}.mp3');

    final link = await ref.getDownloadURL();
    return link;
  }

  Future<String?> getAnswer(int unit, int exercise) async {
    String? _check;

    final DocumentReference document = FirebaseFirestore.instance
        .collection("exercises")
        .doc('u${unit}_e${exercise}');
    await document
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      print('snapshot ${snapshot['check']}');
      _check = snapshot['check'];
      print('check: '+ _check!);
    });
    return _check;
  }

  Future<bool?> getExerciseType(int unit, int exercise) async{
    bool _answer;

    print(unit);
    print(exercise);

    final DocumentReference document = FirebaseFirestore.instance
        .collection("exercises")
        .doc('u${unit}_e${exercise}');
    await document
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      print('snapshot ${snapshot['answer']}');
      _answer = snapshot['answer'];
    });
    return null;
  }
}

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

  Future<String?> getAnswer(int u, int e) async {
    String? _check;

    final DocumentReference document = FirebaseFirestore.instance
        .collection("unit${u}")
        .doc('e${e}');
    await document
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      _check = snapshot['check'];
      print('check: '+ _check!);
    });
    return _check.toString().replaceAll('?', '').replaceAll('!', '').replaceAll(',', '').replaceAll('.', '');
  }

  Future<bool?> getExerciseType(int u, int e) async{
    bool? _answer;


    final DocumentReference document = FirebaseFirestore.instance
        .collection("unit${u}")
        .doc('e${e}');
    await document
        .get()
        .then<dynamic>((DocumentSnapshot snapshot) async {
      print('snapshot ${snapshot['answer']}');
      _answer = snapshot['answer'];
    });
    return _answer;
  }
}

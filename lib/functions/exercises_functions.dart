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

  Future<String> getAnswer(String unit, String exercise) async {
    String? _check;

    unit = unit.replaceAll('.', '').replaceAll('0', '');
    exercise = exercise.replaceAll('.', '').replaceAll('0', '');

    final DocumentReference document = FirebaseFirestore.instance
        .collection("exercises")
        .doc('u${unit}_e${exercise}');
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
      print('snap: ' + data['check']);
      _check = data['check'].toString().toLowerCase();
      return;
    });

    return '';
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Exercises {

  Future<String> recoverExerciseImg(String unit, String exercise) async {
    String? id;

    unit = unit.replaceAll('.', '').replaceAll('0', '');
    exercise = exercise.replaceAll('.', '').replaceAll('0', '');

    final DocumentReference document =
    FirebaseFirestore.instance.collection("exercises").doc(
        'u${unit}_e${exercise}');
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
      id = data['img'];
    });
    return 'https://drive.google.com/uc?export=view&id=' + id!;

    //return 'https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png';
    //return 'https://drive.google.com/uc?export=view&id=1sCGGq24IKrHycd14xR5ENcYir9RuEqh9'.toString();
  }

  Future<String> getAnswer(String unit, String exercise) async{
    String? _check;

    unit = unit.replaceAll('.', '').replaceAll('0', '');
    exercise = exercise.replaceAll('.', '').replaceAll('0', '');

    final DocumentReference document =
    FirebaseFirestore.instance.collection("exercises").doc(
        'u${unit}_e${exercise}');
    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
      print('snap: '+data['check']);
      _check = data['check'].toString().toLowerCase();
      return ;
    });

    return '';
  }

}
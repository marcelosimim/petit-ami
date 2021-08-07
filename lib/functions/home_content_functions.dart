import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeContentFunctions{

  Future<String> getCover() async {
    print('FIRESTORE:');
    //print(await Firestore.instance.collection('unit').snapshots());
    //Firestore.instance.collection('unit');

    final DocumentReference document =  FirebaseFirestore.instance.collection("unit").doc('unit1_exercise0');

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
        print(data['image']);
        return data['image'];
    });

    return 'https://emojigraph.org/media/apple/clown-face_1f921.png';
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:petitami/models/user_model.dart';
import 'package:petitami/widgets/image_grid_item.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Unit extends StatefulWidget {
  const Unit({Key? key}) : super(key: key);

  @override
  _UnitState createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  Future<String> _setCover(int unit) async {
    Reference ref =
        FirebaseStorage.instance.ref().child('cover').child('/capa${unit}.png');
    //_cover = ref.getDownloadURL().toString();
    return ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return GridView.builder(
          itemCount: 18,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return ImageGridItem(index + 1, model.userData['current_unit']);
            });
      }),
    );
  }
}



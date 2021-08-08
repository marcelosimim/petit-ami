import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ImageExercise extends StatefulWidget {
  int? _index;
  int? _currentUnit;
  int? _currentExercise;

  ImageExercise(int currentUnit, int currentExercise) {
    this._currentUnit = currentUnit;
    this._currentExercise = currentExercise;
  }

  @override
  _ImageExerciseState createState() => _ImageExerciseState();
}

class _ImageExerciseState extends State<ImageExercise> {
  Reference refImage = FirebaseStorage.instance.ref().child('exercises');
  Uint8List? imageFile;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  getImage() {
    final MAX_SIZE = 1 * 1024 * 1024;
    print(widget._index);
    refImage.child('/unit${widget._currentUnit}').child('/images').child('/${widget._currentExercise}.png').getData(MAX_SIZE).then((value) =>
    {
      this.setState(() {
        imageFile = value;
      })
    }).catchError((error) {

    });
  }

  @override
  Widget build(BuildContext context) {
    if (imageFile == null) {
      return Center(child: CircularProgressIndicator(
        valueColor:
        AlwaysStoppedAnimation<Color>(Colors.white),
        strokeWidth: 3.0,
      ));
    } else {
      return Image.memory(imageFile!);
    }
  }
}
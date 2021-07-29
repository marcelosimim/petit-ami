import 'package:flutter/material.dart';
import 'package:petitami/components/appbar.dart';
import 'package:petitami/components/inputdecoration.dart';
import 'package:petitami/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Exercise extends StatefulWidget {
  const Exercise({Key? key}) : super(key: key);

  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.red,
                        size: 30,
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 290),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.cancel_sharp,
                          color: Colors.red,
                          size: 30,
                        )),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: Image.network(
                    'https://emojigraph.org/media/apple/clown-face_1f921.png'),
              ),
              Padding(
                padding: EdgeInsets.only(right: 30, bottom: 50),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.play_circle_fill,
                    color: Colors.red,
                    size: 80,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(right: 30, bottom: 50),
                  child: Row(
                    children: [
                      Container(
                        width: 250,
                        height: 70,
                        child: TextFormField(
                          decoration: textFormFieldInputDecoration(
                              Icon(Icons.cancel_sharp)),
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: Icon(Icons.mic_rounded, color: Colors.red,))
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(right: 30, bottom: 50),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('ENVIAR'),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}

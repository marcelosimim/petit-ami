import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petitami/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class Unit extends StatefulWidget {
  const Unit({Key? key}) : super(key: key);

  @override
  _UnitState createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return FutureBuilder<QuerySnapshot>(
          future: Firestore.instance
              .collection('cover')
              .orderBy('pos')
              .getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                ],
              );
            else
              return Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 30,
                    children: snapshot.data!.documents.map((doc) {
                      return GestureDetector(
                        child: GridTile(
                            child: ColorFiltered(
                              colorFilter: ColorFilter.mode(model.userData['current_unit'].toInt() >= doc.data['pos'] ?
                                  Colors.blue : Colors.black,BlendMode.saturation),
                              child: Image.network(
                                'https://drive.google.com/uc?export=view&id=' +
                                    doc.data!['img'],
                              ),
                            )),
                        onTap: () async {
                          final url = doc.data['pdf'];
                          print(url);
                        },
                      );
                    }).toList(),
                  ));
          },
        );
      }),
    );
  }
}

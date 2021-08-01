import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Unit extends StatefulWidget {
  const Unit({Key? key}) : super(key: key);

  @override
  _UnitState createState() => _UnitState();
}

class _UnitState extends State<Unit> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future:
          Firestore.instance.collection('cover').orderBy('pos').getDocuments(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return SliverToBoxAdapter(
            child: Container(
              height: 200,
              alignment: Alignment.center,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
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
                      child: Image.network(
                          'https://drive.google.com/uc?export=view&id=' +
                              doc.data!['img']),
                    ),
                    onTap: () {
                      print('alo');
                    },
                  );
                }).toList(),
              ));
      },
    );
  }
}

/*

 */

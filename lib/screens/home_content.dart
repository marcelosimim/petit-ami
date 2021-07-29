import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petitami/components/progressionbar.dart';
import 'package:petitami/functions/home_content_functions.dart';
import 'package:petitami/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {

  String _cover = '';

  @override
  void initState() {
      setState(() {
        setCover();
      });
  }

  Future<String> setCover() async {
    print('IMAGE:');
    final DocumentReference document = Firestore.instance.collection("unit").document('unit1_exercise0');

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      print(snapshot.data['image']);
      _cover = snapshot.data['image'];
      return snapshot.data['image'];
    });

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Text(
                'Concluído:',
                style: GoogleFonts.imprima(fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 40, left: 40, bottom: 30),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                child: linearProgressIndicator(model.userData['current_unit']),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30, bottom: 20),
              child: Text(
                'Continue estudando: ',
                style: GoogleFonts.imprima(fontSize: 25),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 120, left: 120, bottom: 30),
                child: IconButton(
                  icon: Image.network(
                      _cover
                  ),
                  iconSize: 150,
                  onPressed: (){
                      setState(() {
                        
                      });
                  },
                )
            ),
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30, bottom: 20),
              child: Text(
                'Quanto tempo falta: ',
                style: GoogleFonts.imprima(fontSize: 25),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 30, left: 30, bottom: 20),
              child: Text(
                'Dados última unidade: ',
                style: GoogleFonts.imprima(fontSize: 25),
              ),
            ),
          ],
        ),
      );});
    }
  }

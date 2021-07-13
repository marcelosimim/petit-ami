import 'package:flutter/material.dart';
import 'package:petitami/components/AppBar.dart';
import 'package:petitami/screens/home_content.dart';
import 'package:petitami/screens/splash_screen.dart';
import 'package:petitami/screens/unit.dart';
import 'package:petitami/widgets/custom_drawer.dart';

import 'account_configurations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 1;
  final List<Widget> _screen = [
    CustomDrawer(),
    HomeContent(),
    Unit(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _index = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF0B27EA),
        currentIndex: _index,
        onTap: onTabTapped,
        items: [

          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Configurações'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: 'Unidades'),
        ],
      ),
      body: _screen[_index],
    );
  }
}

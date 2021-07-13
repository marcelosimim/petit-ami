import 'package:flutter/material.dart';
import 'package:petitami/components/AppBar.dart';
import 'package:petitami/screens/home_content.dart';
import 'package:petitami/screens/splash_screen.dart';
import 'package:petitami/screens/unit.dart';

import 'account_configurations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  final List<Widget> _screen = [
    Unit(),
    HomeContent(),
    AccountConfigurations(),
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
              icon: Icon(Icons.vpn_key), label: 'Unidades'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle), label: 'Configurações'),
        ],
      ),
      body: _screen[_index],
    );
  }
}

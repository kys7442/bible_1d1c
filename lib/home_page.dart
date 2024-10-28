import 'package:flutter/material.dart';
import 'first_page.dart';
import 'second_page.dart';
import 'third_page.dart';
import 'fourth_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    FirstPage(),
    SecondPage(),
    ThirdPage(),
    FourthPage(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // 현재 인덱스에 맞는 페이지 표시
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'First',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Second',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Third',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Fourth',
          ),
        ],
      ),
    );
  }
}

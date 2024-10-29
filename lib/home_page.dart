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
  int _currentIndex = 0; // 초기 인덱스를 0으로 설정 (비어있는 페이지 표시)

  final List<Widget> _pages = [
    Container(), // 빈 페이지를 표시합니다.
    FirstPage(),
    SecondPage(),
    ThirdPage(),
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '성경',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: '찬송가',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '커뮤니티',
          ),
        ],
      ),
    );
  }
}

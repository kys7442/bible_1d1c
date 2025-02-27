import 'package:flutter/material.dart';
import 'dart:async';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '1일1장',
      home: const SplashScreen(),
      theme: ThemeData(
        fontFamily: 'Noto Sans KR', // 커스텀 폰트 적용
        // BottomNavigationBar 테마 설정
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.blue, // 배경색 설정
          selectedItemColor: Colors.black, // 선택된 아이템의 색상
          unselectedItemColor: Colors.grey[500], // 선택되지 않은 아이템의 색상
        ),
      )
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 2초 후에 홈 화면으로 이동
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  // 'State.build' 메서드의 구현
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          '말씀묵상',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
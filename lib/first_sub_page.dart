import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FirstSubPage extends StatefulWidget {
  final String bookName;
  final int bookId;

  FirstSubPage({required this.bookName, required this.bookId});

  @override
  _FirstSubPageState createState() => _FirstSubPageState();
}

class _FirstSubPageState extends State<FirstSubPage> {
  List<Map<String, dynamic>> chapters = []; // Map<String, dynamic>으로 변경
  bool isLoading = true; // 로딩 상태 변수
  String errorMessage = ''; // 에러 메시지 변수

  @override
  void initState() {
    super.initState();
    fetchChapters();
  }

  Future<void> fetchChapters() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:3000/bibles/chapter/${widget.bookId}'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body); // List<dynamic>으로 변경
        setState(() {
          chapters = data.map((chapter) => {
            'idx': chapter['idx'],
            'lang': chapter['lang'],
            'book_no': chapter['book_no'],
            'book_kor': chapter['book_kor'],
            'book_eng': chapter['book_eng'],
            'chapter': chapter['chapter'].toString(),
            'page': chapter['page'].toString(),
            'contents': chapter['contents'] ?? '내용 없음', // null 처리
          }).toList(); // List<Map<String, dynamic>>로 변환
          isLoading = false; // 로딩 완료
        });
      } else {
        setState(() {
          errorMessage = '데이터를 가져오는 데 실패했습니다.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = '에러가 발생했습니다: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.bookName),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // 로딩 중일 때
          : errorMessage.isNotEmpty
          ? Center(child: Text(errorMessage)) // 에러 메시지 표시
          : ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${chapters[index]['chapter']}장 ${chapters[index]['page']}절'), // 장과 절 정보
            subtitle: Text(chapters[index]['contents'] ?? '내용 없음'), // 내용
          );
        },
      ),
    );
  }
}

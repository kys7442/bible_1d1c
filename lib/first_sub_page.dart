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
  List<Map<String, String>> chapters = [];

  @override
  void initState() {
    super.initState();
    fetchChapters();
  }

  Future<void> fetchChapters() async {
    final response = await http.get(Uri.parse('http://localhost:3000/bibles/chapter/${widget.bookId}'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        chapters = List<Map<String, String>>.from(data['chapters']);
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
      body: ListView.builder(
        itemCount: chapters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(chapters[index]['title'] ?? '제목 없음'),
            subtitle: Text(chapters[index]['content'] ?? '내용 없음'),
          );
        },
      ),
    );
  }
}

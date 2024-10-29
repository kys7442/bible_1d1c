import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'first_sub_page.dart';
import 'home_page.dart';
import 'dart:developer';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<String> oldTestamentBooks = [];
  List<String> newTestamentBooks = [];

  @override
  void initState() {
    super.initState();
    fetchBibleBooks();
  }

  Future<void> fetchBibleBooks() async {
    final response1 = await http.get(Uri.parse('http://localhost:3000/bibles/groupold'));
    final response2 = await http.get(Uri.parse('http://localhost:3000/bibles/groupnew'));

    if (response1.statusCode == 200) {
      final List<dynamic> data = json.decode(response1.body);
      setState(() {
        oldTestamentBooks = data.map((book) => book['book_kor'].toString()).toList();
      });
    }

    if (response2.statusCode == 200) {
      final List<dynamic> data = json.decode(response2.body);
      setState(() {
        newTestamentBooks = data.map((book) => book['book_kor'].toString()).toList();
      });
    }
  }

  Future<bool> _onWillPop() async {
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // 이전 페이지가 있을 때는 정상적인 pop 작동
    } else {
      // 이전 페이지가 없을 때는 HomePage로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
    return false; // 기본 뒤로 가기 동작 취소
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => _onWillPop(),
            ),
            title: Text("성경"),
            bottom: TabBar(
              tabs: [
                Tab(text: '구약'),
                Tab(text: '신약'),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              BookGridView(books: oldTestamentBooks),
              BookGridView(books: newTestamentBooks),
            ],
          ),
        ),
      ),
    );
  }
}

class BookGridView extends StatelessWidget {
  final List<String> books;

  BookGridView({required this.books});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 1,
        ),
        itemCount: books.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FirstSubPage(bookName: books[index], bookId: index + 1),
                ),
              );
            },
            child: Card(
              child: Center(
                child: Text(
                  books[index],
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'first_sub_page.dart';

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
    final response = await http.get(Uri.parse('http://localhost:3000/bibles/group'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        oldTestamentBooks = List<String>.from(data['oldTestament']);
        newTestamentBooks = List<String>.from(data['newTestament']);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
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

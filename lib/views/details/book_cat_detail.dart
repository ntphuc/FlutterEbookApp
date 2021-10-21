import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/models/books_cat.dart';

class BookCatDetail extends StatelessWidget {
  final Book book;

  const BookCatDetail({Key key, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.name),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/models/books_cat.dart';

class BookCatDetail extends StatefulWidget {
  final Book book;

  const BookCatDetail({Key key, this.book}) : super(key: key);

  @override
  State<BookCatDetail> createState() => _BookCatDetailState();
}

class _BookCatDetailState extends State<BookCatDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.name),
      ),
      body: Container(),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

import 'dart:convert';

import 'package:flutter_ebook_app/models/books.dart';
import 'package:flutter_ebook_app/services/api.dart';
import 'package:http/http.dart' as http;

class BookApi {
  static BookApi _instance;

  BookApi._();

  static BookApi get instance {
    if (_instance == null) {
      _instance = BookApi._();
    }
    return _instance;
  }

  Future<List<Book>> getAllBook() async {
    final response = await http.get(Api.bookCat);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['objects'];

      // this line will allow us to get the different book from the json file
      // and putting them into a list
      List<Book> objects = body.map((dynamic item) => Book.fromJson(item)).toList();

      return objects;
    } else {
      throw Exception("Failed to get book");
    }
  }
}

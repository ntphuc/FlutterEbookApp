import 'dart:convert';

import 'package:flutter_ebook_app/models/book_new.dart';
import 'package:flutter_ebook_app/services/api.dart';
import 'package:http/http.dart' as http;

class BookNewApi {
  static BookNewApi _instance;

  BookNewApi._();

  static BookNewApi get instance {
    if (_instance == null) {
      _instance = BookNewApi._();
    }
    return _instance;
  }

  Future<List<BookNew>> getAllBookNew() async {
    final response = await http.get(Api.tntBookNew);

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['objects'];
      print('need obj data:----' + body.length.toString());
      print(body.runtimeType);

      // this line will allow us to get the different book from the json file
      // and putting them into a list
      List<BookNew> listBookNew = body.map((dynamic item) => BookNew.fromJson(item)).toList();

      return listBookNew;
    } else {
      throw Exception("Failed to get book new");
    }
  }

  Future<List<BookNew>> getBookCatDetail(int bookTntId) async {
    final response = await http.get('${Api.getTntBookNewById}$bookTntId');

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      List<dynamic> body = json['objects'];
      print('need obj data:----' + body.length.toString());
      print(body.runtimeType);

      // this line will allow us to get the different book from the json file
      // and putting them into a list
      List<BookNew> listBookNew = body.map((dynamic item) => BookNew.fromJson(item)).toList();

      return listBookNew;
    } else {
      throw Exception("Failed to get book new");
    }
  }
}

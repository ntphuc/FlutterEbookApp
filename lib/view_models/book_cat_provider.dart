// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_ebook_app/models/book_cat_detail.dart';
import 'package:flutter_ebook_app/models/books_cat.dart';
import 'package:flutter_ebook_app/services/book_cat_api.dart';
import 'package:flutter_ebook_app/util/enum/api_request_status.dart';

class BookProvider extends ChangeNotifier {
  APIRequestStatus _apiRequestStatus = APIRequestStatus.unInitialized;

  List<Book> books = [];
  List<Root> roots = [];
  String message = '';

  BookProvider() {
    _fetchBooks();
  }

  APIRequestStatus get apiRequestStatus => _apiRequestStatus;

  Future<void> _fetchBooks() async {
    _apiRequestStatus = APIRequestStatus.loading;
    try {
      await Future.delayed(Duration(seconds: 5));
      final apiBooks = await BookApi.instance.getAllBook();
      books = apiBooks;
      _apiRequestStatus = APIRequestStatus.loaded;
    } catch (e) {
      message = '$e';
      _apiRequestStatus = APIRequestStatus.error;
    }
    notifyListeners();
  }

  Future<void> _fetchBookDetail(int bookId) async {
    _apiRequestStatus = APIRequestStatus.loading;
    try {
      await Future.delayed(Duration(seconds: 5));
      final apiBookDetail = await BookApi.instance.getBookCatDetail(bookId);
      roots = apiBookDetail;
      _apiRequestStatus = APIRequestStatus.loaded;
    } catch (e) {
      message = '$e';
      _apiRequestStatus = APIRequestStatus.error;
    }
    notifyListeners();
  }
}

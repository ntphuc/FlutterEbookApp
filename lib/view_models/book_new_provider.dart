// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter_ebook_app/models/book_new.dart';
import 'package:flutter_ebook_app/services/book_new_api.dart';
import 'package:flutter_ebook_app/util/enum/api_request_status.dart';

class BookNewProvider extends ChangeNotifier {
  APIRequestStatus _apiRequestStatus = APIRequestStatus.unInitialized;

  List<BookNew> bookNew = [];
  String message = '';

  BookNewProvider() {
    _fetchBookNew();
  }

  APIRequestStatus get apiRequestStatus => _apiRequestStatus;

  Future<void> _fetchBookNew() async {
    _apiRequestStatus = APIRequestStatus.loading;
    try {
      await Future.delayed(Duration(seconds: 5));
      final apiBookNew = await BookNewApi.instance.getAllBookNew();
      bookNew = apiBookNew;
      _apiRequestStatus = APIRequestStatus.loaded;
    } catch (e) {
      message = '$e';
      _apiRequestStatus = APIRequestStatus.error;
    }
    notifyListeners();
  }
}

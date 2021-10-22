import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/models/category.dart';
import 'package:flutter_ebook_app/util/show_toast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xml2json/xml2json.dart';

class Api {
  Dio dio = Dio();
  static String baseURL = 'https://catalog.feedbooks.com';
  static const BASE_URL = 'http://chuagiacngo.com';
  static String publicDomainURL = '$baseURL/publicdomain/browse';
  static String popular = '$publicDomainURL/top.atom';
  static String recent = '$publicDomainURL/recent.atom';
  static String awards = '$publicDomainURL/awards.atom';
  static String noteworthy = '$publicDomainURL/homepage_selection.atom';
  static String shortStory = '$publicDomainURL/top.atom?cat=FBFIC029000';
  static String sciFi = '$publicDomainURL/top.atom?cat=FBFIC028000';
  static String actionAdventure = '$publicDomainURL/top.atom?cat=FBFIC002000';
  static String mystery = '$publicDomainURL/top.atom?cat=FBFIC022000';
  static String romance = '$publicDomainURL/top.atom?cat=FBFIC027000';
  static String horror = '$publicDomainURL/top.atom?cat=FBFIC015000';

  static String bookCat = '$BASE_URL/api/v1.2/book-cat';
  static String getBookCatById = '$BASE_URL/api/v1.2/book-cat/';
  static String bookNew = '$BASE_URL/api/v1.2/tnt-book';

  static String urlBook = "http://www.africau.edu/images/default/sample.pdf";

  Future<CategoryFeed> getCategory(String url) async {
    var res = await dio.get(url).catchError((e) {
      throw (e);
    });
    CategoryFeed category;
    if (res.statusCode == 200) {
      Xml2Json xml2json = new Xml2Json();
      xml2json.parse(res.data.toString());
      var json = jsonDecode(xml2json.toGData());
      category = CategoryFeed.fromJson(json);
    } else {
      throw ('Error ${res.statusCode}');
    }
    return category;
  }

  Future downloadBook(Dio dio, String urlBook, String savePath) async {
    try {
      File file = File(savePath);
      if (await File(savePath).exists()) {
        ShowToast.showFileExists();
      } else {
        Response response = await dio.get(
          urlBook,
          onReceiveProgress: ShowToast.showDownloadProgress,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }),
        );

        var raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
      }
    } catch (e) {
      print(e);
    }
  }
}

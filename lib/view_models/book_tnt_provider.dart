// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/components/download_alert.dart';
import 'package:flutter_ebook_app/database/download_helper.dart';
import 'package:flutter_ebook_app/models/book_new.dart';
import 'package:flutter_ebook_app/services/book_tnt_new_api.dart';
import 'package:flutter_ebook_app/util/consts.dart';
import 'package:flutter_ebook_app/util/enum/api_request_status.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BookNewProvider extends ChangeNotifier {
  APIRequestStatus _apiRequestStatus = APIRequestStatus.unInitialized;

  List<BookNew> bookNew = [];
  BookNew bookDetail;
  String message = '';
  var downloadDB = DownloadsDB();

  bool loading = true;
  bool downloaded = false;

  BookNewProvider({int bookId, BuildContext context, String url, String filename}) {
    _fetchBookNew();
    if (bookId != null) _fetchBookTntDetail(bookId);
    startDownload(context, url, filename);
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

  Future<void> _fetchBookTntDetail(int bookId) async {
    _apiRequestStatus = APIRequestStatus.loading;
    setLoading(true);
    checkDownload();
    try {
      await Future.delayed(Duration(seconds: 3));
      final apiBookTntDetail =
          await BookNewApi.instance.getBookCatDetail(bookId);
      bookDetail = apiBookTntDetail;
      _apiRequestStatus = APIRequestStatus.loaded;
      setLoading(false);
    } catch (e) {
      message = '$e';
      _apiRequestStatus = APIRequestStatus.error;
    }
    notifyListeners();
  }

  // check if book has been downloaded before
  checkDownload() async {
    List downloads = await downloadDB.check({'id': bookDetail.id.toString()});
    if (downloads.isNotEmpty) {
      // check if book has been deleted
      String path = downloads[0]['path'];
      print(path);
      if (await File(path).exists()) {
        setDownloaded(true);
      } else {
        setDownloaded(false);
      }
    } else {
      setDownloaded(false);
    }
  }

  Future<List> getDownload() async {
    List c = await downloadDB.check({'id': bookDetail.id.toString()});
    return c;
  }

  addDownload(Map body) async {
    await downloadDB.removeAllWithId({'id': bookDetail.id.toString()});
    await downloadDB.add(body);
    checkDownload();
  }

  removeDownload() async {
    downloadDB.remove({'id': bookDetail.id.toString()}).then((v) {
      print(v);
      checkDownload();
    });
  }

  Future downloadFile(BuildContext context, String url, String filename) async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);

    if (permission != PermissionStatus.granted) {
      await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      startDownload(context, url, filename);
    } else {
      startDownload(context, url, filename);
    }
  }

  startDownload(BuildContext context, String url, String filename) async {
    Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      Directory(appDocDir.path.split('Android')[0] + '${Constants.appName}')
          .createSync();
    }

    String path = Platform.isIOS
        ? appDocDir.path + '/$filename.pdf'
        : appDocDir.path.split('Android')[0] +
        '${Constants.appName}/$filename.pdf';
    print('Link URL PDF: ----- ' + path);
    File file = File(path);
    if (!await file.exists()) {
      await file.create();
    } else {
      await file.delete();
      await file.create();
    }

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DownloadAlert(
        url: url,
        path: path,
      ),
    ).then((v) {
      // When the download finishes, we then add the book
      // to our local database
      if (v != null) {
        addDownload(
          {
            'id': bookDetail.id.toString(),
            'path': path,
            'image': bookDetail.cover,
            'size': v,
            'name': bookDetail.name,
          },
        );
      }
    });
  }

  void setDownloaded(value) {
    downloaded = value;
    notifyListeners();
  }

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }
}

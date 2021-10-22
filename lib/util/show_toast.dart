import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  static bool downloaded = false;

  static showDownloadProgress(received, total) {
    if (total != 1) {
      String showPercent = (received / total * 100).toStringAsFixed(0) + "%";
      downloaded = true;
      print(showPercent);
      Fluttertoast.showToast(
          msg: 'Download: ' + showPercent,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  static showFileExists() {
    Fluttertoast.showToast(
        msg: 'File đã tồn tại',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

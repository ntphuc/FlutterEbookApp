import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowToast {
  static bool downloaded = false;

  static showDownloadProgress(received, total) {
    if (total != 1) {
      String showPercent = (received / total * 100).toStringAsFixed(0) + "%";
      String downloadSuccess = "100%";
      String showMessageSuccess = "";
      if (showPercent.compareTo(downloadSuccess) != null) {
        showMessageSuccess = downloadSuccess;
      }
      downloaded = true;
      print(showPercent);
      Fluttertoast.showToast(
          msg: 'Download: ' + showMessageSuccess,
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

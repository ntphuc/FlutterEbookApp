import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ShowPdfOff extends StatefulWidget {
  const ShowPdfOff({this.file, Key key}) : super(key: key);

  final File file;

  @override
  _ShowPdfOffState createState() => _ShowPdfOffState();
}

class _ShowPdfOffState extends State<ShowPdfOff> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(
              child: Text(
            'PdfViewer',
            style: TextStyle(color: Colors.white),
          )),
        ),
        body: SfPdfViewer.file(File(widget.file.path)),
      ), //Scaffold
    ); //MaterialApp
  }
}

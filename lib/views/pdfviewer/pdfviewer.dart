// ignore_for_file: missing_return

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ebook_app/models/category.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewer extends StatefulWidget {
  Entry entry;

  PdfViewer({
    Key key,
    @required this.entry,
  }) : super(key: key);

  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool _isLoading = true;
  PDFDocument document;

  @override
  void initState() {
    super.initState();
    debugPrint("initState = " + _isLoading.toString());

    loadDocument();
    //loadFromAssets();
  }

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
        ), //Appbar
        body: SfPdfViewer.network(
          'http://conorlastowka.com/book/CitationNeededBook-Sample.pdf',
        ),
        // body: Column(
        //   children: <Widget>[
        //     Expanded(
        //       child: Center(
        //         child: _isLoading
        //             ? Center(
        //                 child:
        //                     CircularProgressIndicator(), //Shows indicator if _isLoading is true
        //               ) //Center
        //             : PDFViewer(
        //                 document: document,
        //               ), //PDFViewer
        //       ), //Center
        //     ), //Expanded
        //   ], //<Widget>[]
        // ), //Column
      ), //Scaffold
    ); //MaterialApp
  }

  void loadDocument() async {
    document = await PDFDocument.fromURL(
            "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf")
        .then((value) {
      setState(() => _isLoading = false);
      //return document;
    }).catchError((Object error) {
      return null;
    });
  }

  Future<PDFDocument> loadFromAssets() async {
    try {
      setState(() {
        _isLoading = true; //show loading
      });
      document = await PDFDocument.fromAsset("assets/pdf/read_english_3.pdf");
      setState(() {
        _isLoading = false; //remove loading
      });
      return document;
    } catch (err) {
      print('Caught error: $err');
    } //catch
  } //Future
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ebook_app/models/category.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build = " + _isLoading.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text('PdfViewer'),
      ),
      body: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : PDFViewer(document: document, zoomSteps: 1)),
    );
  }

  void loadDocument() async {
    document = await PDFDocument.fromURL(
            "http://conorlastowka.com/book/CitationNeededBook-Sample.pdf")
        .then((value) {
      setState(() => _isLoading = false);
      debugPrint("loaded document = " + _isLoading.toString());
    }).catchError((Object error) {
      debugPrint("loaded error = " + error);
    });
  }
}

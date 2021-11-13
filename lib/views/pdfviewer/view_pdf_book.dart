import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewPDFBook extends StatefulWidget {
  final String pdf;
  final String name;

  ViewPDFBook({Key key, this.pdf, this.name}) : super(key: key);

  @override
  _ViewPDFBookState createState() => _ViewPDFBookState();
}

class _ViewPDFBookState extends State<ViewPDFBook> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name}'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: SfPdfViewer.network(
        widget.pdf,
        key: _pdfViewerKey,
      ),
    );
  }
}

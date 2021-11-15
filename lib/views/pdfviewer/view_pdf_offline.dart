import 'dart:async';
import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/views/pdfviewer/show_pdf_off.dart';

class ViewPdfOffline extends StatefulWidget {
  const ViewPdfOffline({Key key}) : super(key: key);

  @override
  _ViewPdfOfflineState createState() => _ViewPdfOfflineState();
}

class _ViewPdfOfflineState extends State<ViewPdfOffline> {
  String path;
  String directoryPath;
  List<dynamic> file = new List<dynamic>();

  @override
  void initState() {
    super.initState();
    _listOfFiles();
    // _localPath;
  }

  Future<String> _listOfFiles() async {
    path = (await ExtStorage.getExternalStorageDirectory()) + "/Sách CGN/";
    print('MARKET_TEA check path: ' + path);
    setState(() {
      file = Directory("$path").listSync();
      print("MARKET_TEA: " + file.length.toString());
      directoryPath = path;
    });
    print("Directory Path is $directoryPath");
    print("Directory Path file $file");

    return directoryPath;
  }

  Future<void> deleteFiles(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Sách tải về'),
      ),
      body: file.isEmpty ? _buildEmptyListView() : _buildBodyList(),
    );
  }

  _buildBodyList() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: file.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = file[index].toString();
                  return Dismissible(
                    key: Key(item),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      deleteFiles(file.elementAt(index));
                      setState(() {
                        file.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('$item dismissed')));
                    },
                    background: Container(
                      color: Colors.red,
                      //margin: EdgeInsets.symmetric(horizontal: 15),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8.0,
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          Text(
                            'Delete',
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                    child: Card(
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowPdfOff(
                                  file: file[index],
                                ),
                              ));
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.book,
                            color: Colors.blue[800],
                            size: 40.0,
                          ),
                          title: Text(file[index].path.split('/').last),
                          // subtitle: Text(file[index].toString()),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

_buildEmptyListView() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(
          'assets/images/empty.png',
          height: 300.0,
          width: 300.0,
        ),
        Text(
          'Nothing is here',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

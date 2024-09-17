import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/components/description_text.dart';
import 'package:flutter_ebook_app/models/book_new.dart';
import 'package:flutter_ebook_app/services/api.dart';
import 'package:flutter_ebook_app/util/consts.dart';
import 'package:flutter_ebook_app/util/router.dart';
import 'package:flutter_ebook_app/util/show_toast.dart';
import 'package:flutter_ebook_app/views/pdfviewer/view_pdf_book.dart';
import 'package:flutter_ebook_app/views/pdfviewer/view_pdf_offline.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

class BookDetail extends StatefulWidget {
  final BookNew bookNew;

  BookDetail({this.bookNew});

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  @override
  void initState() {
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    Api api = new Api();

    final uuid = Uuid();
    final String imgTag = uuid.v1();
    final String titleTag = uuid.v1();
    final String authorTag = uuid.v1();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.book),
            onPressed: () async {
              MyRouter.pushPage(
                context,
                ViewPdfOffline(),
              );
            },
          ),
        ],
        title: Text(widget.bookNew.name),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            height: 180.0,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  elevation: 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                    child: Hero(
                        tag: imgTag,
                        child: Container(
                          height: 150.0,
                          width: 100.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(widget.bookNew.cover),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        )),
                  ),
                ),
                SizedBox(width: 10.0),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: titleTag,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            '${widget.bookNew.name.replaceAll(r'\', '')}',
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).textTheme.headline6.color,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Hero(
                        tag: authorTag,
                        child: Material(
                          type: MaterialType.transparency,
                          child: Text(
                            widget.bookNew.author,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w800,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // button read book file pdf
                          ElevatedButton(
                            onPressed: () {
                              MyRouter.pushPage(
                                context,
                                ViewPDFBook(
                                    pdf: widget.bookNew.pdf,
                                    name: widget.bookNew.name),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('${Constants.readBook}')],
                            ),
                          ),
                          // _buildDownloadPDF(context, widget.bookNew),
                          ElevatedButton(
                            onPressed: () async {
                              String path = await ExtStorage
                                  .getExternalStoragePublicDirectory(
                                      ExtStorage.DIRECTORY_DOWNLOADS + '/${Constants.appName}');
                              String fullPath =
                                  '$path/${widget.bookNew.name}.pdf';
                              api.downloadBook(
                                  api.dio, widget.bookNew.pdf, fullPath);
                              print('Link save book:--- ' + fullPath);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text('${Constants.downloadBook}')],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Constants.buildTitle('${Constants.bookDescription}'),
          Constants.buildDivider(),
          DescriptionTextWidget(
            text: '${Constants.bookTextDescription}',
          ),
          SizedBox(height: 10.0),
          Constants.buildTitle('${Constants.descriptionAuthor}'),
          Constants.buildDivider(),
          DescriptionTextWidget(
            text: '${Constants.bookTextAuthor}',
          ),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }
}

_buildDownloadPDF(BuildContext context, BookNew bookNew) {
  Api api = new Api();

  if (!ShowToast.downloaded) {
    return ElevatedButton(
      onPressed: () async {
        String path = await ExtStorage.getExternalStoragePublicDirectory(
            ExtStorage.DIRECTORY_DOWNLOADS + '/${Constants.appName}');
        String fullPath = '$path/${bookNew.name}.pdf';
        api.downloadBook(api.dio, bookNew.pdf, fullPath);
        print('Link save book:--- ' + fullPath);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text('Tải xuống')],
      ),
    );
  } else {
    return ElevatedButton(
        onPressed: () async {
          MyRouter.pushPage(
            context,
            ViewPdfOffline(),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Sách Offline')],
        ));
  }
}

void getPermission() async {
  await PermissionHandler().requestPermissions([PermissionGroup.storage]);
}

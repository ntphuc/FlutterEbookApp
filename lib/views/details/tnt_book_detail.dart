import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/components/description_text.dart';
import 'package:flutter_ebook_app/components/loading_widget.dart';
import 'package:flutter_ebook_app/services/api.dart';
import 'package:flutter_ebook_app/util/consts.dart';
import 'package:flutter_ebook_app/util/enum/api_request_status.dart';
import 'package:flutter_ebook_app/util/router.dart';
import 'package:flutter_ebook_app/view_models/book_tnt_provider.dart';
import 'package:flutter_ebook_app/views/pdfviewer/view_pdf_book.dart';
import 'package:flutter_ebook_app/views/pdfviewer/view_pdf_offline.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class TntBookDetail extends StatefulWidget {
  const TntBookDetail({Key key, this.bookId, this.bookName}) : super(key: key);

  final int bookId;
  final String bookName;

  @override
  _TntBookDetailState createState() => _TntBookDetailState();
}

class _TntBookDetailState extends State<TntBookDetail> {
  Api api = new Api();

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.bookName),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            child: ChangeNotifierProvider(
              create: (context) => BookNewProvider(bookId: widget.bookId),
              child: Builder(builder: (context) {
                final model = Provider.of<BookNewProvider>(context);
                if (model.apiRequestStatus == APIRequestStatus.loading) {
                  return Container(
                    height: 200.0,
                    child: LoadingWidget(),
                  );
                }
                if (model.apiRequestStatus == APIRequestStatus.error) {
                  print('Error is: --------' + model.message);
                  return Center(
                      child: Text('An Error Occurred ${model.message}'));
                }
                final books = model.bookDetail;
                print('BOOK LENGTH is: --------' + books.toString());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 150.0,
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
                                  tag: "imgTag",
                                  child: Container(
                                    height: 150.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(books.cover),
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
                                  tag: "titleTag",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      '${books.name.replaceAll(r'\', '')}',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
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
                                  tag: "authorTag",
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                      books.author,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // button read book file pdf
                                    ElevatedButton(
                                      onPressed: () {
                                        MyRouter.pushPage(
                                          context,
                                          ViewPDFBook(
                                              pdf: books.pdf, name: books.name),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('${Constants.readBook}')
                                        ],
                                      ),
                                    ),
                                    //_buildDownloadPDF(context, widget.bookNew),
                                    ElevatedButton(
                                      onPressed: () => BookNewProvider().downloadFile(
                                        context,
                                        books.pdf,
                                        books.name,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('${Constants.downloadBook}')
                                        ],
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
                  ),
                );
              }),
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

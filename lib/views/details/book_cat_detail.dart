import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/components/loading_widget.dart';
import 'package:flutter_ebook_app/models/books_cat.dart';
import 'package:flutter_ebook_app/util/enum/api_request_status.dart';
import 'package:flutter_ebook_app/view_models/book_cat_provider.dart';
import 'package:provider/provider.dart';

class BookCatDetail extends StatefulWidget {
  final Book book;

  const BookCatDetail({Key key, this.book}) : super(key: key);

  @override
  State<BookCatDetail> createState() => _BookCatDetailState();
}

class _BookCatDetailState extends State<BookCatDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.name),
      ),
      body: Container(
        child: ChangeNotifierProvider(
          create: (context) => BookProvider(bookId: widget.book.id),
          child: Builder(builder: (context) {
            final model = Provider.of<BookProvider>(context);
            if (model.apiRequestStatus == APIRequestStatus.loading) {
              return Container(
                height: 200.0,
                child: LoadingWidget(),
              );
            }
            if (model.apiRequestStatus == APIRequestStatus.error) {
              print('Error is: --------' + model.message);
              return Center(child: Text('An Error Occurred ${model.message}'));
            }
            final books = model.child;
            return ListView.builder(
              primary: false,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              scrollDirection: Axis.vertical,
              itemCount: books.objects.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final book = books.objects[index];
                return InkWell(
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
                                        image: NetworkImage(book.cover),
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
                                    '${book.name.replaceAll(r'\', '')}',
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
                                    book.author,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w800,
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                '${book.type.length < 100 ? book.type : book.type.substring(0, 100)}...'
                                    .replaceAll(r'\n', '\n')
                                    .replaceAll(r'\r', '')
                                    .replaceAll(r'\"', '"'),
                                style: TextStyle(
                                  fontSize: 13.0,
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}

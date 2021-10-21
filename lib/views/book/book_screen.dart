import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/components/book_new_item.dart';
import 'package:flutter_ebook_app/components/loading_widget.dart';
import 'package:flutter_ebook_app/util/enum/api_request_status.dart';
import 'package:flutter_ebook_app/util/router.dart';
import 'package:flutter_ebook_app/view_models/book_new_provider.dart';
import 'package:flutter_ebook_app/view_models/book_cat_provider.dart';
import 'package:provider/provider.dart';

import '../details/book_cat_detail.dart';

class BookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Of Books'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: <Widget>[
        _buildFeaturedListBook(),
        SizedBox(height: 10.0),
        _buildSectionTitle('List Book New'),
        SizedBox(height: 10.0),
        _buildFeaturedListBookNew()
      ],
    );
  }

  _buildFeaturedListBook() {
    return Container(
      height: 50.0,
      child: Center(
        child: ChangeNotifierProvider(
          create: (context) => BookProvider(),
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
            final books = model.books;
            return Container(
              height: 50.0,
              child: Center(
                child: ListView.builder(
                  primary: false,
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: books.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          onTap: () {
                            MyRouter.pushPage(
                              context,
                              BookCatDetail(book: book),
                            );
                            print('${book.resource_uri}');
                          },
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                '${book.name}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$title',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  _buildFeaturedListBookNew() {
    return Container(
      child: Center(
        child: ChangeNotifierProvider(
          create: (context) => BookNewProvider(),
          child: Builder(builder: (context) {
            final bookNew = Provider.of<BookNewProvider>(context);

            if (bookNew.apiRequestStatus == APIRequestStatus.loading) {
              return Container(
                height: 200.0,
                child: LoadingWidget(),
              );
            }
            if (bookNew.apiRequestStatus == APIRequestStatus.error) {
              print('Error is: --------' + bookNew.message);
              return Center(
                  child: Text('An Error Occurred ${bookNew.message}'));
            }
            final abc = bookNew.bookNew;
            return ListView.builder(
              primary: false,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              scrollDirection: Axis.vertical,
              itemCount: abc.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final book = abc[index];
                return customListTitle(book, context);
              },
            );
          }),
        ),
      ),
    );
  }
}

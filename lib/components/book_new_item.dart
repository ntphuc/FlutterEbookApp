import 'package:flutter/material.dart';
import 'package:flutter_ebook_app/models/book_new.dart';
import 'package:flutter_ebook_app/util/consts.dart';
import 'package:flutter_ebook_app/util/router.dart';
import 'package:flutter_ebook_app/views/details/book_detail_screen.dart';
import 'package:uuid/uuid.dart';

Widget customListTitle(BookNew bookNew, BuildContext context) {
  final uuid = Uuid();
  final String imgTag = uuid.v4();
  final String titleTag = uuid.v4();
  final String authorTag = uuid.v4();

  return InkWell(
    onTap: () {
      MyRouter.pushPage(
        context,
        BookDetail(bookNew: bookNew),
      );
    },
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
                  tag: imgTag,
                  child: Container(
                    height: 150.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(bookNew.cover),
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
                      '${bookNew.name.replaceAll(r'\', '')}',
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.headline6.color,
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
                      bookNew.author,
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w800,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text((bookNew.content == null)
                    ? '${Constants.bookTextDescription.length < 100 ? Constants.bookTextDescription : Constants.bookTextDescription.substring(0, 100)}...'
                        .replaceAll(r'\n', '\n')
                        .replaceAll(r'\r', '')
                        .replaceAll(r'\"', '"')
                    : bookNew.content),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

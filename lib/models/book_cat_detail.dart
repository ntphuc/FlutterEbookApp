class Publisher {
  int id;
  String name;
  String resource_uri;
  String enitytType;
  String hdepth;
  String hweight;
}

class Object {
  int id;
  String name;
  String resource_uri;
  String type;
  int created;
  int sticky;
  int changed;
  String cover;
  String author;
  int year;
  Publisher publisher;
  String isbn;
  String content;
  int q_album;
  String pdf;
  int pdfSize;
}

class Meta {
  int total_count;
  Object previous;
  String limit;
  String next;
}

class Child {
  List<Object> objects;
  Meta meta;
}

class Root {
  int id;
  String name;
  String resource_uri;
  String enitytType;
  String hdepth;
  String hweight;
  Child child;
}

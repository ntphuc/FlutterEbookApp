class BookNew {
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
  //Category category;
  //Publisher publisher;
  String isbn;
  String content;
  int q_album;
  String pdf;
  int pdfSize;

  BookNew(
      {this.id,
      this.name,
      this.resource_uri,
      this.type,
      this.created,
      this.sticky,
      this.changed,
      this.cover,
      this.author,
      this.year,
      //this.category,
      //this.publisher,
      this.isbn,
      this.content,
      this.q_album,
      this.pdf,
      this.pdfSize});

  BookNew.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    resource_uri = json['resource_uri'];
    type = json['type'];
    created = json['created'];
    sticky = json['sticky'];
    changed = json['changed'];
    cover = json['cover'];
    author = json['author'];
    year = json['year'];
    // category =
    //     json['category'] != null ? Category.fromJson(json['category']) : null;
    // publisher = json['publisher'] != null
    //     ? Publisher.fromJson(json['publisher'])
    //     : null;
    isbn = json['isbn'];
    content = json['content'];
    q_album = json['q_album'];
    pdf = json['pdf'];
    pdfSize = json['pdfSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['resource_uri'] = this.resource_uri;
    data['type'] = this.type;
    data['created'] = this.created;
    data['sticky'] = this.sticky;
    data['changed'] = this.changed;
    data['cover'] = this.cover;
    data['author'] = this.author;
    data['year'] = this.year;
    // if (this.category != null) {
    //   data['category'] = this.category.toJson();
    // }
    // if (this.publisher != null) {
    //   data['publisher'] = this.publisher.toJson();
    // }
    data['isbn'] = this.isbn;
    data['content'] = this.content;
    data['q_album'] = this.q_album;
    data['pdf'] = this.pdf;
    data['pdfSize'] = this.pdfSize;

    return data;
  }
}

class Category {
  int id;
  String name;
  String resource_uri;
  String enitytType;
  String hdepth;
  String hweight;

  Category({
    this.id,
    this.name,
    this.resource_uri,
    this.enitytType,
    this.hdepth,
    this.hweight,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    resource_uri = json['resource_uri'];
    enitytType = json['enitytType'];
    hdepth = json['hdepth'];
    hweight = json['hweight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['resource_uri'] = this.resource_uri;
    data['enitytType'] = this.enitytType;
    data['hdepth'] = this.hdepth;
    data['hweight'] = this.hweight;
    return data;
  }
}

class Publisher {
  int id;
  String name;
  String resource_uri;
  String enitytType;
  String hdepth;
  String hweight;

  Publisher({
    this.id,
    this.name,
    this.resource_uri,
    this.enitytType,
    this.hdepth,
    this.hweight,
  });

  Publisher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    resource_uri = json['resource_uri'];
    enitytType = json['enitytType'];
    hdepth = json['hdepth'];
    hweight = json['hweight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['resource_uri'] = this.resource_uri;
    data['enitytType'] = this.enitytType;
    data['hdepth'] = this.hdepth;
    data['hweight'] = this.hweight;
    return data;
  }
}

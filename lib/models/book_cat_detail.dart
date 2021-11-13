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

  Object(
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
      this.publisher,
      this.isbn,
      this.content,
      this.q_album,
      this.pdf,
      this.pdfSize});

  Object.fromJson(Map<String, dynamic> json) {
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
    publisher = json['publisher'] != null
        ? Publisher.fromJson(json['publisher'])
        : null;
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
    if (this.publisher != null) {
      data['publisher'] = this.publisher.toJson();
    }
    data['isbn'] = this.isbn;
    data['content'] = this.content;
    data['q_album'] = this.q_album;
    data['pdf'] = this.pdf;
    data['pdfSize'] = this.pdfSize;

    return data;
  }
}

class Meta {
  int total_count;

  //Object previous;
  String limit;
  String next;

  Meta({this.total_count, this.limit, this.next});

  Meta.fromJson(Map<String, dynamic> json) {
    total_count = json['total_count'];
    limit = json['limit'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['total_count'] = this.total_count;
    data['limit'] = this.limit;
    data['next'] = this.next;

    return data;
  }
}

class Child {
  List<Object> objects;
  Meta meta;

  Child({this.objects, this.meta});

  Child.fromJson(Map<String, dynamic> json) {
    objects = json["objects"] == null
        ? null
        : List<Object>.from(json["objects"].map((x) => Object.fromJson(x)));
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.objects != null) {
      List<dynamic>.from(objects.map((x) => x.toJson()));
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }

    return data;
  }
}

class Root {
  int id;
  String name;
  String resource_uri;
  String enitytType;
  String hdepth;
  String hweight;
  Child child;

  Root(
      {this.id,
      this.name,
      this.resource_uri,
      this.enitytType,
      this.hdepth,
      this.hweight,
      this.child});

  Root.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    resource_uri = json['resource_uri'];
    enitytType = json['enitytType'];
    hdepth = json['hdepth'];
    hweight = json['hweight'];
    child = json['child'] != null ? Child.fromJson(json['child']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['resource_uri'] = this.resource_uri;
    data['enitytType'] = this.enitytType;
    data['hdepth'] = this.hdepth;
    data['hweight'] = this.hweight;
    if (this.child != null) {
      data['child'] = this.child.toJson();
    }

    return data;
  }
}

class Book {
  int id;
  String name;
  String resource_uri;
  String enitytType;
  String hdepth;
  String hweight;
  String thumbnail;

  Book({
    this.id,
    this.name,
    this.resource_uri,
    this.enitytType,
    this.hdepth,
    this.hweight,
    this.thumbnail,
  });

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    resource_uri = json['resource_uri'];
    enitytType = json['enitytType'];
    hdepth = json['hdepth'];
    hweight = json['hweight'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['resource_uri'] = this.resource_uri;
    data['enitytType'] = this.enitytType;
    data['hdepth'] = this.hdepth;
    data['hweight'] = this.hweight;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}

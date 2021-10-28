import 'dart:math';

class Constants {
  //App related strings
  static String appName = 'Sách CGN';
  static String bookCategories = 'Danh mục sách';
  static String bookSpecial = 'Sách mới nổi bật';

  static formatBytes(bytes, decimals) {
    if (bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }
}

import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  //App related strings
  static String appName = 'Sách CGN';
  static String bookCategories = 'Danh mục sách';
  static String bookDescription = 'Mô tả sách';
  static String descriptionAuthor = 'Thông tin về tác giả';
  static String bookTextAuthor = 'Thích Nhật Từ tên khai sinh là Trần Ngọc Thảo, sinh ngày 1 tháng 4 năm 1969 tại Sài Gòn. Giác ngộ chân lý Phật vào năm 1983, sau thời gian đi chùa Long Huê, Quận Gò Vấp và Chùa Đại Giác, quận Phú Nhuận, ông xuất gia vào năm 1984 tại chùa Giác Ngộ với Hòa thượng Thích Thiện Huệ lúc 14 tuổi, thọ giới tỳ kheo năm 1988. Sư du học tại Ấn Độ năm 1994 và tốt nghiệp thạc sĩ triết học năm 1997 và tiến sĩ triết học năm 2001.Thích Nhật Từ là người sáng lập "Hội Ấn Tống đạo Phật ngày nay", "Hội Từ thiện đạo Phật ngày nay" và chủ nhiệm Đại Tạng kinh Việt Nam.';
  static String bookSpecial = 'Sách mới nổi bật';
  static String bookTextDescription = 'NSGN - Tính đến nay, nền văn học Phật giáo đã có lịch sử trên 2000 năm với nhiều sự thăng trầm và biến động. Ngoài những tác phẩm văn học Phật giáo dân gian, văn học Phật giáo truyền miệng, với hàng vạn tác phẩm lớn nhỏ, phân làm 12 loại thể, hàm chứa những giá trị tuệ giác, nhân văn và nghệ thuật lớn. Có thể khẳng định, văn học Phật giáo là một nền văn học lớn của văn học thế giới, có vị trí xứng đáng trong kho tàng văn hóa nhân loại.';

  static formatBytes(bytes, decimals) {
    if (bytes == 0) return 0.0;
    var k = 1024,
        dm = decimals <= 0 ? 0 : decimals,
        sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'],
        i = (log(bytes) / log(k)).floor();
    return (((bytes / pow(k, i)).toStringAsFixed(dm)) + ' ' + sizes[i]);
  }

  static buildSectionTitle(String title) {
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


  static buildDivider() {
    return Divider(
      color: Colors.grey,
    );
  }

  static buildTitle(String title) {
    return Text(
      '$title',
      style: TextStyle(
        color: Colors.blue,
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Category {
  int categoryId;
  String name;
  IconData icon;

  Category({
    this.categoryId,
    this.name,
    this.icon,
  });
}

final dynamic test = 'Feater.printer';

List<Category> categoryList = [
  Category(categoryId: 0, name: 'Computer & Office', icon: test),
  Category(categoryId: 1, name: 'TV & Audio', icon: Feather.speaker),
  Category(categoryId: 2, name: 'Household', icon: Ionicons.ios_restaurant),
  Category(categoryId: 3, name: 'DIY', icon: Ionicons.ios_construct),
  Category(categoryId: 4, name: 'Phote & Drones', icon: Feather.video),
  Category(
      categoryId: 5, name: 'Sports & Freetime', icon: Ionicons.ios_bicycle),
];

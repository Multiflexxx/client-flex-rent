// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    categoryId: json['category_id'] as int,
    name: json['name'] as String,
    pictureLink: json['picture_link'] as String,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('category_id', instance.categoryId);
  writeNotNull('name', instance.name);
  writeNotNull('picture_link', instance.pictureLink);
  return val;
}

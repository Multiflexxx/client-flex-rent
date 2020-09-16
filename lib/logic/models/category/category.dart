import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'category.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Category {
  final int categoryId;
  final String name;
  final String pictureLink;

  Category({@required this.categoryId, @required this.name, this.pictureLink});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

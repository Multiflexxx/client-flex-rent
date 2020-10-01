import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:rent/logic/models/models.dart';
part 'newOffer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class NewOffer {
  String sessionId;
  String userId;
  String title;
  String description;
  double price;
  int categoryId;

  NewOffer(
      {
        this.sessionId,
        this.userId,
        this.title,
        this.description,
        this.price,
        this.categoryId,
      });

  factory NewOffer.fromJson(Map<String, dynamic> json) => _$NewOfferFromJson(json);
  Map<String, dynamic> toJson() => _$NewOfferToJson(this);
}
import 'package:json_annotation/json_annotation.dart';
import 'package:rent/logic/models/models.dart';
part 'offer.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Offer {
  String offerId;
  String title;
  String description;
  double rating;
  int numberOfRatings;
  double price;
  Category category;
  List<String> pictureLinks;
  Lessor lessor;

  Offer(
      {this.offerId,
      this.title,
      this.description,
      this.rating,
      this.numberOfRatings,
      this.price,
      this.category,
      this.pictureLinks,
      this.lessor});

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
  Map<String, dynamic> toJson() => _$OfferToJson(this);
}

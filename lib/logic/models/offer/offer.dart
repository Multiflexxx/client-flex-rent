import 'package:json_annotation/json_annotation.dart';
import 'package:flexrent/logic/models/models.dart';
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
  User lessor;
  List<DateRange> blockedDates;

  Offer(
      {this.offerId,
      this.title,
      this.description,
      this.rating,
      this.numberOfRatings,
      this.price,
      this.category,
      this.pictureLinks,
      this.lessor,
      this.blockedDates});

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);
  Map<String, dynamic> toJson() => _$OfferToJson(this);
}

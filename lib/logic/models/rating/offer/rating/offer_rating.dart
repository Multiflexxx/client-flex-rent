import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'offer_rating.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OfferRating extends Equatable implements Rating {
  final String ratingId;
  final String ratingType;
  final int rating;
  final String headline;
  final String ratingText;
  final DateTime updatedAt;
  final User ratingOwner;

  OfferRating({
    this.ratingId,
    this.ratingType,
    this.rating,
    this.headline,
    this.ratingText,
    this.updatedAt,
    this.ratingOwner,
  });

  factory OfferRating.fromJson(Map<String, dynamic> json) =>
      _$OfferRatingFromJson(json);
  Map<String, dynamic> toJson() => _$OfferRatingToJson(this);

  @override
  List<Object> get props =>
      [ratingOwner, ratingType, rating, headline, ratingText, updatedAt];
}

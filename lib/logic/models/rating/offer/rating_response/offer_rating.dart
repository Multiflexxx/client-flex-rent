import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'offer_rating.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OfferRating extends Equatable {
  final String ratingId;
  final User ratingOwner;
  // final Offer offer;
  final int rating;
  final String headline;
  final String ratingText;
  final DateTime lastUpdated;

  OfferRating(
    this.ratingId, {
    this.ratingOwner,
    this.rating,
    this.headline,
    this.ratingText,
    this.lastUpdated,
  });

  factory OfferRating.fromJson(Map<String, dynamic> json) =>
      _$OfferRatingFromJson(json);
  Map<String, dynamic> toJson() => _$OfferRatingToJson(this);

  @override
  List<Object> get props =>
      [ratingOwner, rating, headline, ratingText, lastUpdated];
}

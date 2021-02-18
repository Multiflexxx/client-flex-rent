import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'offer_rating_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OfferRatingRequest extends Equatable {
  final Offer offer;
  final int rating;
  final String headline;
  final String ratingText;

  OfferRatingRequest({this.offer, this.rating, this.headline, this.ratingText});

  factory OfferRatingRequest.fromJson(Map<String, dynamic> json) =>
      _$OfferRatingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OfferRatingRequestToJson(this);

  @override
  List<Object> get props => [offer, rating, headline, ratingText];
}

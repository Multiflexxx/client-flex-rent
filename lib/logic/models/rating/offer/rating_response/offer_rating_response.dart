import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'offer_rating_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OfferRatingResponse extends Equatable {
  final List<OfferRating> offerRatings;
  final int currentPage;
  final int maxPage;
  final int elementsPerPage;

  OfferRatingResponse({
    this.offerRatings,
    this.currentPage,
    this.maxPage,
    this.elementsPerPage,
  });

  factory OfferRatingResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferRatingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OfferRatingResponseToJson(this);

  @override
  List<Object> get props => [];
}

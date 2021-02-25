import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rating.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Rating extends Equatable {
  final String ratingId;
  final String ratingType;
  final int rating;
  final String headline;
  final String ratingText;
  final User ratingOwner;
  final DateTime updatedAt;

  Rating({
    this.ratingId,
    this.ratingType,
    this.rating,
    this.headline,
    this.ratingText,
    this.ratingOwner,
    this.updatedAt,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
  Map<String, dynamic> toJson() => _$RatingToJson(this);

  @override
  List<Object> get props => [
        ratingId,
        ratingType,
        rating,
        headline,
        ratingText,
        ratingOwner,
        updatedAt,
      ];
}

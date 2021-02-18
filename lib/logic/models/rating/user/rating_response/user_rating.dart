import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_rating.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserRating extends Equatable {
  final int ratingId;
  final String ratedUserId;
  final String ratingType;
  final int rating;
  final String headline;
  final String ratingText;
  final DateTime createdAt;

  UserRating(
      {this.ratingId,
      this.ratedUserId,
      this.ratingType,
      this.rating,
      this.headline,
      this.ratingText,
      this.createdAt});

  factory UserRating.fromJson(Map<String, dynamic> json) =>
      _$UserRatingFromJson(json);
  Map<String, dynamic> toJson() => _$UserRatingToJson(this);

  @override
  List<Object> get props => [
        ratingId,
        ratedUserId,
        ratingType,
        rating,
        headline,
        ratingText,
        createdAt,
      ];
}

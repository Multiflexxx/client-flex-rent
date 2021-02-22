import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_rating.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserRating extends Equatable {
  final String ratingId;
  final String ratingType;
  final int rating;
  final String headline;
  final String ratingText;
  final User ratedUser;
  final User ratingOwner;
  final DateTime updatedAt;

  UserRating(
      {this.ratingId,
      this.ratingType,
      this.rating,
      this.headline,
      this.ratingText,
      this.ratedUser,
      this.ratingOwner,
      this.updatedAt});

  factory UserRating.fromJson(Map<String, dynamic> json) =>
      _$UserRatingFromJson(json);
  Map<String, dynamic> toJson() => _$UserRatingToJson(this);

  @override
  List<Object> get props => [
        ratingId,
        ratingType,
        rating,
        headline,
        ratingText,
        ratedUser,
        ratingOwner,
        updatedAt,
      ];
}

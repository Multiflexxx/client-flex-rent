import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_rating_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class UserRatingRequest extends Equatable {
  final String userId;
  final String ratingType;
  final int rating;
  final String headline;
  final String text;

  UserRatingRequest(
      {this.userId, this.ratingType, this.rating, this.headline, this.text});

  factory UserRatingRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRatingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UserRatingRequestToJson(this);

  @override
  List<Object> get props => [
        userId,
        ratingType,
        rating,
        headline,
        text,
      ];
}

import 'package:equatable/equatable.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_rating_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserRatingResponse extends Equatable {
  final List<UserRating> userRatings;
  final int currentPage;
  final int maxPage;
  final int elementsPerPage;

  UserRatingResponse(
      {this.userRatings, this.currentPage, this.maxPage, this.elementsPerPage});

  factory UserRatingResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRatingResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserRatingResponseToJson(this);

  @override
  List<Object> get props => [
        userRatings,
        currentPage,
        maxPage,
        elementsPerPage,
      ];
}

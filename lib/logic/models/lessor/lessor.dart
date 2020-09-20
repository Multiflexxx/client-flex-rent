import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'lessor.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Lessor {
  final String userId;
  final String firstName;
  final String lastName;
  final String postCode;
  final String city;
  final int verified;
  final double lessorRating;
  final int numberOfLessorRatings;

  Lessor(
      {@required this.userId,
      @required this.firstName,
      @required this.lastName,
      @required this.postCode,
      @required this.city,
      @required this.verified,
      @required this.lessorRating,
      @required this.numberOfLessorRatings});

  factory Lessor.fromJson(Map<String, dynamic> json) => _$LessorFromJson(json);
  Map<String, dynamic> toJson() => _$LessorToJson(this);
}

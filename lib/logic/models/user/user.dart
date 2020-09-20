import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String passwordHash;
  final int verified;
  final int placeId;
  final String postCode;
  final String city;
  final String street;
  final String houseNumber;
  final double lesseeRating;
  final int numberOfLesseeRatings;
  final double lessorRating;
  final int numberOfLessorRatings;
  final dynamic dateOfBirth;

  User(
      {@required this.userId,
      @required this.firstName,
      @required this.lastName,
      this.email,
      this.phoneNumber,
      this.passwordHash,
      @required this.verified,
      this.placeId,
      this.postCode,
      this.city,
      this.street,
      this.houseNumber,
      @required this.lesseeRating,
      @required this.numberOfLesseeRatings,
      @required this.lessorRating,
      @required this.numberOfLessorRatings,
      @required this.dateOfBirth});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

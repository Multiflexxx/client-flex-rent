import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class User {
  final String userId;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String passwordHash;
  final bool verified;
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
  final String profilePicture;

  User(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.passwordHash,
      this.verified,
      this.placeId,
      this.postCode,
      this.city,
      this.street,
      this.houseNumber,
      this.lesseeRating,
      this.numberOfLesseeRatings,
      this.lessorRating,
      this.numberOfLessorRatings,
      this.dateOfBirth,
      this.profilePicture});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

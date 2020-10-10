// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    userId: json['user_id'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    email: json['email'] as String,
    phoneNumber: json['phone_number'] as String,
    passwordHash: json['password_hash'] as String,
    verified: json['verified'] as bool,
    placeId: json['place_id'] as int,
    postCode: json['post_code'] as String,
    city: json['city'] as String,
    street: json['street'] as String,
    houseNumber: json['house_number'] as String,
    lesseeRating: (json['lessee_rating'] as num)?.toDouble(),
    numberOfLesseeRatings: json['number_of_lessee_ratings'] as int,
    lessorRating: (json['lessor_rating'] as num)?.toDouble(),
    numberOfLessorRatings: json['number_of_lessor_ratings'] as int,
    dateOfBirth: json['date_of_birth'],
    profilePicture: json['profile_picture'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_id', instance.userId);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('email', instance.email);
  writeNotNull('phone_number', instance.phoneNumber);
  writeNotNull('password_hash', instance.passwordHash);
  writeNotNull('verified', instance.verified);
  writeNotNull('place_id', instance.placeId);
  writeNotNull('post_code', instance.postCode);
  writeNotNull('city', instance.city);
  writeNotNull('street', instance.street);
  writeNotNull('house_number', instance.houseNumber);
  writeNotNull('lessee_rating', instance.lesseeRating);
  writeNotNull('number_of_lessee_ratings', instance.numberOfLesseeRatings);
  writeNotNull('lessor_rating', instance.lessorRating);
  writeNotNull('number_of_lessor_ratings', instance.numberOfLessorRatings);
  writeNotNull('date_of_birth', instance.dateOfBirth);
  writeNotNull('profile_picture', instance.profilePicture);
  return val;
}

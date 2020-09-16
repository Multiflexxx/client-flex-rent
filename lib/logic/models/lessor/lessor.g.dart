// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lessor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lessor _$LessorFromJson(Map<String, dynamic> json) {
  return Lessor(
    userId: json['user_id'] as String,
    firstName: json['first_name'] as String,
    lastName: json['last_name'] as String,
    postCode: json['post_code'] as String,
    city: json['city'] as String,
    verified: json['verified'] as int,
    lessorRating: (json['lessor_rating'] as num)?.toDouble(),
    numberOfLessorRatings: json['number_of_lessor_ratings'] as int,
  );
}

Map<String, dynamic> _$LessorToJson(Lessor instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_id', instance.userId);
  writeNotNull('first_name', instance.firstName);
  writeNotNull('last_name', instance.lastName);
  writeNotNull('post_code', instance.postCode);
  writeNotNull('city', instance.city);
  writeNotNull('verified', instance.verified);
  writeNotNull('lessor_rating', instance.lessorRating);
  writeNotNull('number_of_lessor_ratings', instance.numberOfLessorRatings);
  return val;
}

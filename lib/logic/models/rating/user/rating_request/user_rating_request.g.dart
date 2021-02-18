// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRatingRequest _$UserRatingRequestFromJson(Map<String, dynamic> json) {
  return UserRatingRequest(
    userId: json['user_id'] as String,
    ratingType: json['rating_type'] as String,
    rating: json['rating'] as int,
    headline: json['headline'] as String,
    text: json['text'] as String,
  );
}

Map<String, dynamic> _$UserRatingRequestToJson(UserRatingRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_id', instance.userId);
  writeNotNull('rating_type', instance.ratingType);
  writeNotNull('rating', instance.rating);
  writeNotNull('headline', instance.headline);
  writeNotNull('text', instance.text);
  return val;
}

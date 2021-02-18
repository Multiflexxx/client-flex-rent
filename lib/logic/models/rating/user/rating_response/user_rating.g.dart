// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRating _$UserRatingFromJson(Map<String, dynamic> json) {
  return UserRating(
    ratingId: json['rating_id'] as int,
    ratedUserId: json['rated_user_id'] as String,
    ratingType: json['rating_type'] as String,
    rating: json['rating'] as int,
    headline: json['headline'] as String,
    ratingText: json['rating_text'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$UserRatingToJson(UserRating instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rating_id', instance.ratingId);
  writeNotNull('rated_user_id', instance.ratedUserId);
  writeNotNull('rating_type', instance.ratingType);
  writeNotNull('rating', instance.rating);
  writeNotNull('headline', instance.headline);
  writeNotNull('rating_text', instance.ratingText);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  return val;
}

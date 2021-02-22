// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRating _$UserRatingFromJson(Map<String, dynamic> json) {
  return UserRating(
    ratingId: json['rating_id'] as String,
    ratingType: json['rating_type'] as String,
    rating: json['rating'] as int,
    headline: json['headline'] as String,
    ratingText: json['rating_text'] as String,
    ratedUser: json['rated_user'] == null
        ? null
        : User.fromJson(json['rated_user'] as Map<String, dynamic>),
    ratingOwner: json['rating_owner'] == null
        ? null
        : User.fromJson(json['rating_owner'] as Map<String, dynamic>),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
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
  writeNotNull('rating_type', instance.ratingType);
  writeNotNull('rating', instance.rating);
  writeNotNull('headline', instance.headline);
  writeNotNull('rating_text', instance.ratingText);
  writeNotNull('rated_user', instance.ratedUser);
  writeNotNull('rating_owner', instance.ratingOwner);
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  return val;
}

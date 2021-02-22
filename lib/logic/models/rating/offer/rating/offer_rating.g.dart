// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferRating _$OfferRatingFromJson(Map<String, dynamic> json) {
  return OfferRating(
    ratingId: json['rating_id'] as String,
    rating: json['rating'] as int,
    headline: json['headline'] as String,
    ratingText: json['rating_text'] as String,
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    ratingOwner: json['rating_owner'] == null
        ? null
        : User.fromJson(json['rating_owner'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OfferRatingToJson(OfferRating instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rating_id', instance.ratingId);
  writeNotNull('rating', instance.rating);
  writeNotNull('headline', instance.headline);
  writeNotNull('rating_text', instance.ratingText);
  writeNotNull('updated_at', instance.updatedAt?.toIso8601String());
  writeNotNull('rating_owner', instance.ratingOwner);
  return val;
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferRating _$OfferRatingFromJson(Map<String, dynamic> json) {
  return OfferRating(
    json['rating_id'] as String,
    ratingOwner: json['rating_owner'] == null
        ? null
        : User.fromJson(json['rating_owner'] as Map<String, dynamic>),
    rating: json['rating'] as int,
    headline: json['headline'] as String,
    ratingText: json['rating_text'] as String,
    lastUpdated: json['last_updated'] == null
        ? null
        : DateTime.parse(json['last_updated'] as String),
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
  writeNotNull('rating_owner', instance.ratingOwner);
  writeNotNull('rating', instance.rating);
  writeNotNull('headline', instance.headline);
  writeNotNull('rating_text', instance.ratingText);
  writeNotNull('last_updated', instance.lastUpdated?.toIso8601String());
  return val;
}

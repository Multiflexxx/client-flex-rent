// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_rating_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferRatingRequest _$OfferRatingRequestFromJson(Map<String, dynamic> json) {
  return OfferRatingRequest(
    offer: json['offer'] == null
        ? null
        : Offer.fromJson(json['offer'] as Map<String, dynamic>),
    rating: json['rating'] as int,
    headline: json['headline'] as String,
    ratingText: json['rating_text'] as String,
  );
}

Map<String, dynamic> _$OfferRatingRequestToJson(OfferRatingRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offer', instance.offer);
  writeNotNull('rating', instance.rating);
  writeNotNull('headline', instance.headline);
  writeNotNull('rating_text', instance.ratingText);
  return val;
}

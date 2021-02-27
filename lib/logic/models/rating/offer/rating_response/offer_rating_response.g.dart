// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferRatingResponse _$OfferRatingResponseFromJson(Map<String, dynamic> json) {
  return OfferRatingResponse(
    offerRatings: (json['offer_ratings'] as List)
        ?.map((e) =>
            e == null ? null : OfferRating.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPage: json['current_page'] as int,
    maxPage: json['max_page'] as int,
    elementsPerPage: json['elements_per_page'] as int,
  );
}

Map<String, dynamic> _$OfferRatingResponseToJson(OfferRatingResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offer_ratings', instance.offerRatings);
  writeNotNull('current_page', instance.currentPage);
  writeNotNull('max_page', instance.maxPage);
  writeNotNull('elements_per_page', instance.elementsPerPage);
  return val;
}

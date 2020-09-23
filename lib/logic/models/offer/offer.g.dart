// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Offer _$OfferFromJson(Map<String, dynamic> json) {
  return Offer(
    offerId: json['offer_id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    rating: (json['rating'] as num)?.toDouble(),
    numberOfRatings: json['number_of_ratings'] as int,
    price: (json['price'] as num)?.toDouble(),
    category: json['category'] == null
        ? null
        : Category.fromJson(json['category'] as Map<String, dynamic>),
    pictureLinks:
        (json['picture_links'] as List)?.map((e) => e as String)?.toList(),
    lessor: json['lessor'] == null
        ? null
        : Lessor.fromJson(json['lessor'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$OfferToJson(Offer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('offer_id', instance.offerId);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('rating', instance.rating);
  writeNotNull('number_of_ratings', instance.numberOfRatings);
  writeNotNull('price', instance.price);
  writeNotNull('category', instance.category);
  writeNotNull('picture_links', instance.pictureLinks);
  writeNotNull('lessor', instance.lessor);
  return val;
}

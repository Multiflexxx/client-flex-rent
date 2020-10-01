// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newOffer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewOffer _$NewOfferFromJson(Map<String, dynamic> json) {
  return NewOffer(
    sessionId: json['session_id'] as String,
    userId: json['user_id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    price: (json['price'] as num)?.toDouble(),
    categoryId: json['category_id'] as int,
  );
}

Map<String, dynamic> _$NewOfferToJson(NewOffer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('session_id', instance.sessionId);
  writeNotNull('user_id', instance.userId);
  writeNotNull('title', instance.title);
  writeNotNull('description', instance.description);
  writeNotNull('price', instance.price);
  writeNotNull('category_id', instance.categoryId);
  return val;
}

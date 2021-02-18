// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRatingResponse _$UserRatingResponseFromJson(Map<String, dynamic> json) {
  return UserRatingResponse(
    userRatings: (json['user_ratings'] as List)
        ?.map((e) =>
            e == null ? null : UserRating.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    currentPage: json['current_page'] as int,
    maxPage: json['max_page'] as int,
    elementsPerPage: json['elements_per_page'] as int,
  );
}

Map<String, dynamic> _$UserRatingResponseToJson(UserRatingResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_ratings', instance.userRatings);
  writeNotNull('current_page', instance.currentPage);
  writeNotNull('max_page', instance.maxPage);
  writeNotNull('elements_per_page', instance.elementsPerPage);
  return val;
}

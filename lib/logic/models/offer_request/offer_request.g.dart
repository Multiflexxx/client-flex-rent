// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferRequest _$OfferRequestFromJson(Map<String, dynamic> json) {
  return OfferRequest(
    requestId: json['request_id'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    offer: json['offer'] == null
        ? null
        : Offer.fromJson(json['offer'] as Map<String, dynamic>),
    statusId: json['status_id'] as int,
    dateRange: json['date_range'] == null
        ? null
        : DateRange.fromJson(json['date_range'] as Map<String, dynamic>),
    message: json['message'] as String,
    qrCodeId: json['qr_code_id'] as String,
    lessorRating: json['lessor_rating'] == null
        ? null
        : UserRating.fromJson(json['lessor_rating'] as Map<String, dynamic>),
    lesseeRating: json['lessee_rating'] == null
        ? null
        : UserRating.fromJson(json['lessee_rating'] as Map<String, dynamic>),
    offerRating: json['offer_rating'] == null
        ? null
        : OfferRating.fromJson(json['offer_rating'] as Map<String, dynamic>),
    newUpdate: json['new_update'] as bool,
  );
}

Map<String, dynamic> _$OfferRequestToJson(OfferRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('request_id', instance.requestId);
  writeNotNull('user', instance.user);
  writeNotNull('offer', instance.offer);
  writeNotNull('status_id', instance.statusId);
  writeNotNull('date_range', instance.dateRange);
  writeNotNull('message', instance.message);
  writeNotNull('qr_code_id', instance.qrCodeId);
  writeNotNull('lessor_rating', instance.lessorRating);
  writeNotNull('lessee_rating', instance.lesseeRating);
  writeNotNull('offer_rating', instance.offerRating);
  writeNotNull('new_update', instance.newUpdate);
  return val;
}

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
    qrCode: json['qr_code'] as String,
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
  writeNotNull('qr_code', instance.qrCode);
  return val;
}

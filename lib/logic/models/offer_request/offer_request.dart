import 'package:json_annotation/json_annotation.dart';
import 'package:flexrent/logic/models/models.dart';
part 'offer_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OfferRequest {
  final String requestId;
  final User user;
  final Offer offer;
  final int statusId;
  final DateRange dateRange;
  final String message;
  final String qrCodeId;
  final UserRating lessorRating;
  final UserRating lesseeRating;
  final OfferRating offerRating;
  final bool newUpdate;

  OfferRequest({
    this.requestId,
    this.user,
    this.offer,
    this.statusId,
    this.dateRange,
    this.message,
    this.qrCodeId,
    this.lessorRating,
    this.lesseeRating,
    this.offerRating,
    this.newUpdate,
  });

  factory OfferRequest.fromJson(Map<String, dynamic> json) =>
      _$OfferRequestFromJson(json);
  Map<String, dynamic> toJson() => _$OfferRequestToJson(this);
}

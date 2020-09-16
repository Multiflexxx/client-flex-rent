import 'package:rent/models/offer_model.dart';

class OfferRequest {
  Offer offer;
  DateTime startDate;
  DateTime endDate;

  OfferRequest({
    this.offer,
    this.startDate,
    this.endDate,
  });
}

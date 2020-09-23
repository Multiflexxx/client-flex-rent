import 'package:rent/logic/models/models.dart';

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

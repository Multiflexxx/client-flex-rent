import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent/models/offer_model.dart';

class DetailPriceOverview extends StatelessWidget {
  final Offer offer;
  final DateTime startDate;
  final DateTime endDate;

  final currenyFormat = new NumberFormat("#,##0.00", "de_DE");

  DetailPriceOverview({Key key, this.offer, this.startDate, this.endDate})
      : super(key: key);

  int _getRentDuration() {
    if (endDate == null || startDate == null) {
      return 1;
    }
    return (endDate.difference(startDate).inDays + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                '${currenyFormat.format(offer.price)} € x ${_getRentDuration()} Tage',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${currenyFormat.format(offer.price * _getRentDuration())} €',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Service-Gebühr',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${currenyFormat.format(offer.price * 0.2)} €',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 14.0,
          thickness: 1.0,
          indent: 15.0,
          endIndent: 15.0,
          color: Colors.purple,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Gesamtbetrag',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${currenyFormat.format((offer.price * _getRentDuration()) + (offer.price * 0.2))} €',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

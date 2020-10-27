import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent/logic/models/date_range/date_range.dart';

class DetailPriceOverview extends StatelessWidget {
  final double price;
  final DateRange dateRange;

  final currenyFormat = new NumberFormat("#,##0.00", "de_DE");

  DetailPriceOverview({Key key, this.price, this.dateRange}) : super(key: key);

  int _getRentDuration() {
    if (dateRange.toDate == null || dateRange.fromDate == null) {
      return 1;
    }
    return (dateRange.toDate.difference(dateRange.fromDate).inDays + 1);
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
                '${currenyFormat.format(price)} € x ${_getRentDuration()} Tage',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${currenyFormat.format(price * _getRentDuration())} €',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
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
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${currenyFormat.format(price * 0.2)} €',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
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
          color: Theme.of(context).accentColor,
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
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                '${currenyFormat.format((price * _getRentDuration()) + (price * 0.2))} €',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
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

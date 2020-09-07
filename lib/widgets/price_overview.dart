import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent/models/offer_model.dart';
import 'package:rent/widgets/slide_bar.dart';

class PriceOverview extends StatelessWidget {
  final Offer offer;
  final ScrollController scrollController;
  final bool reverse;
  final int duration;

  PriceOverview(
      {Key key,
      this.offer,
      this.scrollController,
      this.reverse = false,
      this.duration})
      : super(key: key);

  final currenyFormat = new NumberFormat("#,##0.00", "de_DE");

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xFF202020),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SlideBar(),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${currenyFormat.format(offer.price)} € x $duration Tage',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      '${currenyFormat.format(offer.price * duration)} €',
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
                      '${currenyFormat.format((offer.price * duration) + (offer.price * 0.2))} €',
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
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ));
  }
}

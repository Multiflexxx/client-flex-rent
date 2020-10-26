import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rent/logic/models/offer_request/offer_request.dart';
import 'package:rent/widgets/price/price_tag.dart';

class BookingOverview extends StatelessWidget {
  final OfferRequest offerRequest;
  BookingOverview({this.offerRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFF202020),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Feather.calendar, color: Colors.purple),
                SizedBox(
                  width: 10.0,
                ),
                Text('Übersicht',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mietzeitraum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                    )),
                Text(
                    '${DateFormat('yMd', 'de').format(offerRequest.dateRange.fromDate)} - ${DateFormat('yMd', 'de').format(offerRequest.dateRange.toDate)}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                    ))
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Preis',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1.2,
                    )),
                PriceTag(
                  offerRequest.offer.price,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

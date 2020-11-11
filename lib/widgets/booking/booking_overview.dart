import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:flexrent/logic/models/offer_request/offer_request.dart';
import 'package:flexrent/widgets/price/price_tag.dart';

class BookingOverview extends StatelessWidget {
  final OfferRequest offerRequest;
  BookingOverview({this.offerRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
                Icon(Feather.calendar, color: Theme.of(context).accentColor),
                SizedBox(
                  width: 10.0,
                ),
                Text('Übersicht',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
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
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                    )),
                Text(
                  '${DateFormat('yMd', 'de').format(offerRequest.dateRange.fromDate)} - ${DateFormat('yMd', 'de').format(offerRequest.dateRange.toDate)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    height: 1.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Preis',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
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
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mieter',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    height: 1.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  '${offerRequest.user.firstName} ${offerRequest.user.lastName}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    height: 1.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Vermieter',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    height: 1.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.2,
                  ),
                ),
                Text(
                  '${offerRequest.offer.lessor.firstName} ${offerRequest.offer.lessor.lastName}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    height: 1.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rent/logic/models/offer_request/offer_request.dart';

class BookingAddress extends StatelessWidget {
  final OfferRequest offerRequest;
  BookingAddress({this.offerRequest});

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
                Icon(Feather.map_pin, color: Colors.purple),
                SizedBox(
                  width: 10.0,
                ),
                Text('Adresse',
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
                Text(offerRequest.user.street ?? 'Fehler',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                    )),
                SizedBox(
                  width: 10.0,
                ),
                Text(offerRequest.user.houseNumber ?? 'Fehler',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(offerRequest.user.postCode ?? 'Fehler',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                    )),
                SizedBox(
                  width: 10.0,
                ),
                Text(offerRequest.user.city ?? 'Fehler',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      height: 1.0,
                      fontWeight: FontWeight.w300,
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  onPressed: () {},
                  child: Text('Zur Karte',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        height: 1.0,
                        fontWeight: FontWeight.w300,
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

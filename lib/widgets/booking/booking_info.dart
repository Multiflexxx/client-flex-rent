import 'package:flutter/material.dart';
import 'package:rent/logic/models/models.dart';

class BookingInfo extends StatelessWidget {
  final OfferRequest offerRequest;
  BookingInfo({this.offerRequest});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        color: Color(0xFF202020),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Text(
            offerRequest.statusId == 1
                ? 'Warten auf Bestätigung'
                : offerRequest.statusId == 2
                    ? 'Deine Buchung wurde Bestätigt!'
                    : offerRequest.statusId == 3
                        ? 'Deine Buchung wurde Abgelehnt!'
                        : offerRequest.statusId == 4
                            ? 'Du hast deine Buchung abgeholt!'
                            : offerRequest.statusId == 5
                                ? 'Du hast deine Buchung zurückgegeben!'
                                : offerRequest.statusId == 6
                                    ? 'Deine Buchung wurde ungültig gemacht!'
                                    : ' Du hast deine Buchung erhalten!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              height: 1.15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            offerRequest.statusId == 1
                ? 'Du wirst informiert, wenn deine Buchung bestätigt wurde.'
                 : offerRequest.statusId == 2
                    ? 'Du kannst deine Buchung bald abholen! Lass deinen QR Code von dem Vermieter scannen.'
                    : offerRequest.statusId == 3
                        ? 'Leider wurde deine Buchung abgelehnt. Suche ein neues Item oder versuche es erneut!'
                        : offerRequest.statusId == 4
                            ? 'Viel Spaß mit dem Item! Bringe es rechtzeitig zu dem Vermieter zurück! Scanne den QR Code des Vermieters bei, wenn du das Item zurückbringst'
                            : offerRequest.statusId == 5
                                ? 'Bewerte doch gerne den Vermieter und das Produkt.'
                                : offerRequest.statusId == 6
                                    ? 'Deine Cuchung wurde Bestätigt!'
                                    : ' Du hast deine Buchung erhalten!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              height: 1.15,
              letterSpacing: 1,
              fontWeight: FontWeight.w300,
            ),
          ),
          offerRequest.statusId == 1 ? SizedBox(
            height: 30.0,
          ): Container(),
          offerRequest.statusId == 1 ? Text(
             'Vielen Dank!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              height: 1.15,
              fontWeight: FontWeight.w300,
            ),
          ): Container(),
        ]),
      ),
    );
  }
}

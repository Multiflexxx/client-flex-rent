import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/models.dart';

class BookingInfo extends StatelessWidget {
  final OfferRequest offerRequest;
  BookingInfo({this.offerRequest});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).accentColor),
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: <Widget>[
          Text(
            getInfoTextHeading(true, offerRequest.statusId),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 25.0,
              height: 1.15,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            getInfoTextBody(true, offerRequest.statusId),
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 16.0,
              height: 1.15,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ]),
      ),
    );
  }

  String getInfoTextHeading(bool lessor, int statusId) {
    if (lessor) {
      switch (statusId) {
        case 1:
          {
            return 'Warten auf Bestätigung';
          }
          break;
        case 2:
          {
            return 'Deine Buchung wurde Bestätigt!';
          }
          break;
        case 3:
          {
            return 'Deine Buchung wurde Abgelehnt!';
          }
          break;
        case 4:
          {
            return 'Du hast deine Buchung abgeholt!';
          }
          break;
        case 5:
          {
            return 'Du hast deine Buchung zurückgegeben!';
          }
          break;
        case 6:
          {
            return 'Deine Buchung wurde Abgebrochen gemacht!';
          }
          break;
        case 7:
          {
            return 'Du hast deine Buchung abgebrochen!';
          }
          break;
        default:
          {
            return 'Da lief was schief';
          }
          break;
      }
    } else {
      switch (statusId) {
        case 1:
          {
            return 'Offene Anfrage';
          }
          break;
        case 2:
          {
            return 'Abholung ausstehend';
          }
          break;
        case 3:
          {
            return 'Abgelehnt';
          }
          break;
        case 4:
          {
            return 'Ausgeliehen';
          }
          break;
        case 5:
          {
            return 'Abgeschlossen';
          }
          break;
        case 6:
          {
            return 'Selber Abgebrochen';
          }
          break;
        case 7:
          {
            return 'Abgebrochen von Mieter';
          }
          break;
        default:
          {
            return 'Da lief was schief';
          }
          break;
      }
    }
  }

  String getInfoTextBody(bool lessor, int statusId) {
    if (lessor) {
      switch (statusId) {
        case 1:
          {
            return 'Du wirst informiert, wenn deine Buchung bestätigt wurde.';
          }
          break;
        case 2:
          {
            return 'Du kannst deine Buchung abholen! Lass deinen QR Code von dem Vermieter scannen.';
          }
          break;
        case 3:
          {
            return 'Leider wurde deine Buchung abgelehnt. Suche ein neues Item oder versuche es erneut!';
          }
          break;
        case 4:
          {
            return 'Viel Spaß mit dem Item! Bringe es rechtzeitig zu dem Vermieter zurück! Scanne den QR Code des Vermieters bei, wenn du das Item zurückbringst';
          }
          break;
        case 5:
          {
            return 'Bewerte doch gerne den Vermieter und das Produkt.';
          }
          break;
        case 6:
          {
            return 'Suche dir einen neuen Mietgegenstand!';
          }
          break;
        case 7:
          {
            return 'Suche dir einen neuen Mietgegenstand';
          }
          break;
        default:
          {
            return 'Da lief was schief';
          }
          break;
      }
    } else {
      switch (statusId) {
        case 1:
          {
            return 'Bestätige die offene Anfrage des Mieters, um diesem das Angebot auszuleihen.';
          }
          break;
        case 2:
          {
            return 'Scanne den QR Code des Mieters, wenn er den Mietgegenstand abholt.';
          }
          break;
        case 3:
          {
            return 'Du hast die Buchungsanfrage des Mieters abgelehnt.';
          }
          break;
        case 4:
          {
            return 'Lass deinen QR Code scannen, wenn der Mieter den Mietgegenstand zurückbringt.';
          }
          break;
        case 5:
          {
            return 'Die Vermietung ist Abgeschlossen worden.';
          }
          break;
        case 6:
          {
            return 'Du hast die Vermietung abgebrochen';
          }
          break;
        case 7:
          {
            return 'Der Mieter hat die Vermietung abgebrochen';
          }
          break;
        default:
          {
            return 'Da lief was schief';
          }
          break;
      }
    }
  }
}

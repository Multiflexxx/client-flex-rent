import 'package:flexrent/dictionary/request_status_text.dart';
import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/models.dart';

class BookingInfo extends StatelessWidget {
  final OfferRequest offerRequest;
  final bool lessor;
  BookingInfo({this.offerRequest, this.lessor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            getInfoTextHeading(lessor, offerRequest.statusId),
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
            getInfoTextBody(lessor, offerRequest.statusId),
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
    if (!lessor) {
      try {
        return lesseeStatusText[statusId - 1];
      } catch (e) {
        return lesseeStatusText[lesseeStatusText.length - 1];
      }
    } else {
      try {
        return lessorStatusText[statusId - 1];
      } catch (e) {
        return lessorStatusText[lessorStatusText.length - 1];
      }
    }
  }

  String getInfoTextBody(bool lessor, int statusId) {
    if (!lessor) {
      try {
        return lesseeInfoTextBody[statusId - 1];
      } catch (e) {
        return lesseeInfoTextBody[lesseeInfoTextBody.length - 1];
      }
    } else {
      try {
        return lessorInfoTextBody[statusId - 1];
      } catch (e) {
        return lessorInfoTextBody[lessorInfoTextBody.length - 1];
      }
    }
  }
}

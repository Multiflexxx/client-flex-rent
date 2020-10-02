import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BookingInfo extends StatelessWidget {
  BookingInfo();
  int status = 1;
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
            status == 1
                ? 'Warten auf Bestätigung'
                : status == 2
                    ? 'Deine Cuchung wurde Bestätigt!'
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
            status == 1
            ? 'Du wirst informiert, wenn deine Buchung bestätigt wurde.'
            : null,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              height: 1.15,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            status == 1
            ? 'Vielen Dank!'
            : null,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              height: 1.15,
              fontWeight: FontWeight.w300,
            ),
          )
        ]),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';

class InfoBookingScreen extends StatefulWidget {
  InfoBookingScreen();

  @override
  _InfoBookingScreenState createState() => _InfoBookingScreenState();
}

class _InfoBookingScreenState extends State<InfoBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(10.0),
                decoration: new BoxDecoration(
                  color: Color(0xFF202020),
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Deine Buchung wurde erfolgreich stoniert!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300,
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}

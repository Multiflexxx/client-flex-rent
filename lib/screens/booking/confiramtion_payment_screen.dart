import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:rent/models/offer_request_model.dart';

class ConfirmationPaymentScreen extends StatefulWidget {
  final OfferRequest offerRequest;

  ConfirmationPaymentScreen({this.offerRequest});

  @override
  _ConfirmationPaymentScreenState createState() =>
      _ConfirmationPaymentScreenState();
}

class _ConfirmationPaymentScreenState extends State<ConfirmationPaymentScreen> {
  @override
  void initState() {
    inspect(widget.offerRequest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 12.0),
              padding: EdgeInsets.only(top: 8, bottom: 8),
              decoration: new BoxDecoration(
                color: Color(0xFF202020),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Feather.calendar,
                                color: Colors.purple,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Verfügbarkeit',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  height: 1.35,
                                  fontWeight: FontWeight.w300,
                                ),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${DateFormat('yMd', 'de').format(widget.offerRequest.startDate)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      height: 1.15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  widget.offerRequest.startDate !=
                                          widget.offerRequest.endDate
                                      ? Text(
                                          ' bis ${DateFormat('yMd', 'de').format(widget.offerRequest.endDate)}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            height: 1.15,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

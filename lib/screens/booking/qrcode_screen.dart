import 'dart:async';
import 'dart:ui';

import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/offer_service.dart';

class QrCodeScreen extends StatefulWidget {
  final OfferRequest offerRequest;

  QrCodeScreen({@required this.offerRequest});

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => _checkQrCode());
  }

  _checkQrCode() async {
    OfferRequest offerRequest = await ApiOfferService()
        .getOfferRequestbyRequest(offerRequest: widget.offerRequest);
    if (offerRequest.qrCodeId == '') {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dein QR Code',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(80.0),
                decoration: new BoxDecoration(
                  color: Theme.of(context).cardColor,
                  border: Border.all(color: Theme.of(context).accentColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: QrImage(
                    data: widget.offerRequest.qrCodeId,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: PurpleButton(
                  text: Text('Abbrechen'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

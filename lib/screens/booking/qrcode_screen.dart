import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';

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
        title: Text('Dein QR Code'),
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
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  decoration: new BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: QrImage(
                    data: widget.offerRequest.qrCodeId,
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    height: 50.0,
                    decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                      child: Text(
                        'Abbrechen',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

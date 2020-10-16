import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';
import 'package:rent/screens/booking/qrcode_screen.dart';

import 'package:rent/widgets/booking/booking_info.dart';
import 'package:rent/widgets/booking/booking_overview.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class LeseeBookingScreen extends StatefulWidget {
  final OfferRequest offerRequest;
  LeseeBookingScreen({this.offerRequest});
  @override
  _LeseeBookingScreenState createState() => _LeseeBookingScreenState();
}

class _LeseeBookingScreenState extends State<LeseeBookingScreen> {
  Future<OfferRequest> offerReqeust;
  String barcodeResult = '';

  @override
  void initState() {
    offerReqeust = ApiOfferService()
        .getOfferRequestbyRequest(offerRequest: widget.offerRequest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.offerRequest.offer.title}')),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            BookingInfo(
              offerRequest: widget.offerRequest,
            ),
            BookingOverview(
              offerRequest: widget.offerRequest,
            ),
            widget.offerRequest.statusId == 4
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GestureDetector(
                      onTap: () async {
                        barcodeResult = await FlutterBarcodeScanner.scanBarcode(
                            '#9C27B0', 'Abbrechen', false, ScanMode.QR);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            'QR Code scannen',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : widget.offerRequest.statusId == 1
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () => pushNewScreen(
                            context,
                            screen: QrCodeScreen(),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Center(
                              child: Text(
                                'Stonieren',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(),
          ],
        ),
      ),
    );
  }
}

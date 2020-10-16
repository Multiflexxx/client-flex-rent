import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rent/logic/exceptions/exceptions.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/widgets/booking/booking_overview.dart';

class LessorResponseScreen extends StatefulWidget {
  final OfferRequest offerRequest;

  LessorResponseScreen({this.offerRequest});

  @override
  _LessorResponseScreenState createState() => _LessorResponseScreenState();
}

class _LessorResponseScreenState extends State<LessorResponseScreen> {
  Future<OfferRequest> apiOfferReqeust;
  String barcodeResult = '';

  @override
  void initState() {
    apiOfferReqeust = ApiOfferService()
        .getOfferRequestbyRequest(offerRequest: widget.offerRequest);
    super.initState();
  }

  void _acceptOffer({OfferRequest updateOfferRequest}) {
    OfferRequest updatedOfferRequest = OfferRequest(
      requestId: updateOfferRequest.requestId,
      offer: updateOfferRequest.offer,
      user: updateOfferRequest.user,
      statusId: 2,
      dateRange: updateOfferRequest.dateRange,
      message: updateOfferRequest.message,
      qrCode: updateOfferRequest.qrCode,
    );
    setState(() {
      apiOfferReqeust = ApiOfferService()
          .updateOfferReqeust(offerRequest: updatedOfferRequest);
    });
  }

  void _rejectOffer({OfferRequest updateOfferRequest}) {
    OfferRequest updatedOfferRequest = OfferRequest(
      requestId: updateOfferRequest.requestId,
      offer: updateOfferRequest.offer,
      user: updateOfferRequest.user,
      statusId: 3,
      dateRange: updateOfferRequest.dateRange,
      message: updateOfferRequest.message,
      qrCode: updateOfferRequest.qrCode,
    );
    setState(() {
      apiOfferReqeust = ApiOfferService()
          .updateOfferReqeust(offerRequest: updatedOfferRequest);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.offerRequest.offer.title}')),
      body: SafeArea(
        child: FutureBuilder<OfferRequest>(
          future: apiOfferReqeust,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              OfferRequest _offerRequest = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // TODO: Overview for lessor not lessee: Profile of lessor
                  // BookingInfo(
                  //   offerRequest: widget.offerRequest,
                  // ),
                  BookingOverview(
                    offerRequest: _offerRequest,
                  ),
                  _offerRequest.statusId == 4
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: () async {
                              barcodeResult =
                                  await FlutterBarcodeScanner.scanBarcode(
                                      '#9C27B0',
                                      'Abbrechen',
                                      false,
                                      ScanMode.QR);
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
                      : _offerRequest.statusId == 1
                          ? Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    color: Theme.of(context).primaryColor,
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.all(16),
                                    shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(8.0)),
                                    child: Text('Annhemen'),
                                    onPressed: () {
                                      _acceptOffer(
                                          updateOfferRequest: snapshot.data);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: RaisedButton(
                                    color: Colors.transparent,
                                    textColor: Colors.white,
                                    padding: const EdgeInsets.all(16),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(8.0),
                                      side: BorderSide(
                                          color: Colors.purple, width: 1.75),
                                    ),
                                    child: Text('Ablehnen'),
                                    onPressed: () {
                                      _rejectOffer(
                                          updateOfferRequest: snapshot.data);
                                    },
                                  ),
                                ),
                              ],
                            )
                          : _offerRequest.statusId == 2
                              ? Text('Warte auf die Abholung')
                              : _offerRequest.statusId == 3
                                  ? Text('Storniert')
                                  : Container(),
                ],
              );
            } else if (snapshot.hasError) {
              OfferException exception = snapshot.error;
              Text(exception.message);
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

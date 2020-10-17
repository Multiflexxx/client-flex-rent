import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/exceptions/exceptions.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/screens/booking/qrcode_screen.dart';
import 'package:rent/widgets/booking/booking_overview.dart';
import 'package:rent/widgets/flushbar_styled.dart';

class LessorResponseScreen extends StatefulWidget {
  final OfferRequest offerRequest;

  LessorResponseScreen({this.offerRequest});

  @override
  _LessorResponseScreenState createState() => _LessorResponseScreenState();
}

class _LessorResponseScreenState extends State<LessorResponseScreen> {
  Future<OfferRequest> offerRequest;

  @override
  void initState() {
    offerRequest = ApiOfferService()
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
      qrCodeId: updateOfferRequest.qrCodeId,
    );
    setState(() {
      offerRequest = ApiOfferService()
          .updateOfferRequest(offerRequest: updatedOfferRequest);
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
      qrCodeId: updateOfferRequest.qrCodeId,
    );
    setState(() {
      offerRequest = ApiOfferService()
          .updateOfferRequest(offerRequest: updatedOfferRequest);
    });
  }

  void _scanQrCode({OfferRequest updateOfferRequest}) async {
    final String barcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#9C27B0', 'Abbrechen', false, ScanMode.QR);

    if (barcodeResult != '-1') {
      OfferRequest updatedOfferRequest = OfferRequest(
        requestId: updateOfferRequest.requestId,
        offer: updateOfferRequest.offer,
        user: updateOfferRequest.user,
        statusId: 4,
        dateRange: updateOfferRequest.dateRange,
        message: updateOfferRequest.message,
        qrCodeId: barcodeResult,
      );

      setState(() {
        offerRequest = ApiOfferService()
            .updateOfferRequest(offerRequest: updatedOfferRequest);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.offerRequest.offer.title}')),
      body: SafeArea(
        child: FutureBuilder<OfferRequest>(
          future: offerRequest,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              OfferRequest _offerRequest = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // TODO: Overview for lessor not lessee: Profile of lessor
                  // BookingInfo(
                  //   offerRequest: widget.offerRequest,
                  // ),
                  BookingOverview(
                    offerRequest: _offerRequest,
                  ),
                  _offerRequest.statusId == 1
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
                                      updateOfferRequest: _offerRequest);
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
                                  borderRadius: new BorderRadius.circular(8.0),
                                  side: BorderSide(
                                      color: Colors.purple, width: 1.75),
                                ),
                                child: Text('Ablehnen'),
                                onPressed: () {
                                  _rejectOffer(
                                      updateOfferRequest: _offerRequest);
                                },
                              ),
                            ),
                          ],
                        )
                      : _offerRequest.statusId == 2
                          ? Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: GestureDetector(
                                onTap: () => _scanQrCode(
                                    updateOfferRequest: _offerRequest),
                                child: Container(
                                  padding: const EdgeInsets.all(10.0),
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
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
                          : _offerRequest.statusId == 3
                              ? Text('Abgelehnt')
                              : _offerRequest.statusId == 4
                                  ? Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: GestureDetector(
                                        onTap: () => _offerRequest.qrCodeId !=
                                                ''
                                            ? pushNewScreen(
                                                context,
                                                screen: QrCodeScreen(
                                                  offerRequest: _offerRequest,
                                                ),
                                              )
                                            : showFlushbar(
                                                context: context,
                                                message:
                                                    'QR Code nicht verfügbar!'),
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                              color: Colors.purple,
                                              borderRadius:
                                                  BorderRadius.circular(10.0)),
                                          child: Center(
                                            child: Text(
                                              'QR Code anzeigen',
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
                                  : _offerRequest.statusId == 5
                                      ? Text(
                                          'Wir hoffen es hat alles geklappt!')
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

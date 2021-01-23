import 'dart:async';

import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/screens/booking/qrcode_screen.dart';
import 'package:flexrent/widgets/booking/booking_address.dart';

import 'package:flexrent/widgets/booking/booking_info.dart';
import 'package:flexrent/widgets/booking/booking_overview.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flexrent/widgets/styles/flushbar_styled.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';

class LeseeBookingScreen extends StatelessWidget {
  final OfferRequest offerRequest;

  LeseeBookingScreen({this.offerRequest});

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: offerRequest.offer.title,
      bodyWidget: LeseeBookingBody(
        offerRequest: offerRequest,
      ),
    );
  }
}

class LeseeBookingBody extends StatefulWidget {
  final OfferRequest offerRequest;
  LeseeBookingBody({this.offerRequest});
  @override
  _LeseeBookingBodyState createState() => _LeseeBookingBodyState();
}

class _LeseeBookingBodyState extends State<LeseeBookingBody> {
  Future<OfferRequest> offerRequest;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _getOfferRequestUpdate();
    timer = Timer.periodic(
        Duration(seconds: 3), (Timer t) => _getOfferRequestUpdate());
  }

  void _getOfferRequestUpdate() {
    setState(() {
      offerRequest = ApiOfferService()
          .getOfferRequestbyRequest(offerRequest: widget.offerRequest);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _scanQrCode({OfferRequest updateOfferRequest}) async {
    final String barcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#9C27B0', 'Abbrechen', false, ScanMode.QR);

    if (barcodeResult != '-1') {
      OfferRequest updatedOfferRequest = OfferRequest(
        requestId: updateOfferRequest.requestId,
        offer: updateOfferRequest.offer,
        user: updateOfferRequest.user,
        statusId: 5,
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
    return FutureBuilder(
      future: offerRequest,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          OfferRequest _offerRequest = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BookingInfo(
                offerRequest: _offerRequest,
                lessor: false,
              ),
              BookingOverview(
                offerRequest: _offerRequest,
              ),
              _offerRequest.statusId == 2
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: PurpleButton(
                        onPressed: () => _offerRequest.qrCodeId != ''
                            ? pushNewScreen(
                                context,
                                screen: QrCodeScreen(
                                  offerRequest: _offerRequest,
                                ),
                              )
                            : showFlushbar(
                                context: context,
                                message: 'QR Code nicht verfügbar!'),
                        text: Text('QR Code anzeigen'),
                      ),
                    )
                  : _offerRequest.statusId == 4
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: PurpleButton(
                            text: Text('QR Code scannen'),
                            onPressed: () =>
                                _scanQrCode(updateOfferRequest: _offerRequest),
                          ),
                        )
                      : Container(),
              _offerRequest.statusId == 2 || _offerRequest.statusId == 4
                  ? BookingAddress(offerRequest: _offerRequest)
                  : Container(),
              SizedBox(
                height: 75.0,
              ),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

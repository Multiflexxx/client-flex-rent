import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';
import 'package:rent/screens/booking/qrcode_screen.dart';
import 'package:rent/widgets/booking/booking_address.dart';

import 'package:rent/widgets/booking/booking_info.dart';
import 'package:rent/widgets/booking/booking_overview.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:rent/widgets/flushbar_styled.dart';
import 'package:rent/widgets/layout/standard_sliver_appbar_list.dart';

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

  @override
  void initState() {
    offerRequest = ApiOfferService()
        .getOfferRequestbyRequest(offerRequest: widget.offerRequest);
    super.initState();
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
              ),
              BookingOverview(
                offerRequest: _offerRequest,
              ),
              _offerRequest.statusId == 2
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () => _offerRequest.qrCodeId != ''
                            ? pushNewScreen(
                                context,
                                screen: QrCodeScreen(
                                  offerRequest: _offerRequest,
                                ),
                              )
                            : showFlushbar(
                                context: context,
                                message: 'QR Code nicht verfügbar!'),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10.0)),
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
                  : _offerRequest.statusId == 4
                      ? Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: () =>
                                _scanQrCode(updateOfferRequest: _offerRequest),
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

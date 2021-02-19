import 'dart:async';

import 'package:flexrent/screens/rating/rating_screen.dart';
import 'package:flexrent/widgets/booking/booking_info.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_transparent_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/screens/booking/qrcode_screen.dart';
import 'package:flexrent/widgets/booking/booking_overview.dart';
import 'package:flexrent/widgets/styles/flushbar_styled.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';

class LessorResponseScreen extends StatelessWidget {
  final OfferRequest offerRequest;

  LessorResponseScreen({this.offerRequest});

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: offerRequest.offer.title,
      bodyWidget: LessorResponseBody(
        offerRequest: offerRequest,
      ),
    );
  }
}

class LessorResponseBody extends StatefulWidget {
  final OfferRequest offerRequest;

  LessorResponseBody({this.offerRequest});

  @override
  _LessorResponseBodyState createState() => _LessorResponseBodyState();
}

class _LessorResponseBodyState extends State<LessorResponseBody> {
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
    return FutureBuilder<OfferRequest>(
      future: offerRequest,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          OfferRequest _offerRequest = snapshot.data;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BookingInfo(
                lessor: true,
                offerRequest: _offerRequest,
              ),
              BookingOverview(
                offerRequest: _offerRequest,
              ),
              _offerRequest.statusId == 1
                  ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: PurpleButton(
                            text: Text('Annehmen'),
                            onPressed: () {
                              _acceptOffer(updateOfferRequest: _offerRequest);
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: TransparentButton(
                            text: Text('Ablehnen'),
                            onPressed: () {
                              _rejectOffer(updateOfferRequest: _offerRequest);
                            },
                          ),
                        ),
                      ],
                    )
                  : _offerRequest.statusId == 2
                      ? Container(
                          margin: EdgeInsets.all(10.0),
                          child: PurpleButton(
                            text: Text(
                              'QR Code scannen',
                            ),
                            onPressed: () =>
                                _scanQrCode(updateOfferRequest: _offerRequest),
                          ),
                        )
                      : _offerRequest.statusId == 4
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
                          : _offerRequest.statusId == 5
                              ? Container(
                                  margin: EdgeInsets.all(10.0),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(children: <Widget>[
                                      Text(
                                        'Wir hoffen es hat alles geklappt!',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontSize: 18.0,
                                          height: 1.15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      PurpleButton(
                                        text: Text('Bewerte den Vermieter'),
                                        onPressed: () {
                                          pushNewScreenWithRouteSettings(
                                            context,
                                            screen: RatingScreen(
                                              ratedUser:
                                                  _offerRequest.offer.lessor,
                                              ratingType: 'lessor',
                                            ),
                                            withNavBar: true,
                                            settings: RouteSettings(
                                                name: RatingScreen.routeName),
                                          );
                                        },
                                      ),
                                       SizedBox(height: 10.0,),
                                      PurpleButton(
                                        text: Text('Bewerte das Produkt'),
                                        onPressed: () {
                                          pushNewScreenWithRouteSettings(
                                            context,
                                            screen: RatingScreen(
                                              offer:
                                                  _offerRequest.offer,
                                              ratingType: 'offer',
                                            ),
                                            withNavBar: true,
                                            settings: RouteSettings(
                                                name: RatingScreen.routeName),
                                          );
                                        },
                                      ),
                                    ]),
                                  ),
                                )
                              : Container(),
            ],
          );
        } else if (snapshot.hasError) {
          OfferException exception = snapshot.error;
          return Text(exception.message);
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

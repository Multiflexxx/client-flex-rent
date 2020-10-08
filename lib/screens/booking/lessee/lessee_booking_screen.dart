import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/screens/booking/qrcode_screen.dart';

import 'package:rent/widgets/booking/booking_info.dart';
import 'package:rent/widgets/booking/booking_overview.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class LeseeBookingScreen extends StatefulWidget {
  const LeseeBookingScreen();
  // int status = 1;

  @override
  _LeseeBookingScreenState createState() => _LeseeBookingScreenState();
}

class _LeseeBookingScreenState extends State<LeseeBookingScreen> {
  int status = 1;
  String barcodeResult = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Deine Buchung')),
      body: SafeArea(
        child: ListView(children: <Widget>[
          BookingInfo(),
          BookingOverview(),
          status == 1
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
              : Padding(
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
                          'Zeige deinen QR Code',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ]),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  QrCodeScreen();

  @override
  _QrCodeScreenState createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dein QR Code'),),
        body: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(80.0),
              decoration: new BoxDecoration(
                color: Color(0xFF202020),
                border: Border.all(color: Colors.purple),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                 decoration: new BoxDecoration(
                color: Colors.white,
               
                borderRadius: BorderRadius.circular(10.0),
              ),
                child: QrImage(
                  data: "ab",
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            Padding(
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
                          'Abbrechen',
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
          ],

        ),
        
      ),
    ));
  }
}

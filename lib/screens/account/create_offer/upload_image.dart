import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';

class UploadImageScreen extends StatelessWidget {
  final String imagePath;
  final Offer offer;

  const UploadImageScreen({Key key, this.imagePath, this.offer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _imagePathList = List<String>();
    _imagePathList.add(imagePath);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Feather.arrow_left),
          iconSize: 30.0,
          color: Theme.of(context).primaryColor,
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
              icon: Icon(Feather.x),
              iconSize: 30.0,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('takePhoto'));
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
              decoration: BoxDecoration(
                color: Color(0xFF202020),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RichText(
                  text: TextSpan(
                    text: 'Dein Mietgegenstand ',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                      height: 1.35,
                      fontWeight: FontWeight.w300,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: offer.title,
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 18.0,
                          height: 1.35,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.2,
                        ),
                      ),
                      TextSpan(
                        text: ' ist jetzt aufgepeppt.',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          height: 1.35,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              height: 180.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _imagePathList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == _imagePathList.length) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            color: Color(0xFF202020),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            Feather.plus_circle,
                            color: Colors.purple,
                            size: 40.0,
                          ),
                        ),
                      ),
                    );
                  }
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.file(File(imagePath),
                          height: 180, width: 180, fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Theme.of(context).accentColor,
                  textColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(16),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  onPressed: () {
                    ApiOfferService()
                        .addImage(offer: offer, imagePath: imagePath);
                    Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName));
                  },
                  child: _imagePathList.length == 1
                      ? Text(
                          'Bild hochladen',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.2,
                          ),
                        )
                      : Text(
                          'Bilder hochladen',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.2,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

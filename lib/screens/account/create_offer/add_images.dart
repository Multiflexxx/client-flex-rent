import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/screens/account/create_offer/take_photo.dart';
import 'package:rent/widgets/offer/offer_card.dart';

class AddImages extends StatefulWidget {
  final Future<Offer> offer;

  AddImages({this.offer}) : super();

  @override
  _AddImagesState createState() => _AddImagesState();
}

class _AddImagesState extends State<AddImages> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.popUntil(
            context, ModalRoute.withName(Navigator.defaultRouteName));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Feather.arrow_left),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
        ),
        body: SafeArea(
            child: FutureBuilder(
          future: widget.offer,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Offer offer = snapshot.data;
              return ListView(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF202020),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Erfolgreich angelegt!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 21.0,
                              height: 1.35,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            'Andere User sehen dein Mietgegenstand wie folgt:',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18.0,
                              height: 1.35,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  OfferCard(offer: offer, heroTag: 'images'),
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF202020),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              text: 'Peppe jetzt deinen Mietgegenstand ',
                              style: TextStyle(
                                color: Colors.white,
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
                                  text:
                                      ' mit Bildern auf, um noch mehr Anfragen zu erhalten!',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    height: 1.35,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(16),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(10.0)),
                              onPressed: () async {
                                final cameras = await availableCameras();
                                final CameraDescription firstCamera =
                                    cameras.first;
                                pushNewScreenWithRouteSettings(context,
                                    settings: RouteSettings(name: 'takePhoto'),
                                    screen: TakePhoto(
                                        offer: offer, camera: firstCamera),
                                    withNavBar: false);
                              },
                              child: Text(
                                'Bild hinzufügen.',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            return Text('Kein Offer');
          },
        )),
      ),
    );
  }
}

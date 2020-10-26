import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent/logic/models/offer_request/offer_request.dart';

class BookingAddress extends StatefulWidget {
  final OfferRequest offerRequest;
  BookingAddress({this.offerRequest});

  @override
  _BookingAddressState createState() => _BookingAddressState();
}

class _BookingAddressState extends State<BookingAddress> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _cameraPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  void getCurrentPosition() async {
    List<Location> locations =
        await locationFromAddress("68165", localeIdentifier: 'de_DE');

    LatLng _latlng = LatLng(locations[0].latitude, locations[0].longitude);

    setState(
      () {
        _cameraPosition = CameraPosition(
          target: _latlng,
          zoom: 17.0,
        );
        _markers.add(
          Marker(
            draggable: false,
            markerId: MarkerId(
              UniqueKey().toString(),
            ),
            position: _latlng,
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Color(0xFF202020),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Feather.map_pin, color: Colors.purple),
                SizedBox(
                  width: 10.0,
                ),
                Text('Adresse',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Icon(
                        Feather.map,
                        size: 24.0,
                        color: Colors.white,
                      ),
                      Text(
                        'Zur Karte',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          height: 1.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Schwetzingerstraße 140',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                height: 1.0,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${widget.offerRequest.offer.lessor.postCode} ${widget.offerRequest.offer.lessor.city}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                height: 1.0,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1.2),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GoogleMap(
                  zoomGesturesEnabled: false,
                  compassEnabled: false,
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: false,
                  tiltGesturesEnabled: false,
                  zoomControlsEnabled: false,
                  mapToolbarEnabled: false,
                  mapType: MapType.normal,
                  initialCameraPosition: _cameraPosition,
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' as MapLauncher;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flexrent/logic/models/offer_request/offer_request.dart';
import 'package:flexrent/widgets/slide_bar.dart';

class BookingAddress extends StatefulWidget {
  final OfferRequest offerRequest;
  BookingAddress({this.offerRequest});

  @override
  _BookingAddressState createState() => _BookingAddressState();
}

class _BookingAddressState extends State<BookingAddress> {
  Completer<GoogleMapController> _controller = Completer();
  static LatLng _initialPosition;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    getCurrentPosition();
  }

  void getCurrentPosition() async {
    String address =
        '${widget.offerRequest.offer.lessor.street} ${widget.offerRequest.offer.lessor.houseNumber}, ${widget.offerRequest.offer.lessor.postCode}';

    List<Location> locations =
        await locationFromAddress(address, localeIdentifier: 'de_DE');
    LatLng _latlng = LatLng(locations[0].latitude, locations[0].longitude);
    setState(
      () {
        _initialPosition = _latlng;
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

  openMapsSheet({BuildContext context}) async {
    try {
      final coords = MapLauncher.Coords(
          _markers.first.position.latitude, _markers.first.position.longitude);
      final availableMaps = await MapLauncher.MapLauncher.installedMaps;

      showCupertinoModalBottomSheet(
        expand: false,
        useRootNavigator: true,
        context: context,
        barrierColor: Colors.black45,
        builder: (context, scrollController) => Container(
          child: Wrap(
            children: <Widget>[
              for (var map in availableMaps)
                Material(
                  color: Theme.of(context).cardColor,
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SlideBar(),
                        ListTile(
                          onTap: () => map.showDirections(
                            destination: coords,
                          ),
                          title: Text(
                            map.mapName,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              letterSpacing: 1.2,
                            ),
                          ),
                          leading: Image(
                            image: map.icon,
                            height: 30.0,
                            width: 30.0,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
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
                Icon(Feather.map_pin, color: Theme.of(context).accentColor),
                SizedBox(
                  width: 10.0,
                ),
                Text('Adresse',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
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
                  child: GestureDetector(
                    onTap: () => openMapsSheet(context: context),
                    child: Column(
                      children: [
                        Icon(
                          Feather.map,
                          size: 24.0,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          'Zur Karte',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 18.0,
                            height: 1.0,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
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
                            '${widget.offerRequest.offer.lessor.street} ${widget.offerRequest.offer.lessor.houseNumber}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
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
                                color: Theme.of(context).primaryColor,
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
            SizedBox(
              height: 10.0,
            ),
            _initialPosition == null
                ? Center(
                    child: Text(
                      'loading map..',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    height: 0.25 * MediaQuery.of(context).size.height,
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
                        initialCameraPosition: CameraPosition(
                          target: _initialPosition,
                          zoom: 17.0,
                        ),
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

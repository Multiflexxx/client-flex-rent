import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:map_launcher/map_launcher.dart' as MapLauncher;
import 'package:rent/widgets/slide_bar.dart';

class AppSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Einstellungen',
      bodyWidget: _AppSettingsBody(),
    );
  }
}

class _AppSettingsBody extends StatefulWidget {
  @override
  _AppSettingsBodyState createState() => _AppSettingsBodyState();
}

class _AppSettingsBodyState extends State<_AppSettingsBody> {
  bool darkmode = true;
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

    setState(() {
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
    });
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
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: new BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Darkmode',
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 18.0),
              ),
              Switch(
                activeColor: Theme.of(context).accentColor,
                onChanged: (bool) {
                  setState(() {
                    darkmode = bool;
                  });
                },
                value: darkmode,
              )
            ],
          ),
          MaterialButton(
            onPressed: () => openMapsSheet(context: context),
            child: Text('Show Maps'),
          ),
          Container(
            width: double.infinity,
            height: 500,
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
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rent/widgets/layout/standard_sliver_appbar_list.dart';

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
  final _testPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      decoration: new BoxDecoration(
        color: Color(0xFF202020),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Darkmode',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              Switch(
                activeColor: Colors.purple,
                onChanged: (bool) {
                  setState(() {
                    darkmode = bool;
                  });
                },
                value: darkmode,
              )
            ],
          ),
          // Flexible(
          //   child: GoogleMap(
          //       mapType: MapType.hybrid, initialCameraPosition: _testPosition),
          // ),
        ],
      ),
    );
  }
}

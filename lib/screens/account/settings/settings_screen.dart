import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';

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
        ],
      ),
    );
  }
}

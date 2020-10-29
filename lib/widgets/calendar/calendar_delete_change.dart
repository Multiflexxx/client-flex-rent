import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flexrent/widgets/slide_bar.dart';

class CalendarDeleteChange extends StatelessWidget {
  final ScrollController scrollController;

  CalendarDeleteChange({this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SlideBar(),
            ListTile(
              title: Text(
                'Ändern',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.2,
                ),
              ),
              leading: Icon(
                Feather.edit,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () => Navigator.pop(context, 'change'),
            ),
            ListTile(
              title: Text(
                'Löschen',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  letterSpacing: 1.2,
                ),
              ),
              leading: Icon(
                Feather.trash,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () => Navigator.pop(context, 'delete'),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}

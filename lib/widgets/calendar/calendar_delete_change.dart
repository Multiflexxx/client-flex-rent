import 'package:flexrent/widgets/slideIns/slideIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CalendarDeleteChange extends StatelessWidget {
  final ScrollController scrollController;

  CalendarDeleteChange({this.scrollController});

  @override
  Widget build(BuildContext context) {
    return SlideIn(widgetList: [
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
    ]);
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart' as _picker;

class DateRangeButtonBar extends StatelessWidget {
  final DateTime date;
  final _picker.PickerDateRange range;

  const DateRangeButtonBar({this.date, this.range});

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        FlatButton(
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () => Navigator.pop(context, null),
        ),
        FlatButton(
          child: Text(
            'OK',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: () {
            if (range != null) {
              Navigator.pop(context, range);
            } else {
              Navigator.pop(context, date);
            }
          },
        ),
      ],
    );
  }
}

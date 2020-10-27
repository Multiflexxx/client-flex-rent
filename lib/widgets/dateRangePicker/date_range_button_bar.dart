import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart' as _picker;

class DateRangeButtonBar extends StatelessWidget {
  final BuildContext pickerContext;
  final DateTime date;
  final _picker.PickerDateRange range;
  final List<DateTime> blackoutDates;

  const DateRangeButtonBar(
      {this.pickerContext, this.date, this.range, this.blackoutDates});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: ButtonBar(
        children: <Widget>[
          FlatButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.2,
              ),
            ),
            onPressed: () => Navigator.pop(context, null),
          ),
          FlatButton(
            child: Text(
              'OK',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.2,
              ),
            ),
            onPressed: () {
              if (range != null) {
                if (range.startDate == null) {
                  Navigator.pop(context, null);
                } else if (range.endDate != null) {
                  if (blackoutDates != null) {
                    bool correctRange = true;
                    for (var blackoutDate in blackoutDates) {
                      if ((blackoutDate.isAfter(range.startDate) &&
                              blackoutDate.isBefore(range.endDate)) ||
                          (blackoutDate.isAfter(range.endDate) &&
                              blackoutDate.isBefore(range.startDate))) {
                        correctRange = false;
                        Flushbar(
                          messageText: Text(
                            "Dein Zeitraum muss zusammenhängend sein.",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18.0,
                              letterSpacing: 1.2,
                            ),
                          ),
                          icon: Icon(
                            Icons.info_outline,
                            size: 28.0,
                            color: Theme.of(context).accentColor,
                          ),
                          duration: Duration(seconds: 3),
                          margin: EdgeInsets.all(10.0),
                          padding: EdgeInsets.all(16.0),
                          // flushbarPosition: FlushbarPosition.TOP,
                          borderRadius: 8,
                        )..show(context);
                        break;
                      }
                    }
                    if (correctRange) {
                      // blackout dates, but range is correct
                      Navigator.pop(context, range);
                    }
                  } else {
                    // no blackout dates
                    Navigator.pop(context, range);
                  }
                } else {
                  // only one day range
                  Navigator.pop(context, range);
                }
              } else {
                // no range
                Navigator.pop(context, null);
              }
            },
          ),
        ],
      ),
    );
  }
}

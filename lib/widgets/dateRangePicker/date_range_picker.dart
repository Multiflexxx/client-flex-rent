import 'package:flexrent/widgets/slideIns/slideIn.dart';
import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart' as _picker;

import 'date_range_button_bar.dart';

class DateRangePicker extends StatefulWidget {
  final ScrollController scrollController;
  final DateTime date;
  final _picker.PickerDateRange range;
  final DateTime minDate;
  final DateTime maxDate;
  final DateTime displayDate;
  final List<DateRange> blockedDates;

  DateRangePicker({
    this.scrollController,
    this.date,
    this.range,
    this.minDate,
    this.maxDate,
    this.displayDate,
    this.blockedDates,
  });

  @override
  _DataRangePickerState createState() => _DataRangePickerState();
}

class _DataRangePickerState extends State<DateRangePicker> {
  DateTime date;
  _picker.DateRangePickerController _controller;
  _picker.PickerDateRange range;

  @override
  void initState() {
    date = widget.date;
    range = widget.range;
    _controller = _picker.DateRangePickerController();
    super.initState();
  }

  List<DateTime> _getDaysInBeteween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  List<DateTime> _getBlackOutDates() {
    List<DateTime> _blackOutDates = [];
    if (widget.blockedDates != null) {
      widget.blockedDates.forEach((e) =>
          _blackOutDates.addAll(_getDaysInBeteween(e.fromDate, e.toDate)));
    }
    return _blackOutDates;
  }

  @override
  Widget build(BuildContext context) {
    _controller.selectedDate = date;
    _controller.selectedRange = range;
    return SlideIn(
      top: false,
      widgetList: [
        Flexible(
          child: SfDateRangePicker(
            controller: _controller,
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.range,
            showNavigationArrow: false,
            initialDisplayDate: widget.date,
            minDate: widget.minDate,
            maxDate: widget.maxDate,
            enablePastDates: false,

            navigationDirection: DateRangePickerNavigationDirection.vertical,

            headerStyle: DateRangePickerHeaderStyle(
              textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                letterSpacing: 1.2,
              ),
            ),
            headerHeight: 100,

            monthViewSettings: DateRangePickerMonthViewSettings(
              enableSwipeSelection: false,
              firstDayOfWeek: 1,
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              dayFormat: 'EE',
              weekendDays: List<int>()..add(7),
              blackoutDates: _getBlackOutDates(),
            ),

            // Style
            backgroundColor: Theme.of(context).cardColor,
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: TextStyle(color: Theme.of(context).primaryColor),
              todayTextStyle: TextStyle(color: Theme.of(context).primaryColor),
              todayCellDecoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(
                  color: Colors.red,
                  width: 1.0,
                ),
                shape: BoxShape.circle,
              ),
              weekendTextStyle: TextStyle(color: Colors.red),
              disabledDatesTextStyle: TextStyle(color: Colors.grey),
              blackoutDateTextStyle: TextStyle(
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                decorationThickness: 2.0,
              ),
            ),

            selectionTextStyle: TextStyle(color: Colors.white),
            selectionColor: Colors.blue,
            startRangeSelectionColor: Theme.of(context).accentColor,
            endRangeSelectionColor: Theme.of(context).accentColor,
            rangeSelectionColor: Colors.purpleAccent,
            rangeTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),

            onSelectionChanged:
                (_picker.DateRangePickerSelectionChangedArgs details) {
              setState(() {
                if (range == null) {
                  date = details.value;
                } else {
                  range = details.value;
                }
              });
            },
          ),
        ),
        DateRangeButtonBar(
          pickerContext: context,
          date: date,
          range: range,
          blackoutDates: List<DateTime>()
            ..add(
              DateTime(2020, 09, 26),
            ),
        ),
      ],
    );
  }
}

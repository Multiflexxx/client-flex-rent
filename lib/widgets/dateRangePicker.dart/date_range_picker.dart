import 'package:flutter/material.dart';
import 'package:rent/widgets/slide_bar.dart';
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

  DateRangePicker(
    this.scrollController, {
    this.date,
    this.range,
    this.minDate,
    this.maxDate,
    this.displayDate,
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

  @override
  Widget build(BuildContext context) {
    _controller.selectedDate = date;
    _controller.selectedRange = range;
    return Material(
      color: Color(0xFF202020),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            SlideBar(),
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

                navigationDirection:
                    DateRangePickerNavigationDirection.vertical,

                headerStyle: DateRangePickerHeaderStyle(
                  textStyle: TextStyle(
                    color: Colors.white,
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
                      color: Colors.white,
                    ),
                  ),
                  dayFormat: 'EE',
                  weekendDays: List<int>()..add(7),
                  blackoutDates: List<DateTime>()..add(DateTime(2020, 09, 26)),
                ),

                // Style
                backgroundColor: Color(0xFF202020),
                monthCellStyle: DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(color: Colors.white),
                    todayTextStyle: TextStyle(color: Colors.white),
                    todayCellDecoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(
                        color: Colors.red,
                        width: 1.0,
                      ),
                      shape: BoxShape.circle,
                    ),
                    weekendTextStyle: TextStyle(color: Colors.red),
                    disabledDatesTextStyle: TextStyle(color: Colors.white38)),

                selectionTextStyle: const TextStyle(color: Colors.white),
                selectionColor: Colors.blue,
                startRangeSelectionColor: Colors.purple,
                endRangeSelectionColor: Colors.purple,
                rangeSelectionColor: Colors.purpleAccent,
                rangeTextStyle: const TextStyle(
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
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class DateRangePicker extends StatelessWidget {
  final ScrollController scrollController;

  DateRangePicker(this.scrollController);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfDateRangePicker(
        headerHeight: 100,
        enablePastDates: false,
        monthCellStyle: DateRangePickerMonthCellStyle(
          blackoutDatesDecoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(color: const Color(0xFFF44436), width: 1),
              shape: BoxShape.circle),
          weekendDatesDecoration: BoxDecoration(
              color: const Color(0xFFDFDFDF),
              border: Border.all(color: const Color(0xFFB6B6B6), width: 1),
              shape: BoxShape.circle),
          specialDatesDecoration: BoxDecoration(
              color: Colors.green,
              border: Border.all(color: const Color(0xFF2B732F), width: 1),
              shape: BoxShape.circle),
          blackoutDateTextStyle: TextStyle(
              color: Colors.white, decoration: TextDecoration.lineThrough),
          specialDatesTextStyle: const TextStyle(color: Colors.white),
        ),
        selectionMode: DateRangePickerSelectionMode.range,
        initialSelectedRange: PickerDateRange(
            DateTime.now().subtract(const Duration(days: 4)),
            DateTime.now().add(const Duration(days: 3))),
      ),
    );
  }
}

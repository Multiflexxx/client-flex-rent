import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/widgets/calendar/calendar_delete_change.dart';
import 'package:rent/widgets/dateRangePicker/date_range_picker.dart';
import 'package:rent/widgets/slide_bar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart' as _picker;

class Calendar extends StatefulWidget {
  final ScrollController scrollController;
  final Offer offer;

  Calendar({this.scrollController, this.offer});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Offer _offer;
  DateRange _dateRange;

  @override
  void initState() {
    super.initState();
    _offer = widget.offer;
    _dateRange = DateRange(fromDate: null, toDate: null);
  }

  _AppointmentDataSource _getCalendarDataSource() {
    List<Appointment> appointments = <Appointment>[];

    for (DateRange dateRange in _offer.blockedDates) {
      appointments.add(
        Appointment(
          startTime: dateRange.fromDate,
          endTime: dateRange.toDate,
          subject: dateRange.blockedByLessor ? 'Blockiert' : 'Vermietet',
          color: dateRange.blockedByLessor ? Colors.blue : Colors.purple,
        ),
      );
    }

    appointments.add(
      Appointment(
        startTime: DateTime.now().add(Duration(days: 10)),
        endTime: DateTime.now().add(Duration(days: 12)),
        subject: 'Blockiert',
        color: Colors.blue,
      ),
    );

    return _AppointmentDataSource(appointments);
  }

  void changeBlockDates({DateRange dateRange}) async {
    final range = await showCupertinoModalBottomSheet<dynamic>(
      expand: true,
      context: context,
      barrierColor: Colors.black45,
      builder: (context, scrollController) => DateRangePicker(
        scrollController: scrollController,
        date: dateRange.fromDate,
        range: _picker.PickerDateRange(
          dateRange.fromDate,
          dateRange.toDate,
        ),
        minDate: DateTime.now(),
        maxDate: DateTime.now().add(
          Duration(days: 90),
        ),
        blockedDates: widget.offer.blockedDates,
      ),
    );

    if (range != null) {
      _onSelectedRangeChanged(range);
    }
  }

  void onCalendarTap({CalendarTapDetails details}) async {
    List<Appointment> _appointments = details.appointments;
    DateTime _date = details.date;
    DateRange dateRange;
    if (_appointments.length == 0) {
      dateRange = DateRange(fromDate: _date, toDate: _date);
      changeBlockDates(dateRange: dateRange);
    } else {
      if (_appointments.first.subject == 'Blockiert') {
        inspect(_appointments.first);
        dateRange = DateRange(
            fromDate: _appointments.first.startTime,
            toDate: _appointments.first.endTime);

        final String option = await showCupertinoModalBottomSheet<dynamic>(
          expand: false,
          useRootNavigator: true,
          context: context,
          barrierColor: Colors.black45,
          builder: (context, scrollController) => CalendarDeleteChange(
            scrollController: scrollController,
          ),
        );

        if (option == 'change') {
          changeBlockDates(dateRange: dateRange);
        } else if (option == 'delete') {
          print('delete');
        }
      }
    }
  }

  void _onSelectedRangeChanged(_picker.PickerDateRange dateRange) {
    final DateTime startDateValue = dateRange.startDate;
    DateTime endDateValue = dateRange.endDate;
    endDateValue ??= startDateValue;
    setState(
      () {
        if (startDateValue.isAfter(endDateValue)) {
          _dateRange =
              DateRange(fromDate: endDateValue, toDate: startDateValue);
        } else {
          _dateRange =
              DateRange(fromDate: startDateValue, toDate: endDateValue);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            SlideBar(),
            Flexible(
              child: SfCalendar(
                view: CalendarView.month,
                onTap: (CalendarTapDetails details) =>
                    onCalendarTap(details: details),
                dataSource: _getCalendarDataSource(),
                showNavigationArrow: false,
                firstDayOfWeek: 1,
                cellBorderColor: Colors.transparent,
                todayHighlightColor: Colors.red,
                backgroundColor: Theme.of(context).cardColor,
                headerStyle: CalendarHeaderStyle(
                  textStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.2,
                  ),
                ),
                viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                headerHeight: 100,
                todayTextStyle:
                    TextStyle(color: Theme.of(context).primaryColor),
                appointmentTextStyle: TextStyle(
                  fontSize: 46,
                  color: Theme.of(context).primaryColor,
                ),
                monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment,
                  showAgenda: false,
                  showTrailingAndLeadingDates: false,
                  navigationDirection: MonthNavigationDirection.vertical,
                  monthCellStyle: MonthCellStyle(
                    backgroundColor: Theme.of(context).cardColor,
                    textStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source) {
    appointments = source;
  }
}

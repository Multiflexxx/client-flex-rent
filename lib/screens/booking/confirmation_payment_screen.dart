import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';
import 'package:rent/models/offer_request_model.dart';
import 'package:rent/screens/booking/lessee/lessee_booking_screen.dart';
import 'package:rent/widgets/dateRangePicker/date_range_picker.dart';
import 'package:rent/widgets/price/detail_price_overview.dart';
import 'package:rent/widgets/offer/offer_card.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart' as _picker;

class ConfirmationPaymentScreen extends StatefulWidget {
  final OfferRequest offerRequest;

  ConfirmationPaymentScreen({this.offerRequest});

  @override
  _ConfirmationPaymentScreenState createState() =>
      _ConfirmationPaymentScreenState();
}

class _ConfirmationPaymentScreenState extends State<ConfirmationPaymentScreen> {
  DateTime _startDate;
  DateTime _endDate;

  @override
  void initState() {
    _startDate = widget.offerRequest.startDate;
    _endDate = widget.offerRequest.endDate;
    super.initState();
  }

  void _onSelectedRangeChanged(_picker.PickerDateRange dateRange) {
    final DateTime startDateValue = dateRange.startDate;
    DateTime endDateValue = dateRange.endDate;
    endDateValue ??= startDateValue;
    setState(() {
      if (startDateValue.isAfter(endDateValue)) {
        _startDate = endDateValue;
        _endDate = startDateValue;
      } else {
        _startDate = startDateValue;
        _endDate = endDateValue;
      }
    });
    widget.offerRequest.startDate = _startDate;
    widget.offerRequest.endDate = _endDate;
    inspect(widget.offerRequest);
  }

  void _bookOffer() async {
    // pushNewScreen(
    //   context,
    //   screen: LeseeBookingScreen(),
    // );
    String offerId = widget.offerRequest.offer.offerId;
    DateRange dateRange = DateRange(
        fromDate: widget.offerRequest.startDate,
        toDate: widget.offerRequest.endDate);

    ApiOfferService().bookOffer(offerId: offerId, dateRange: dateRange);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            OfferCard(
                offer: widget.offerRequest.offer, heroTag: 'confirmation'),
            // Zeitraum
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: new BoxDecoration(
                color: Color(0xFF202020),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Feather.calendar,
                                color: Colors.purple,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                'Mietzeitraum',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  height: 1.35,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.2,
                                ),
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 10.0,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${DateFormat('yMd', 'de').format(_startDate)}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          height: 1.15,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      _startDate != _endDate
                                          ? Text(
                                              ' bis ${DateFormat('yMd', 'de').format(_endDate)}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                                height: 1.15,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final range =
                                          await showCupertinoModalBottomSheet<
                                              dynamic>(
                                        expand: true,
                                        context: context,
                                        barrierColor: Colors.black45,
                                        builder: (context, scrollController) =>
                                            DateRangePicker(
                                          scrollController,
                                          date: null,
                                          range: _picker.PickerDateRange(
                                            _startDate,
                                            _endDate,
                                          ),
                                          minDate: DateTime.now(),
                                          maxDate: DateTime.now().add(
                                            Duration(days: 90),
                                          ),
                                          displayDate: null,
                                          blockedDates: widget
                                              .offerRequest.offer.blockedDates,
                                        ),
                                      );
                                      if (range != null) {
                                        _onSelectedRangeChanged(range);
                                      }
                                    },
                                    child: Text(
                                      'Bearbeiten',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        height: 1.15,
                                        fontWeight: FontWeight.w300,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Price overview
            Container(
              margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              decoration: new BoxDecoration(
                color: Color(0xFF202020),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Feather.calendar,
                          color: Colors.purple,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          'Preisübersicht',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            height: 1.35,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 1.2,
                          ),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  DetailPriceOverview(
                    price: widget.offerRequest.offer.price,
                    startDate: widget.offerRequest.startDate,
                    endDate: widget.offerRequest.endDate,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () => _bookOffer(),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                    child: Text(
                      'Bestätigen & Reservieren',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300,
                      ),
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

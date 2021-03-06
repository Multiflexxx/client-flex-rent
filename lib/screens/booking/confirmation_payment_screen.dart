import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/main.dart';
import 'package:flexrent/widgets/dateRangePicker/date_range_picker.dart';
import 'package:flexrent/widgets/price/detail_price_overview.dart';
import 'package:flexrent/widgets/offer/offer_card.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart' as _picker;

class OverviewPaymentScreen extends StatelessWidget {
  static String routeName = 'overviewPaymentScreen';

  // Not necessary!
  // final VoidCallback hideNavBarFunction;

  final Offer offer;
  final DateRange dateRange;

  OverviewPaymentScreen({this.offer, this.dateRange});

  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Reservierungsübersicht',
      bodyWidget: OverviewPaymentBody(
        offer: offer,
        dateRange: dateRange,
      ),
    );
  }
}

class OverviewPaymentBody extends StatefulWidget {
  final Offer offer;
  final DateRange dateRange;

  OverviewPaymentBody({this.offer, this.dateRange});

  @override
  _OverviewPaymentBodyState createState() => _OverviewPaymentBodyState();
}

class _OverviewPaymentBodyState extends State<OverviewPaymentBody> {
  DateRange _dateRange;

  @override
  void initState() {
    _dateRange = widget.dateRange;
    super.initState();
  }

  void _onSelectedRangeChanged(_picker.PickerDateRange dateRange) {
    final DateTime startDateValue = dateRange.startDate;
    DateTime endDateValue = dateRange.endDate;
    endDateValue ??= startDateValue;
    setState(() {
      if (startDateValue.isAfter(endDateValue)) {
        _dateRange = DateRange(fromDate: endDateValue, toDate: startDateValue);
      } else {
        _dateRange = DateRange(fromDate: startDateValue, toDate: endDateValue);
      }
    });
  }

  void _bookOffer() {
    String offerId = widget.offer.offerId;
    ApiOfferService().bookOffer(offerId: offerId, dateRange: _dateRange);
    MyApp.appKey.currentState.controller.jumpToTab(2);
    Navigator.popUntil(
        context, ModalRoute.withName(Navigator.defaultRouteName));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        OfferCard(offer: widget.offer, heroTag: 'confirmation'),
        // Zeitraum
        Container(
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
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
                            color: Theme.of(context).accentColor,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Mietzeitraum',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${DateFormat('yMd', 'de').format(_dateRange.fromDate)}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      height: 1.15,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  _dateRange.fromDate != _dateRange.toDate
                                      ? Text(
                                          ' bis ${DateFormat('yMd', 'de').format(_dateRange.toDate)}',
                                          style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
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
                                      scrollController: scrollController,
                                      date: null,
                                      range: _picker.PickerDateRange(
                                        _dateRange.fromDate,
                                        _dateRange.toDate,
                                      ),
                                      minDate: DateTime.now(),
                                      maxDate: DateTime.now().add(
                                        Duration(days: 90),
                                      ),
                                      displayDate: null,
                                      blockedDates: widget.offer.blockedDates,
                                    ),
                                  );
                                  if (range != null) {
                                    _onSelectedRangeChanged(range);
                                  }
                                },
                                child: Text(
                                  'Bearbeiten',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
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
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          padding: EdgeInsets.symmetric(vertical: 8.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
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
                      color: Theme.of(context).accentColor,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Preisübersicht',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
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
                price: widget.offer.price,
                dateRange: widget.dateRange,
              ),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: PurpleButton(
            text: Text(
              'Bestätigen & Reservieren',
            ),
            onPressed: () => _bookOffer(),
          ),
        ),
      ],
    );
  }
}

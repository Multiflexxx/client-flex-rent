import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';
import 'package:rent/screens/booking/confirmation_payment_screen.dart';
import 'package:rent/widgets/dateRangePicker/date_range_picker.dart';
import 'package:rent/widgets/price/price_overview.dart';
import 'package:rent/widgets/price/price_tag.dart';
import 'package:rent/widgets/offer/offer_description.dart';
import 'package:rent/widgets/offer_detail/user_box.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart' as _picker;

class OfferScreen extends StatefulWidget {
  final Offer offer;
  final String heroTag;
  OfferScreen({this.offer, this.heroTag});

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  Future<Offer> offer;
  DateRange _dateRange;

  @override
  void initState() {
    _dateRange = DateRange(fromDate: null, toDate: null);
    initializeDateFormatting('de_DE', null);
    offer = ApiOfferService().getOfferById(offerId: widget.offer.offerId);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Offer>(
        future: offer,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Offer offer = snapshot.data;
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  stretch: true,
                  onStretchTrigger: () {
                    return;
                  },
                  floating: false,
                  pinned: true,
                  leading: IconButton(
                    icon: Icon(Feather.arrow_left),
                    iconSize: 30.0,
                    color: Colors.white,
                    onPressed: () => Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName)),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Feather.share),
                      iconSize: 30.0,
                      color: Colors.white,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  expandedHeight: MediaQuery.of(context).size.width,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: <StretchMode>[
                      StretchMode.zoomBackground,
                      StretchMode.fadeTitle,
                    ],
                    centerTitle: true,
                    title: Text(
                      offer.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Hero(
                          tag: widget.heroTag,
                          transitionOnUserGestures: true,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                            child: offer.pictureLinks.length == 0
                                ? Image(
                                    image:
                                        AssetImage('assets/images/noimage.png'),
                                    height: 180.0,
                                    width: 180.0,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: offer.pictureLinks[0],
                                    height: 180.0,
                                    width: 180.0,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                    errorWidget: (context, url, error) => Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      SizedBox(
                        height: 10.0,
                      ),
                      // Price tile
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 18.0),
                        height: 80,
                        decoration: BoxDecoration(
                          color: Color(0xFF202020),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      PriceTag(offer.price),
                                      GestureDetector(
                                        onTap: () =>
                                            showCupertinoModalBottomSheet(
                                          expand: false,
                                          context: context,
                                          barrierColor: Colors.black45,
                                          builder:
                                              (context, scrollController) =>
                                                  PriceOverview(
                                            price: offer.price,
                                            scrollController: scrollController,
                                            dateRange: _dateRange,
                                          ),
                                        ),
                                        child: Text(
                                          'Preisübersicht',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_dateRange.fromDate != null) {
                                        Navigator.push(
                                          context,
                                          new CupertinoPageRoute(
                                            builder: (BuildContext context) =>
                                                new ConfirmationPaymentScreen(
                                              offer: offer,
                                              dateRange: _dateRange,
                                            ),
                                          ),
                                        );
                                      } else {
                                        Flushbar(
                                          messageText: Text(
                                            "Du musst einen Zeitraum auswählen.",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                          icon: Icon(
                                            Icons.info_outline,
                                            size: 28.0,
                                            color: Colors.purple,
                                          ),
                                          duration: Duration(seconds: 3),
                                          margin: EdgeInsets.all(10.0),
                                          padding: EdgeInsets.all(16.0),
                                          // flushbarPosition: FlushbarPosition.TOP,
                                          borderRadius: 8,
                                        )..show(context);
                                      }
                                    },
                                    child: Container(
                                      width: 0.4 *
                                          MediaQuery.of(context).size.width,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          color: Colors.purple,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: Center(
                                        child: Text(
                                          'Reservieren',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Description
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 18.0),
                        decoration: BoxDecoration(
                          color: Color(0xFF202020),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AutoSizeText(
                            offer.description,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              height: 1.35,
                              fontWeight: FontWeight.w300,
                            ),
                            minFontSize: 16.0,
                            maxLines: 6,
                            overflowReplacement: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  offer.description,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    height: 1.25,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                GestureDetector(
                                  onTap: () => showCupertinoModalBottomSheet(
                                    expand: false,
                                    context: context,
                                    barrierColor: Colors.black45,
                                    builder: (context, scrollController) =>
                                        ProductDescription(
                                      offer: offer,
                                      scrollController: scrollController,
                                    ),
                                  ),
                                  child: Text(
                                    "Show more",
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Availabilty
                      GestureDetector(
                        onTap: () async {
                          final range =
                              await showCupertinoModalBottomSheet<dynamic>(
                            expand: true,
                            context: context,
                            barrierColor: Colors.black45,
                            builder: (context, scrollController) =>
                                DateRangePicker(
                              scrollController,
                              date: null,
                              range: _picker.PickerDateRange(
                                _dateRange.fromDate,
                                _dateRange.toDate,
                              ),
                              minDate: DateTime.now(),
                              maxDate: DateTime.now().add(
                                Duration(days: 90),
                              ),
                              displayDate: _dateRange.fromDate,
                              blockedDates: offer.blockedDates,
                            ),
                          );
                          if (range != null) {
                            _onSelectedRangeChanged(range);
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 18.0),
                          padding: EdgeInsets.only(top: 8, bottom: 8),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                            'Verfügbarkeit',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              height: 1.35,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            maxLines: 6,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      _dateRange.fromDate != null
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${DateFormat('yMd', 'de').format(_dateRange.fromDate)}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                        height: 1.15,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                    ),
                                                    _dateRange.toDate != null &&
                                                            _dateRange
                                                                    .fromDate !=
                                                                _dateRange
                                                                    .toDate
                                                        ? Text(
                                                            ' bis ${DateFormat('yMd', 'de').format(_dateRange.toDate)}',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16.0,
                                                              height: 1.15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Ionicons.ios_arrow_forward,
                                  size: 30.0,
                                  color: Colors.white70,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // User
                      UserBox(lessor: offer.lessor),
                    ],
                  ),
                ),
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

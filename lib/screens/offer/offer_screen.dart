import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/services/helper_service.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/screens/booking/confirmation_payment_screen.dart';
import 'package:flexrent/screens/offer/offer_ratings_list_screen.dart';
import 'package:flexrent/widgets/boxes/standard_box.dart';
import 'package:flexrent/widgets/offer_detail/rating_box.dart';
import 'package:flexrent/widgets/styles/error_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/widgets/dateRangePicker/date_range_picker.dart';
import 'package:flexrent/widgets/price/price_overview.dart';
import 'package:flexrent/widgets/price/price_tag.dart';
import 'package:flexrent/widgets/offer/offer_description.dart';
import 'package:flexrent/widgets/offer_detail/user_box.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'package:syncfusion_flutter_datepicker/datepicker.dart' as _picker;

import 'offer_picture_detail_view.dart';

class OfferScreen extends StatefulWidget {
  static final routeName = 'offerScreen';

  final Offer offer;
  final String heroTag;
  final VoidCallback hideNavBarFunction;

  const OfferScreen(
      {Key key, this.offer, this.heroTag, this.hideNavBarFunction})
      : super(key: key);

  @override
  _OfferScreenState createState() => _OfferScreenState();
}

class _OfferScreenState extends State<OfferScreen> {
  Future<Offer> offer;
  Future<OfferRatingResponse> offerratings;
  DateRange _dateRange;
  User _user;

  @override
  void initState() {
    super.initState();
    _dateRange = DateRange(fromDate: null, toDate: null);
    initializeDateFormatting('de_DE', null);
    offer = ApiOfferService().getOfferById(offerId: widget.offer.offerId);

    offerratings =
        ApiOfferService().getOfferRatingsById(offer: widget.offer, page: 1);

    _user = HelperService.getUser(context: context);
  }

  List<Widget> _getWidgetList({BuildContext context, List<Offer> offerList}) {
    List<Widget> _offerList = List<Widget>();
    for (Offer offer in offerList) {
      _offerList.add(
        RatingBox(),
      );
    }
    return _offerList;
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

  void _onReservation(Offer offer) {
    HelperService.pushToProtectedScreen(
      context: context,
      hideNavBar: false,
      hideNavBarFunction: widget.hideNavBarFunction,
      popRouteName: OfferScreen.routeName,
      targetScreen: OverviewPaymentScreen(
        offer: offer,
        dateRange: _dateRange,
      ),
    );
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
                    color: Theme.of(context).primaryColor,
                    onPressed: () => Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName)),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Feather.share_2),
                      iconSize: 30.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                  backgroundColor: Theme.of(context).backgroundColor,
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
                        color: Theme.of(context).primaryColor,
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
                          child: GestureDetector(
                            onTap: () {
                              if (offer.pictureLinks.length != 0) {
                                pushNewScreenWithRouteSettings(context,
                                    screen: PictureDetailView(
                                      pictures: offer.pictureLinks,
                                    ),
                                    settings: null);
                              }
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                              ),
                              child: offer.pictureLinks.length == 0
                                  ? Image(
                                      image: AssetImage(
                                          'assets/images/noimage.png'),
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
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(
                                        Icons.error,
                                        color: Theme.of(context).primaryColor,
                                      ),
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
                          color: Theme.of(context).cardColor,
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
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w300,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  _user.userId == offer.lessor.userId
                                      ? Container(
                                          width: 0.4 *
                                              MediaQuery.of(context).size.width,
                                          height: 50.0,
                                          decoration: BoxDecoration(
                                              color: Colors.purple[200],
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
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            if (_dateRange.fromDate != null) {
                                              _onReservation(offer);
                                            } else {
                                              final range =
                                                  await showCupertinoModalBottomSheet<
                                                      dynamic>(
                                                expand: true,
                                                context: context,
                                                barrierColor: Colors.black45,
                                                builder: (context,
                                                        scrollController) =>
                                                    DateRangePicker(
                                                  scrollController:
                                                      scrollController,
                                                  date: null,
                                                  range:
                                                      _picker.PickerDateRange(
                                                    _dateRange.fromDate,
                                                    _dateRange.toDate,
                                                  ),
                                                  minDate: DateTime.now(),
                                                  maxDate: DateTime.now().add(
                                                    Duration(days: 90),
                                                  ),
                                                  displayDate:
                                                      _dateRange.fromDate,
                                                  blockedDates:
                                                      offer.blockedDates,
                                                ),
                                              );
                                              if (range != null) {
                                                _onSelectedRangeChanged(range);
                                                _onReservation(offer);
                                              }
                                            }
                                          },
                                          child: Container(
                                            width: 0.4 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                            height: 50.0,
                                            decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .accentColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10.0)),
                                            child: Center(
                                              child: Text(
                                                'Reservieren',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.w300),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Feather.calendar,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Verfügbarkeit',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                                                        color: Theme.of(context)
                                                            .primaryColor,
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
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor,
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
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Description
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 18.0),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: AutoSizeText(
                            offer.description,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
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
                                    color: Theme.of(context).primaryColor,
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
                                    "Mehr anzeigen",
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      // User
                      UserBox(lessor: offer.lessor),

                      //Product Rating
                      offer.numberOfRatings == 0
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                pushNewScreen(context,
                                    screen: OfferRatingsList(
                                      offer: offer,
                                    ));
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 18.0),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).cardColor,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Bewertungen von anderen',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          RatingBarIndicator(
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color:
                                                  Theme.of(context).accentColor,
                                            ),
                                            direction: Axis.horizontal,
                                            itemCount: 5,
                                            rating: offer.rating.toDouble(),
                                            itemSize: 30.0,
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            offer.numberOfRatings == 1
                                                ? 'Dieses Produkt hat ' +
                                                    offer.numberOfRatings
                                                        .toString() +
                                                    " Bewertung"
                                                : 'Dieses Produkt hat ' +
                                                    offer.numberOfRatings
                                                        .toString() +
                                                    " Bewertungen",
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 16.0,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Ionicons.ios_arrow_forward,
                                        size: 30.0,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                      FutureBuilder(
                        future: offerratings,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            OfferRatingResponse response = snapshot.data;
                            return Column(
                              children: response.offerRatings
                                  .map((rating) => RatingBox(
                                        rating: rating,
                                      ))
                                  .toList(),
                            );
                          } else if (snapshot.hasError) {
                            OfferRatingException e = snapshot.error;
                            return StandardBox(
                              content: Text(e.message),
                            );
                          }
                          return StandardBox(
                            content: Text("Hier ist etwas schiefgelaufen"),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            OfferException e = snapshot.error;
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
                    color: Theme.of(context).primaryColor,
                    onPressed: () => Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName)),
                  ),
                  actions: <Widget>[
                    IconButton(
                      icon: Icon(Feather.share_2),
                      iconSize: 30.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                  backgroundColor: Theme.of(context).backgroundColor,
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
                      'Mietgegenstand',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
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
                            child: Image(
                              image: AssetImage('assets/images/noimage.png'),
                              height: 180.0,
                              width: 180.0,
                              fit: BoxFit.cover,
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
                      ErrorBox(
                        errorText: e.message,
                      ),
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

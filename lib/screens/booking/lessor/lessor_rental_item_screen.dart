import 'dart:async';

import 'package:flexrent/screens/booking/lessor/lessor_finish_rent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/screens/booking/lessor/lessor_response_screen.dart';

import 'package:flexrent/widgets/styles/circle_tab_indicator.dart';
import 'package:flexrent/widgets/offer/offer_request_card.dart';
import 'package:intl/date_symbol_data_local.dart';

class LessorRentalItemScreen extends StatefulWidget {
  LessorRentalItemScreen({Key key}) : super(key: key);

  @override
  _LessorRentalItemScreenState createState() => _LessorRentalItemScreenState();
}

class _LessorRentalItemScreenState extends State<LessorRentalItemScreen> {
  final List<String> _tabs = <String>["Ausstehend", "Abgeschlossen"];
  Timer timer;
  Future<List<OfferRequest>> openOfferRequsts;
  Future<List<OfferRequest>> closedOfferRequsts;

  @override
  void initState() {
    super.initState();
    _getLessorRentalItemUpdate();
    timer = Timer.periodic(
        Duration(seconds: 3), (Timer t) => _getLessorRentalItemUpdate());
    initializeDateFormatting('de_DE', null);
  }

  void _getLessorRentalItemUpdate() {
    setState(() {
      openOfferRequsts = ApiOfferService()
          .getAllOfferRequestsbyStatusCode(statusCode: 1, lessor: true);
      closedOfferRequsts = ApiOfferService()
          .getAllOfferRequestsbyStatusCode(statusCode: 5, lessor: true);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    title: Text(
                      'Vermietgegenstände',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 21.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    floating: true,
                    pinned: true,
                    snap: false,
                    primary: true,
                    forceElevated: innerBoxIsScrolled,
                    toolbarHeight: 0.3 * MediaQuery.of(context).size.height,
                    leading: IconButton(
                      icon: Icon(Feather.arrow_left),
                      iconSize: 30.0,
                      color: Theme.of(context).primaryColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                    bottom: TabBar(
                      indicator: CircleTabIndicator(
                          color: Theme.of(context).accentColor, radius: 3.0),
                      tabs: _tabs
                          .map(
                            (String name) => Tab(
                              child: Text(
                                name,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _tabs.map(
              (String name) {
                return SafeArea(
                  top: false,
                  bottom: false,
                  child: Builder(
                    builder: (BuildContext context) {
                      if (name == _tabs[0]) {
                        return FutureBuilder(
                          future: openOfferRequsts,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<OfferRequest> openOfferRequestList =
                                  snapshot.data;
                              return CustomScrollView(
                                key: PageStorageKey<String>(name),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.all(8.0),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () => pushNewScreen(context,
                                                screen: LessorResponseScreen(
                                                    offerRequest:
                                                        openOfferRequestList[
                                                            index]),
                                                withNavBar: false),
                                            child: OfferRequestCard(
                                              offerRequest:
                                                  openOfferRequestList[index],
                                              lessor: true,
                                            ),
                                          );
                                        },
                                        childCount: openOfferRequestList.length,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              OfferException e = snapshot.error;
                              return CustomScrollView(
                                key: PageStorageKey<String>(name),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.all(8.0),
                                    sliver: SliverList(
                                      delegate: SliverChildListDelegate(
                                        <Widget>[
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 16.0),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0,
                                                horizontal: 12.0),
                                            decoration: new BoxDecoration(
                                              color:
                                                  Theme.of(context).cardColor,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Text(
                                              e.message,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        );
                      } else {
                        return FutureBuilder(
                          future: closedOfferRequsts,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<OfferRequest> closedOfferRequestList =
                                  snapshot.data;
                              return CustomScrollView(
                                key: PageStorageKey<String>(name),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.all(8.0),
                                    sliver: SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                        (BuildContext context, int index) {
                                          return GestureDetector(
                                            onTap: () => pushNewScreen(context,
                                                screen: LessorFinishScreen(
                                                    offerRequest:
                                                        closedOfferRequestList[
                                                            index]),
                                                withNavBar: false),
                                            child: OfferRequestCard(
                                              offerRequest:
                                                  closedOfferRequestList[index],
                                              lessor: true,
                                            ),
                                          );
                                        },
                                        childCount:
                                            closedOfferRequestList.length,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              OfferException e = snapshot.error;
                              return CustomScrollView(
                                key: PageStorageKey<String>(name),
                                slivers: <Widget>[
                                  SliverOverlapInjector(
                                    handle: NestedScrollView
                                        .sliverOverlapAbsorberHandleFor(
                                            context),
                                  ),
                                  SliverPadding(
                                    padding: const EdgeInsets.all(8.0),
                                    sliver: SliverList(
                                      delegate: SliverChildListDelegate(
                                        <Widget>[
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 12.0,
                                                horizontal: 16.0),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16.0,
                                                horizontal: 12.0),
                                            decoration: new BoxDecoration(
                                              color:
                                                  Theme.of(context).cardColor,
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            child: Text(
                                              e.message,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          },
                        );
                      }
                    },
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

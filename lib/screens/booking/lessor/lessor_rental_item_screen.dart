import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/exceptions/exceptions.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';
import 'package:rent/screens/booking/lessor/lessor_response_screen.dart';

import 'package:rent/widgets/circle_tab_indicator.dart';
import 'package:rent/widgets/offer/offer_request_card.dart';
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
                    title: const Text(
                      'Vermietgegenstände',
                      style: TextStyle(
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
                    bottom: TabBar(
                      indicator:
                          CircleTabIndicator(color: Colors.purple, radius: 3.0),
                      tabs: _tabs
                          .map(
                            (String name) => Tab(
                              child: Text(
                                name,
                                style: TextStyle(fontSize: 18.0),
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
                              inspect(openOfferRequestList);
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
                              return Center(
                                  child: Text(
                                e.message,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  letterSpacing: 1.35,
                                ),
                              ));
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
                                                screen: LessorResponseScreen(),
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
                              return Center(
                                child: Text(
                                  e.message,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    letterSpacing: 1.35,
                                  ),
                                ),
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

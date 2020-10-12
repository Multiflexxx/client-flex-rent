import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';
import 'package:rent/models/rent_product_model.dart';
import 'package:rent/models/future_product_model.dart';
import 'package:rent/widgets/circle_tab_indicator.dart';
import 'package:rent/widgets/offer/future_offer_card.dart';
import 'package:rent/widgets/offer/rent_offer_card.dart';
import 'package:rent/models/offer_model.dart';

import 'package:rent/screens/rentalItems/rent_detail_screen.dart';
import 'package:rent/screens/rentalItems/future_offer_detail_screen.dart';

class RentalItemsScreen extends StatefulWidget {
  RentalItemsScreen({Key key}) : super(key: key);

  @override
  _RentalItemsScreenState createState() => _RentalItemsScreenState();
}

class _RentalItemsScreenState extends State<RentalItemsScreen> {
  final List<String> _tabs = <String>[
    "Ausstehende",
    "Gemietete",
  ];

  Future<List<OfferRequest>> openOfferRequsts;
  Future<List<OfferRequest>> closedOfferRequsts;

  @override
  void initState() {
    openOfferRequsts =
        ApiOfferService().getAllOfferRequestsbyStatusCode(statusCode: 1);
    super.initState();
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
                      'Mietgegenstände',
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
                      if (name == 'Ausstehende') {
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
                                            onTap: () => print('todo'),
                                            // pushNewScreen(context,
                                            //     screen: FutureOfferDetailScreen(
                                            //       futureOffer: futureOffer,
                                            //     ),
                                            //     withNavBar: false),
                                            child: OfferRequestCard(
                                              offerRequest:
                                                  openOfferRequestList[index],
                                            ),
                                          );
                                        },
                                        childCount:
                                            productSuggestionList.length,
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
                        return Text('Scheiße');
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

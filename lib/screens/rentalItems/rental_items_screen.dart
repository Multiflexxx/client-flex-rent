import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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

  @override
  void initState() {
    inspect(ApiOfferService().getAllFutureOfferRequests(statusCode: 5));
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
            children: _tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverList(
                              delegate: name == 'Ausstehende'
                                  ? SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        FutureOffer futureOffer =
                                            futureOfferSuggestionList[index];
                                        return GestureDetector(
                                          onTap: () => print('todo'),
                                          // pushNewScreen(context,
                                          //     screen: FutureOfferDetailScreen(
                                          //       futureOffer: futureOffer,
                                          //     ),
                                          //     withNavBar: false),
                                          child: FutureOfferCard(
                                            futureOffer: futureOffer,
                                          ),
                                        );
                                        //  return GestureDetector(onTap: () => Navigator.push(context, new CupertinoPageRoute(builder: (BuildContext context) => new ProductListScreen(category.name),
                                        //  ),
                                        //  ),
                                        //  ),
                                        // return FutureProductCard(
                                        //   futureProduct: futureProduct,
                                        // );
                                      },
                                      childCount: productSuggestionList.length,
                                    )
                                  : SliverChildBuilderDelegate(
                                      (BuildContext context, int index) {
                                        RentOffer rentOffer =
                                            rentOfferSuggestionList[index];
                                        return GestureDetector(
                                          onTap: () => print('todo'),
                                          // pushNewScreen(context,
                                          //     screen: RentDetailScreen(
                                          //       rentOffer: rentOffer,
                                          //     ),
                                          //     withNavBar: false),
                                          child: RentProductCard(
                                            rentOffer: rentOffer,
                                          ),
                                        );
                                      },
                                      childCount:
                                          rentOfferSuggestionList.length,
                                    )),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

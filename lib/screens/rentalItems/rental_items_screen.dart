import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/exceptions/exceptions.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';
import 'package:rent/widgets/circle_tab_indicator.dart';
import 'package:rent/widgets/offer/offer_request_card.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rent/screens/booking/lessee/lessee_booking_screen.dart';

class RentalItemsScreen extends StatefulWidget {
  RentalItemsScreen({Key key}) : super(key: key);

  @override
  _RentalItemsScreenState createState() => _RentalItemsScreenState();
}

class _RentalItemsScreenState extends State<RentalItemsScreen> {
  final List<String> _tabs = <String>["Ausstehend", "Gemietet"];

  Future<List<OfferRequest>> openOfferRequsts;
  Future<List<OfferRequest>> closedOfferRequsts;

  @override
  void initState() {
    openOfferRequsts = ApiOfferService()
        .getAllOfferRequestsbyStatusCode(statusCode: 1, lessor: false);
    closedOfferRequsts = ApiOfferService()
        .getAllOfferRequestsbyStatusCode(statusCode: 5, lessor: false);
    initializeDateFormatting('de_DE', null);
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
                                                screen: LeseeBookingScreen(
                                                    offerRequest:
                                                        openOfferRequestList[
                                                            index]),
                                                withNavBar: false),
                                            child: OfferRequestCard(
                                              offerRequest:
                                                  openOfferRequestList[index],
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
                                                screen: LeseeBookingScreen(),
                                                withNavBar: false),
                                            child: OfferRequestCard(
                                              offerRequest:
                                                  closedOfferRequestList[index],
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
                              ));
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

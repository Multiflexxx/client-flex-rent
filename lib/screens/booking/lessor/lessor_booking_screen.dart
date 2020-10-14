import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/offer_service.dart';

import 'package:rent/widgets/circle_tab_indicator.dart';
import 'package:rent/widgets/offer/offer_request_card.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:rent/screens/booking/lessee/lessee_booking_screen.dart';

class LessorBookingScreen extends StatefulWidget {
  LessorBookingScreen({Key key}) : super(key: key);

  @override
  _LessorBookingScreenState createState() => _LessorBookingScreenState();
}

class _LessorBookingScreenState extends State<LessorBookingScreen> {
  // final List<String> _tabs = <String>["Ausstehende", "Gemietete"];

  Future<List<OfferRequest>> offerRequsts;
 
  @override
  void initState() {
    offerRequsts = ApiOfferService().getAllOfferRequestsForLessor();

    initializeDateFormatting('de_DE', null);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Builder(builder: (BuildContext context) {
          return FutureBuilder(
              future: offerRequsts,
              builder: (context, snapshot) {
                if (snapshot.hasData){
                List<OfferRequest> offerRequestList = snapshot.data;
                return CustomScrollView(slivers: <Widget>[
                   SliverPadding(
                    padding: const EdgeInsets.all(8.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () => pushNewScreen(context,
                                screen: LeseeBookingScreen(
                                    offerRequest: offerRequestList[index]),
                                withNavBar: false),
                            child: OfferRequestCard(
                              offerRequest: offerRequestList[index],
                            ),
                          );
                        },
                        childCount: offerRequestList.length,
                      ),
                    ),
                  ),
                ]);
                }
                 return Center(child: CircularProgressIndicator());    
              });
        }),
      ),
    );
  }
}

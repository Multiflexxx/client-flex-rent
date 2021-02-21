import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OfferRatingsList extends StatefulWidget {
  @override
  _OfferRatingsListState createState() => _OfferRatingsListState();
}

class _OfferRatingsListState extends State<OfferRatingsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                centerTitle: true,
                title: Text(
                  'Bewertungen',
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
                toolbarHeight: 0.1 * MediaQuery.of(context).size.height,
              ),
            ),
          ];
        },
        body: Container(),
      ),
    );
  }
}

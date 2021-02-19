import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/boxes/standard_box.dart';
import 'package:flexrent/widgets/offer_detail/user_rating_box.dart';
import 'package:flexrent/widgets/styles/circle_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserReviews extends StatefulWidget {
  final User user;
  final String startTab;

  UserReviews({this.user, this.startTab = "Mieter"});

  @override
  _UserReviewsState createState() => _UserReviewsState();
}

class _UserReviewsState extends State<UserReviews> {
  final List<String> _tabs = <String>["Mieter", "Vermieter"];
  Future<UserRatingResponse> leseeratings;
  Future<UserRatingResponse> lessorratings;

  @override
  void initState() {
    leseeratings = ApiUserService()
        .getUserRatingById(user: widget.user, lessorRating: false, page: 1);
    lessorratings = ApiUserService()
        .getUserRatingById(user: widget.user, lessorRating: true, page: 1);
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
                sliver: SliverAppBar(
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
                  toolbarHeight: 0.3 * MediaQuery.of(context).size.height,
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
            ];
          },
          body: TabBarView(
            children: _tabs
                .map((String name) => SafeArea(
                    bottom: false,
                    top: false,
                    child: Builder(
                      builder: (BuildContext context) {
                        if (name == _tabs[0]) {
                          //Mieterseite
                          return FutureBuilder(
                              future: leseeratings,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  UserRatingResponse response = snapshot.data;
                                  return Column(
                                      children: response.userRatings
                                          .map((UserRating rating) =>
                                              UserRatingBox(
                                                rating: rating,
                                              ))
                                          .toList());
                                } else {
                                  return StandardBox(
                                    content: Text("Noch keine Bewertungen"),
                                  );
                                }
                              });
                        } else {
                          // Vermieterseite
                          return FutureBuilder(
                              future: lessorratings,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  UserRatingResponse response = snapshot.data;
                                  return Column(
                                      children: response.userRatings
                                          .map((UserRating rating) =>
                                              UserRatingBox(
                                                rating: rating,
                                              ))
                                          .toList());
                                } else {
                                  return StandardBox(
                                    content: Text("Noch keine Bewertungen"),
                                  );
                                }
                              });
                        }
                      },
                    )))
                .toList(),
          ),
        ),
      ),
    );
  }
}

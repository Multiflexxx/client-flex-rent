import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/boxes/standard_box.dart';
import 'package:flexrent/widgets/offer_detail/rating_box.dart';
import 'package:flexrent/widgets/styles/circle_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
    try {
      leseeratings = ApiUserService()
          .getUserRatingById(user: widget.user, lessorRating: false, page: 1);
    } catch (e) {
      leseeratings = null;
    }
    try {
      lessorratings = ApiUserService()
          .getUserRatingById(user: widget.user, lessorRating: true, page: 1);
    } catch (e) {
      lessorratings = null;
    }
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
                  iconTheme:
                      IconThemeData(color: Theme.of(context).primaryColor),
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
                                  return CustomScrollView(
                                      key: PageStorageKey<String>(name),
                                      slivers: <Widget>[
                                        SliverOverlapInjector(
                                          handle: NestedScrollView
                                              .sliverOverlapAbsorberHandleFor(
                                                  context),
                                        ),
                                        SliverList(
                                            delegate: SliverChildListDelegate(
                                                response.userRatings
                                                    .map((UserRating rating) =>
                                                    RatingBox(
                                                          rating: rating,
                                                        ))
                                                    .toList()))
                                      ]);
                                } else {
                                  return CustomScrollView(
                                      key: PageStorageKey<String>(name),
                                      slivers: <Widget>[
                                        SliverOverlapInjector(
                                          handle: NestedScrollView
                                              .sliverOverlapAbsorberHandleFor(
                                                  context),
                                        ),
                                        SliverList(
                                            delegate: SliverChildListDelegate([
                                          StandardBox(
                                            content:
                                                Text("Noch keine Bewertungen"),
                                          )
                                        ]))
                                      ]);
                                }
                              });
                        } else {
                          // Vermieterseite
                          return FutureBuilder(
                              future: lessorratings,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  UserRatingResponse response = snapshot.data;
                                  return CustomScrollView(
                                      key: PageStorageKey<String>(name),
                                      slivers: <Widget>[
                                        SliverOverlapInjector(
                                          handle: NestedScrollView
                                              .sliverOverlapAbsorberHandleFor(
                                                  context),
                                        ),
                                        SliverList(
                                            delegate: SliverChildListDelegate(
                                                response.userRatings
                                                    .map((UserRating rating) =>
                                                    RatingBox(
                                                          rating: rating,
                                                        ))
                                                    .toList()))
                                      ]);
                                } else {
                                  return CustomScrollView(
                                      key: PageStorageKey<String>(name),
                                      slivers: <Widget>[
                                        SliverOverlapInjector(
                                          handle: NestedScrollView
                                              .sliverOverlapAbsorberHandleFor(
                                                  context),
                                        ),
                                        SliverList(
                                            delegate: SliverChildListDelegate([
                                          StandardBox(
                                            content:
                                                Text("Noch keine Bewertungen"),
                                          )
                                        ]))
                                      ]);
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

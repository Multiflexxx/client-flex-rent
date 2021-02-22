import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/models/offer/offer.dart';
import 'package:flexrent/logic/models/user/user.dart';
import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/screens/user/user_reviews.dart';
import 'package:flexrent/widgets/boxes/standard_box.dart';
import 'package:flexrent/widgets/discovery_carousel.dart';
import 'package:flexrent/widgets/slideIns/slideIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class UserScreen extends StatefulWidget {
  /// User to be shown
  final User user;
  static String routeName = "userPage";

  UserScreen({this.user});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final List<String> _tabs = <String>["Vermieter", "Mieter"];
  Future<List<Offer>> offers;
  Future<UserRatingResponse> lesseeRatings;
  Future<UserRatingResponse> lessorRatings;

  @override
  void initState() {
    super.initState();
    offers = ApiOfferService().getOfferbyUser(user: widget.user);
    try {
      lesseeRatings = ApiUserService()
          .getUserRatingById(user: widget.user, lessorRating: false);
    } catch (e) {
      lesseeRatings = null;
    }
    try {
      lessorRatings = ApiUserService()
          .getUserRatingById(user: widget.user, lessorRating: true);
    } catch (e) {
      lessorRatings = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat.yMMMMd("de_DE");
    var user = widget.user;
    return Scaffold(
        body: DefaultTabController(
      length: _tabs.length,
      child:
          CustomScrollView(physics: BouncingScrollPhysics(), slivers: <Widget>[
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
                onPressed: () => Navigator.pop(context),
              ),
              actions: <Widget>[
                IconButton(
                    onPressed: () => showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      barrierColor: Colors.black45,
                      builder: (context, scrollController) => SlideIn(
                        top: false,
                        widgetList: [
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(Icons.report,
                                      color: Theme.of(context).primaryColor),
                                  SizedBox(
                                    width: 5.0,
                                  ),
                                  Text(
                                    "Benutzer melden",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  )
                                ],
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    icon: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).primaryColor,
                    )),
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.firstName + " " + user.lastName,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                    ),
                    user.verified
                        ? Icon(
                      Feather.user_check,
                      color: Theme.of(context).accentColor,
                    )
                        : Text("")
                  ],
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Hero(
                      tag: "User",
                  transitionOnUserGestures: true,
                  child: GestureDetector(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      child: user.profilePicture.length == 0
                          ? Image(
                              image: AssetImage('assets/images/noimage.png'),
                            height: 180.0,
                            width: 180.0,
                            fit: BoxFit.cover,
                          )
                              : CachedNetworkImage(
                            imageUrl: user.profilePicture,
                            height: 180.0,
                            width: 180.0,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Icon(
                              Icons.error,
                              color: Theme.of(context).primaryColor,
                            ),
                            errorWidget: (context, url, error) => Icon(
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
                delegate: SliverChildListDelegate(<Widget>[
                  StandardBox(
                      content: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  user.city,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                Text(
                      " (" + user.postCode + ")",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Flexer seit August 2020",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ])),
                  FutureBuilder(
                      future: offers,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DiscoveryCarousel(
                            carouselTitle: 'Angebote von ' + user.firstName,
                            offerList: snapshot.data,
                            hideNavBarFunction: () {},
                            user: user,
                          );
                        } else {
                          return Container();
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Bewertungen als',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 15,
                            child: GestureDetector(
                              onTap: () {
                                pushNewScreen(context,
                                    screen: UserReviews(
                                      user: user,
                                      startTab: 0,
                                    ));
                              },
                              child: StandardBox(
                                height: 0.4 * MediaQuery.of(context).size.width,
                                margin: false,
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Mieter",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    user.lesseeRating == null ||
                                        user.numberOfLesseeRatings == 0
                                        ? Text(
                                      "Keine Bewertungen",
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1.2,
                                      ),
                                    )
                                        : Row(
                                      children: [
                                        Text(
                                          user.lesseeRating.toString(),
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        RatingBarIndicator(
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Theme.of(context).accentColor,
                                          ),
                                          direction: Axis.horizontal,
                                          itemCount: 5,
                                          rating: user.lesseeRating.toDouble(),
                                          itemSize: 25.0,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.numberOfLesseeRatings == 1
                                              ? user.numberOfLesseeRatings.toString() +
                                              " Bewertung"
                                              : user.numberOfLesseeRatings.toString() +
                                              " Bewertungen",
                                          style: TextStyle(
                                            color: Theme.of(context).primaryColor,
                                            fontSize: 20.0,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(),
                          ),
                          Flexible(
                            flex: 15,
                            child: GestureDetector(
                              onTap: () {
                                pushNewScreen(context,
                                    screen: UserReviews(
                                      user: user,
                                      startTab: 1,
                                    ));
                              },
                              child: StandardBox(
                                height: 0.4 * MediaQuery.of(context).size.width,
                                margin: false,
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Vermieter",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    user.lessorRating == null ||
                                        user.numberOfLessorRatings == 0
                                        ? Text(
                                      "Keine Bewertungen",
                                      overflow: TextOverflow.fade,
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1.2,
                                      ),
                                    )
                                        : Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              user.lessorRating.toString(),
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.0,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.0,
                                            ),
                                            RatingBarIndicator(
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color:
                                                Theme.of(context).accentColor,
                                              ),
                                              direction: Axis.horizontal,
                                              itemCount: 5,
                                              rating:
                                              user.lesseeRating.toDouble(),
                                              itemSize: 25.0,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              user.numberOfLesseeRatings == 1
                                                  ? user.numberOfLesseeRatings
                                                  .toString() +
                                                  " Bewertung"
                                                  : user.numberOfLesseeRatings
                                                  .toString() +
                                                  " Bewertungen",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontSize: 20.0,
                                                letterSpacing: 1.2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),

                  //User Ratingbox falls rating da ist, sonst nichts
                  /*
                TabBar(
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


              Container(
                height: 200,
                child: TabBarView(
                   children: [
                     Text("Test"),
                     Text("Test2"),
                   ],
                ),
              ),*/
                  /*
              Container(
                child: FutureBuilder(
                        future: lesseeratings,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                            children: snapshot.data.map((UserRating rating) {return UserRatingBox(rating: snapshot.data,);}).toList(),
                            );

                            return UserRatingBox(
                              rating: snapshot.data[0],
                            );
                          } else {
                            return Container();
                          }
                        }),
                ),
              ),*/
                ]))
          ]),
        ));
  }
}

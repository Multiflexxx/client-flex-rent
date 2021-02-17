import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/models/offer/offer.dart';
import 'package:flexrent/logic/models/user/user.dart';
import 'package:flexrent/logic/services/offer_service.dart';
import 'package:flexrent/widgets/boxes/standard_box.dart';
import 'package:flexrent/widgets/discovery_carousel.dart';
import 'package:flexrent/widgets/offer_detail/user_rating_box.dart';
import 'package:flexrent/widgets/slideIns/slideIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UserScreen extends StatefulWidget {
  /// User to be shown
  final User user;
  static String routeName = "userPage";

  UserScreen({this.user});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Future<List<Offer>> offers;

  @override
  void initState() {
    super.initState();
    offers = ApiOfferService().getOfferbyLessor(lessor: widget.user);
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.user;
    /*
    return Scaffold(
          body: StandardSliverAppBarList(
            title: user.firstName + " " + user.lastName,
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_horiz,
                  color: Theme.of(context).primaryColor,
                ),
              )
            ],
            leading: IconButton(
              icon: Icon(Feather.arrow_left),
              iconSize: 30.0,
              color: Theme.of(context).primaryColor,
              onPressed: () => Navigator.pop(context),
            ),
            bodyWidget: Container(),
          ),
    );*/

    return Scaffold(
        body: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
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
                                          color:
                                              Theme.of(context).primaryColor),
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
                    user.firstName + user.lastName,
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
                    tag: "test",
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
                ])),
            FutureBuilder(
                future: offers,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return DiscoveryCarousel(
                      carouselTitle: 'Angebote von ' + user.firstName,
                      offerList: snapshot.data,
                      hideNavBarFunction: () {},
                    );
                  } else {
                    return Container();
                  }
                }),
            StandardBox(
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user.lesseeRating == null || user.numberOfLesseeRatings == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Noch keine Mieterbewertungen",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Mieterbewertung: ",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              user.lesseeRating.toString(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Theme.of(context).accentColor,
                            ),
                            Text(
                              "(" + user.numberOfLesseeRatings.toString() + ")",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                  user.lessorRating == null || user.numberOfLessorRatings == 0
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Noch keine Vermieterbewertungen",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Vermieterbewertung: ",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Text(
                              user.lessorRating.toString(),
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              color: Theme.of(context).accentColor,
                            ),
                            Text(
                              "(" + user.numberOfLessorRatings.toString() + ")",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        )
                ],
              ),
            ),

            //User Ratingbox falls rating da ist, sonst nichts
            UserRatingBox(),
          ]))
        ]));
  }
}

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/models/user/user.dart';
import 'package:flexrent/screens/discovery/discovery_offer_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/models/offer/offer.dart';
import 'package:flexrent/screens/offer/offer_screen.dart';

class DiscoveryCarousel extends StatefulWidget {
  final List<Offer> offerList;
  final String carouselTitle;
  final VoidCallback hideNavBarFunction;

  /// If the Carousel is for Offers of a specific user, this needs to be defined
  final User user;

  const DiscoveryCarousel(
      {Key key,
      this.offerList,
      this.carouselTitle,
      this.hideNavBarFunction,
      this.user})
      : super(key: key);

  @override
  _DiscoveryCarouselState createState() => _DiscoveryCarouselState();
}

class _DiscoveryCarouselState extends State<DiscoveryCarousel> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: GestureDetector(
              onTap: () => pushNewScreenWithRouteSettings(
                    context,
                    screen: DiscoveryOfferListScreen(
                      carouselTitle: widget.carouselTitle,
                      hideNavBarFunction: widget.hideNavBarFunction,
                      userOffers: widget.user,
                    ),
                    settings:
                        RouteSettings(name: DiscoveryOfferListScreen.routeName),
                  ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.carouselTitle,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'Alle',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ])),
        ),
        Container(
          height: 230.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.offerList.length,
            itemBuilder: (BuildContext context, int index) {
              Offer offer = widget.offerList[index];
              return GestureDetector(
                onTap: () => pushNewScreenWithRouteSettings(
                  context,
                  screen: OfferScreen(
                    offer: offer,
                    heroTag: offer.offerId + widget.carouselTitle,
                    hideNavBarFunction: widget.hideNavBarFunction,
                  ),
                  withNavBar: false,
                  settings: RouteSettings(name: OfferScreen.routeName),
                ),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
                  width: 170.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 80.0,
                          width: 160.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '${offer.title}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.5,
                                    height: 1.75,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 16.0,
                                      width: 16.0,
                                      child: SvgPicture.network(
                                        offer.category.pictureLink,
                                        color: Theme.of(context).accentColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Flexible(
                                      child: AutoSizeText(
                                        offer.category.name,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                        ),
                                        maxLines: 1,
                                        minFontSize: 14.0,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0,
                            ),
                          ],
                        ),
                        child: Hero(
                          tag: offer.offerId + widget.carouselTitle,
                          transitionOnUserGestures: true,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: offer.pictureLinks.length == 0
                                ? Image(
                                    image:
                                        AssetImage('assets/images/noimage.png'),
                                    height: 140.0,
                                    width: 140.0,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: offer.pictureLinks[0],
                                    height: 140.0,
                                    width: 140.0,
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
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

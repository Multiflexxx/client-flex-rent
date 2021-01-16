import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/screens/discovery/discovery_offer_list_screen.dart';
import 'package:flexrent/screens/offer/offer_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/models/offer/offer.dart';
import 'package:flexrent/screens/offer/offer_screen.dart';

class DiscoveryCarousel extends StatefulWidget {
  final List<Offer> offerList;
  final String carouselTitle;

  DiscoveryCarousel(this.offerList, this.carouselTitle);

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
              onTap: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          DiscoveryOfferListScreen(
                              carouselTitle: widget.carouselTitle),
                    ),
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
                      'See all',
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ])),
        ),
        Container(
          height: 300.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.offerList.length,
            itemBuilder: (BuildContext context, int index) {
              Offer offer = widget.offerList[index];
              return GestureDetector(
                onTap: () => pushNewScreen(
                  context,
                  screen: OfferScreen(
                    offer: offer,
                    heroTag: offer.offerId + widget.carouselTitle,
                  ),
                  withNavBar: false,
                ),
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: 210.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 120.0,
                          width: 200.0,
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
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1.2,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Feather.activity,
                                      size: 16.0,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Flexible(
                                      child: AutoSizeText(
                                        offer.category.name,
                                        style: TextStyle(
                                          color: Theme.of(context).accentColor,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1.2,
                                        ),
                                        maxLines: 1,
                                        minFontSize: 16.0,
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
                                    height: 180.0,
                                    width: 180.0,
                                    fit: BoxFit.cover,
                                  )
                                : CachedNetworkImage(
                                    imageUrl: offer.pictureLinks[0],
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

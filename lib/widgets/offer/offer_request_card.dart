import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/dictionary/request_status_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flexrent/logic/models/models.dart';

class OfferRequestCard extends StatelessWidget {
  final OfferRequest offerRequest;
  final bool lessor;

  OfferRequestCard({this.offerRequest, this.lessor});

  String getInfoText(bool lessor, int statusId) {
    if (!lessor) {
      try {
        return lesseeStatusText[statusId - 1];
      } catch (e) {
        return lesseeStatusText[lesseeStatusText.length - 1];
      }
    } else {
      try {
        return lessorStatusText[statusId - 1];
      } catch (e) {
        return lessorStatusText[lessorStatusText.length - 1];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Badge(
      showBadge: offerRequest.newUpdate,
      position: BadgePosition.topEnd(
        top: 9,
        end: 9,
      ),
      padding: EdgeInsets.all(7),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 180,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: <Widget>[
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(80, 0, 10, 0),
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(80.0, 20.0, 20.0, 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${offerRequest.offer.title}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${DateFormat('yMd', 'de').format(offerRequest.dateRange.fromDate)} - ${DateFormat('yMd', 'de').format(offerRequest.dateRange.toDate)}',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              getInfoText(lessor, offerRequest.statusId),
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                                fontSize: 16.0,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 160,
                    margin: EdgeInsets.fromLTRB(15.0, 0.0, 0, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: offerRequest.offer.pictureLinks.length == 0
                          ? Image(
                              image: AssetImage('assets/images/noimage.png'),
                              height: 140.0,
                              width: 140.0,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: offerRequest.offer.pictureLinks[0],
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

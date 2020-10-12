import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent/logic/models/models.dart';


class OfferRequestCard extends StatelessWidget {
  final OfferRequest offerRequest;

  OfferRequestCard({Key key, this.offerRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 220,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      margin: EdgeInsets.fromLTRB(90.0, 0, 10, 0),
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Color(0xFF202020),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${offerRequest.offer.title}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    '${DateFormat('yMd', 'de').format(offerRequest.dateRange.fromDate)} - ${DateFormat('yMd', 'de').format(offerRequest.dateRange.toDate)}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      // fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  
                                 offerRequest.statusId == 5 ? Container() : SizedBox(height: 10.0),
                                   offerRequest.statusId == 5 ? Text(
                                    offerRequest.offer.rating == null
                                        ? ' Du hast den Gegenstand noch nicht bewertet'
                                        : 'Bewertung: ${offerRequest.offer.rating}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ) : Container(),
                                  SizedBox(height: 20.0),
                                  Text(
                                    offerRequest.statusId == 1
                                        ? 'Warten auf Bestätigung'
                                        : offerRequest.statusId == 2
                                            ? 'Deine Buchung wurde bestätigt'
                                            : offerRequest.statusId == 3
                                                ? 'Deine Buchung wurde abgelehnt'
                                                : offerRequest.statusId == 4
                                                    ? 'Du hast das Item erhalten'
                                                    : offerRequest.statusId == 5
                                                        ? 'Du hast das Item zurückgegeben // sollte in der anderen ansicht angezeigt werden'
                                                        : offerRequest
                                                                    .statusId ==
                                                                6
                                                            ? 'Der andere hat die Buchung stoniert'
                                                            : 'Du hast die Buchung stoniert',
                                    style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                          maxLines: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 160,
                  height: 200,
                  margin: EdgeInsets.fromLTRB(15.0, 0.0, 0, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: CachedNetworkImage(
                      imageUrl: offerRequest.offer.pictureLinks[0],
                      height: 180.0,
                      width: 180.0,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      errorWidget: (context, url, error) => Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

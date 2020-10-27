import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent/logic/models/models.dart';

class OfferRequestCard extends StatelessWidget {
  final OfferRequest offerRequest;
  final bool lessor;

  OfferRequestCard({this.offerRequest, this.lessor});

  String getInfoText(bool lessor, int statusId) {
    if (!lessor) {
      switch (statusId) {
        case 1:
          {
            return 'Warten auf Bestätigung';
          }
          break;
        case 2:
          {
            return 'Buchung angenommen';
          }
          break;
        case 3:
          {
            return 'Buchung abgelehnt';
          }
          break;
        case 4:
          {
            return 'Abgeholt';
          }
          break;
        case 5:
          {
            return 'Zurückgebracht';
          }
          break;
        case 6:
          {
            return 'Abgebrochen von Mieter';
          }
          break;
        case 7:
          {
            return 'Selber abgebrochen';
          }
          break;
        default:
          {
            return 'Da lief was schief';
          }
          break;
      }
    } else {
      switch (statusId) {
        case 1:
          {
            return 'Anfrage';
          }
          break;
        case 2:
          {
            return 'Abholung ausstehend';
          }
          break;
        case 3:
          {
            return 'Abgelehnt';
          }
          break;
        case 4:
          {
            return 'Ausgeliehen';
          }
          break;
        case 5:
          {
            return 'Abgeschlossen';
          }
          break;
        case 6:
          {
            return 'Selber abgebrochen';
          }
          break;
        case 7:
          {
            return 'Abgebrochen von Mieter';
          }
          break;
        default:
          {
            return 'Da lief was schief';
          }
          break;
      }
    }
  }

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
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                  SizedBox(height: 10.0),
                                  Text(
                                    '${DateFormat('yMd', 'de').format(offerRequest.dateRange.fromDate)} - ${DateFormat('yMd', 'de').format(offerRequest.dateRange.toDate)}',
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 16.0,
                                      // fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // SizedBox(height: 20.0),
                                  Text(
                                    getInfoText(lessor, offerRequest.statusId),
                                    style: TextStyle(
                                      color: Colors.purple,
                                      fontSize: 16.0,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  )
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
                    child: offerRequest.offer.pictureLinks.length == 0
                        ? Image(
                            image: AssetImage('assets/images/noimage.png'),
                            height: 180.0,
                            width: 180.0,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: offerRequest.offer.pictureLinks[0],
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}

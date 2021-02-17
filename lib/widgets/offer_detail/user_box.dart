import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/screens/user/user.dart';
import 'package:flexrent/widgets/styles/buttons_styles/button_purple_styled.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class UserBox extends StatelessWidget {
  final User lessor;

  UserBox({this.lessor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Vermieter/in: ${lessor.firstName} ${lessor.lastName}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18.0,
                        height: 1.35,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      'Flexer seit August 2020',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: lessor.profilePicture != ''
                      ? CachedNetworkImage(
                          imageUrl: lessor.profilePicture,
                          width: 75,
                          height: 75,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Image(
                            width: 75,
                            height: 75,
                            image: AssetImage('assets/images/jett.jpg'),
                          ),
                          errorWidget: (context, url, error) => Image(
                            width: 75,
                            height: 75,
                            image: AssetImage('assets/images/jett.jpg'),
                          ),
                        )
                      : Image(
                          width: 75,
                          height: 75,
                          image: AssetImage('assets/images/jett.jpg'),
                        ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Icon(
                  Icons.star,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '${lessor.numberOfLessorRatings} Bewertungen',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18.0,
                    height: 1.35,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            // Verification
            Row(
              children: <Widget>[
                Icon(
                  Icons.verified_user,
                  color: Theme.of(context).accentColor,
                ),
                SizedBox(
                  width: 10.0,
                ),
                lessor.verified
                    ? Text(
                        'Identität verifiziert',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          height: 1.35,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    : Text(
                        'Identität nicht verifiziert',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          height: 1.35,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            PurpleButton(
                text: Text('Mehr Informatioenen'),
                onPressed: () => pushNewScreenWithRouteSettings(context,
                    screen: UserScreen(
                      user: lessor,
                    ),
                    settings: RouteSettings(name: UserScreen.routeName))),
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/models/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class UserScreen extends StatefulWidget {
  /// User to be shown
  final User user;
  static String routeName = "userPage";

  UserScreen({this.user});

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
              onPressed: () => Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName)),
            ),
            actions: <Widget>[
              IconButton(
                  onPressed: () {},
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
              title: Text(
                user.firstName + " " + user.lastName,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
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
        ]));
  }
}

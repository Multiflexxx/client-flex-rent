import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/blocs/authentication/authentication.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/screens/account/my_items.dart';
import 'package:rent/screens/account/settings/account_settings_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User _user;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    timer = Timer.periodic(Duration(seconds: 3), (Timer t) => _fetchUser());
  }

  void _fetchUser() {
    final state = BlocProvider.of<AuthenticationBloc>(context).state
        as AuthenticationAuthenticated;
    setState(() {
      _user = state.user;
    });
  }

  Widget userCard({name, city, verified}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: _user.profilePicture != null
                    ? CachedNetworkImage(
                        imageUrl: _user.profilePicture,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Image(
                          width: 100,
                          height: 100,
                          image: AssetImage('assets/images/jett.jpg'),
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.error,
                          color: Colors.white,
                        ),
                      )
                    : Image(
                        width: 100,
                        height: 100,
                        image: AssetImage('assets/images/jett.jpg'),
                      ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$name',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: verified
                          ? Icon(
                              Icons.verified_user,
                              color: Colors.purple,
                            )
                          : null,
                    ),
                  ],
                ),
                Text('$city')
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: IconButton(
                icon: Icon(
                  Feather.settings,
                  color: Colors.white,
                ),
                onPressed: () {
                  pushNewScreen(context,
                      screen: AccountSettingsScreen(), withNavBar: true);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String _name = '${_user.firstName} ${_user.lastName}';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            userCard(name: _name, city: _user.city, verified: _user.verified),
            Divider(
              height: 20.0,
              color: Colors.purple,
            ),
            Expanded(
              child: MyItems(),
            ),
          ],
        ),
      ),
    );
  }
}

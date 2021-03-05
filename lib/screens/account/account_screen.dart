import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/services/helper_service.dart';

import 'package:flexrent/screens/authentication/no_access_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/screens/account/my_items.dart';
import 'package:flexrent/screens/account/settings/account_settings_screen.dart';

class AccountScreen extends StatefulWidget {
  static String routeName = 'rootTabScreen';

  final VoidCallback hideNavBarFunction;

  AccountScreen({this.hideNavBarFunction});

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  User _user;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    // _timer = Timer.periodic(Duration(seconds: 3), (Timer t) => _fetchUser());
  }

  void _fetchUser() {
    setState(() {
      _user = HelperService.getUser(context: context);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationAuthenticated) {
          setState(() {
            _user = state.user;
          });
        }
        if (state is AuthenticationNotAuthenticated) {
          setState(() {
            _user = null;
          });
        }
      },
      child: _user != null
          ? Scaffold(
              body: SafeArea(
                child: Column(
                  children: <Widget>[
                    userCard(user: _user),
                    Divider(
                      height: 20.0,
                      color: Theme.of(context).accentColor,
                    ),
                    Expanded(
                      child: MyItems(
                        hideNavBarFunction: widget.hideNavBarFunction,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : NoAccessScreen(
              popRouteName: AccountScreen.routeName,
              targetScreen: AccountScreen(
                hideNavBarFunction: widget.hideNavBarFunction,
              ),
              hideNavBarFunction: widget.hideNavBarFunction,
              realScreenName: 'chatScreen',
            ),
    );
  }

  Widget userCard({User user}) {
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
                child: _user.profilePicture != ''
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
                        errorWidget: (context, url, error) => Image(
                          width: 100,
                          height: 100,
                          image: AssetImage('assets/images/jett.jpg'),
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: AutoSizeText(
                        _buildName(),
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 20.0,
                          letterSpacing: 1.2,
                        ),
                        maxLines: 2,
                        minFontSize: 16.0,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    _user.verified
                        ? Flexible(
                            flex: 1,
                            child: Icon(
                              Feather.user_check,
                              color: Theme.of(context).accentColor,
                            ),
                          )
                        : Container(),
                  ],
                ),
                Text(
                  _user.city,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 1.2,
                  ),
                )
              ],
            ),
          ),
        ),
        _buildSettingsIcon(),
      ],
    );
  }

  Widget _buildSettingsIcon() {
    return Expanded(
      flex: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: IconButton(
            icon: Icon(
              Feather.settings,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              pushNewScreenWithRouteSettings(
                context,
                screen: AccountSettingsScreen(
                  hideNavBarFunction: widget.hideNavBarFunction,
                ),
                withNavBar: true,
                settings: RouteSettings(name: AccountSettingsScreen.routeName),
              );
            },
          ),
        ),
      ),
    );
  }

  String _buildName() {
    if (_user != null) {
      return _user.firstName + ' ' + _user.lastName;
    }
    return '';
  }
}

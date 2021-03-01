import 'package:badges/badges.dart';
import 'package:flexrent/logic/blocs/offer/bloc/offer_bloc.dart';
import 'package:flexrent/screens/chat/chat_overview_screen.dart';
import 'package:flexrent/screens/rentalItems/rental_items_root_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'screens/account/account_screen.dart';
import 'screens/category/category_screen.dart';
import 'screens/discovery/discovery_screen.dart';

class App extends StatefulWidget {
  final titles = ['Home', 'Category', 'Cart', 'Chat', 'Account'];

  App({Key key}) : super(key: key);

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  PersistentTabController controller;
  bool _hideNavBar;
  List<Widget> icons = [
    Icon(
      Feather.home,
      size: 22,
    ),
    Icon(
      Feather.grid,
      size: 22,
    ),
    Icon(
      Feather.shopping_bag,
      size: 22,
    ),
    Icon(
      Feather.message_circle,
      size: 22,
    ),
    Icon(
      Feather.user,
      size: 22,
    )
  ];

  @override
  void initState() {
    super.initState();
    controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      DiscoveryScreen(hideNavBarFunction: () {
        setState(() {
          _hideNavBar = !_hideNavBar;
        });
      }),
      CategoryScreen(hideNavBarFunction: () {
        setState(() {
          _hideNavBar = !_hideNavBar;
        });
      }),
      RentalItemsRootScreen(hideNavBarFunction: () {
        setState(() {
          _hideNavBar = !_hideNavBar;
        });
      }),
      ChatOverviewScreen(),
      AccountScreen(hideNavBarFunction: () {
        setState(() {
          _hideNavBar = !_hideNavBar;
        });
      }),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return widget.titles.map((title) {
      int index = widget.titles.indexOf(title);
      return PersistentBottomNavBarItem(
        icon: icons[index],
        title: title,
        activeColor: Theme.of(context).accentColor,
        inactiveColor: Theme.of(context).primaryColor,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OfferBloc, OfferState>(
      listener: (context, state) {
        List<Widget> newIcons;
        if (state.count != null) {
          newIcons = [
            Icon(
              Feather.home,
              size: 22,
            ),
            Icon(
              Feather.grid,
              size: 22,
            ),
            Badge(
              showBadge: (state.count != null &&
                      state.count.lesseesTotalNumberOfUpdates > 0)
                  ? true
                  : false,
              position: BadgePosition.topEnd(top: 5),
              padding: EdgeInsets.all(4),
              child: Icon(
                Feather.shopping_bag,
                size: 22,
              ),
            ),
            Icon(
              Feather.message_circle,
              size: 22,
            ),
            Badge(
              showBadge: (state.count != null &&
                      state.count.lessorsNumberOfNewRequests > 0)
                  ? true
                  : false,
              position: BadgePosition.topEnd(top: 5),
              padding: EdgeInsets.all(4),
              child: Icon(
                Feather.user,
                size: 22,
              ),
            ),
          ];
        } else {
          newIcons = [
            Icon(
              Feather.home,
              size: 22,
            ),
            Icon(
              Feather.grid,
              size: 22,
            ),
            Icon(
              Feather.shopping_bag,
              size: 22,
            ),
            Icon(
              Feather.message_circle,
              size: 22,
            ),
            Icon(
              Feather.user,
              size: 22,
            )
          ];
        }
        setState(() {
          icons = newIcons;
        });
      },
      child: PersistentTabView(
        context,
        routeAndNavigatorSettings:
            RouteAndNavigatorSettings(initialRoute: 'rootTabScreen'),
        controller: controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Theme.of(context).backgroundColor,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        hideNavigationBar: _hideNavBar,
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.transparent,
        ),
        popActionScreens: PopActionScreensType.all,
        popAllScreensOnTapOfSelectedTab: false,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 100),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style5,
      ),
    );
  }
}

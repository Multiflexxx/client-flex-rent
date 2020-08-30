import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'screens/account/account_screen.dart';
import 'screens/category/category_screen.dart';
import 'screens/discovery/discovery_screen.dart';
import 'package:rent/screens/cart/cart_screen.dart';
import 'package:rent/screens/search/search_screen.dart';

class App extends StatefulWidget {
  final titles = ['Home', 'Category', 'Cart', 'Search', 'Account'];
  final icons = [
    Icon(
      Feather.home,
      size: 22,
    ),
    Icon(
      Feather.grid,
      size: 22,
    ),
    Icon(
      Feather.shopping_cart,
      size: 22,
    ),
    Icon(
      Feather.search,
      size: 22,
    ),
    Icon(
      Feather.user,
      size: 22,
    )
  ];

  App({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppState();
}

class _AppState extends State<App> {
  PersistentTabController _controller;
  bool _hideNavBar;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _hideNavBar = false;
  }

  List<Widget> _buildScreens() {
    return [
      DiscoveryScreen(),
      CategoryScreen(),
      CartScreen(),
      SearchScreen(),
      AccountScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return widget.titles.map((title) {
      int index = widget.titles.indexOf(title);
      return PersistentBottomNavBarItem(
        icon: widget.icons[index],
        title: title,
        activeColor: Colors.purple,
        inactiveColor: Colors.grey,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.black,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      hideNavigationBar: _hideNavBar,
      decoration: NavBarDecoration(colorBehindNavBar: Colors.indigo),
      popAllScreensOnTapOfSelectedTab: true,
      itemAnimationProperties: ItemAnimationProperties(
        duration: Duration(milliseconds: 400),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style5, // Choose the nav bar style with this property
    );
  }
}

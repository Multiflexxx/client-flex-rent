import 'package:flutter/material.dart';
import 'package:rent/screens/account/account_screen.dart';
import 'package:rent/screens/category/category_screen.dart';
import 'package:rent/screens/discovery/discovery_screen.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == "Discovery") {
      child = DiscoveryScreen();
    } else if (tabItem == "Category") {
      child = CategoryScreen();
    } else if (tabItem == "Account") {
      child = AccountScreen();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}

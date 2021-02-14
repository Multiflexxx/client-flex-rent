import 'package:flutter/material.dart';
import 'package:flexrent/screens/search/search_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SearchBar extends StatefulWidget {
  final VoidCallback hideNavBarFunction;

  const SearchBar({Key key, this.hideNavBarFunction}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextField(
        readOnly: true,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        ),
        onTap: () {
          pushNewScreenWithRouteSettings(
            context,
            screen: SearchScreen(
              hideNavBarFunction: widget.hideNavBarFunction,
            ),
            settings: RouteSettings(name: SearchScreen.routeName),
          );
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).backgroundColor,
          hintStyle: TextStyle(color: Theme.of(context).primaryColor),
          hintText: "Suche",
          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).primaryColor,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

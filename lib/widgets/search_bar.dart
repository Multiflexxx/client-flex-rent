import 'package:flutter/material.dart';
import 'package:rent/screens/search/search_screen.dart';

class SearchBar extends StatefulWidget {
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
          color: Colors.white70,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.2,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SearchScreen(),
            ),
          );
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          hintStyle: TextStyle(color: Colors.white70),
          hintText: "Suche",
          contentPadding: EdgeInsets.symmetric(vertical: 0.0),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white70,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.white54,
              width: 0.75,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.white54,
              width: 0.75,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = new TextEditingController();

  var queryResultSet = [];
  var tempSearchStore = [];

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    if (queryResultSet.length == 0 && value.length == 1) {
      queryResultSet = [
        'Berlin',
        'Paris',
        'Wien',
        'Madrid',
        'Prag',
        'Amsterdam',
        'Rom',
        'München',
        'Athen',
        'Lissabon',
        'London',
        'New York',
      ];
    } else {
      tempSearchStore = [
        'Wien',
        'Amsterdam',
        'München',
        'London',
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      setState(() {});
    });
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.25),
                onChanged: (query) {
                  print(query);
                  initiateSearch(query);
                },
                decoration: InputDecoration(
                  prefixIcon: BackButton(
                    color: Colors.white70,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  suffixIcon: _searchController.text.length > 0
                      ? IconButton(
                          icon: Icon(
                            Feather.x,
                          ),
                          color: Colors.white70,
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: Colors.black,
                  hintStyle: TextStyle(color: Colors.white70),
                  hintText: "Search",
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
                      color: Colors.purple,
                      width: 0.75,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element) {
                return buildResultCard(element);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
        child: Center(
          child: Text(
            data,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}

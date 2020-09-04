import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rent/screens/category/category_detail_screen.dart';
import 'package:rent/widgets/divider_with_text.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = new TextEditingController();

  final _searchResult = [
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

  final _suggestedList = [
    'Wien',
    'Amsterdam',
    'München',
    'London',
  ];

  String _heading;
  var _resultList = [];

  @override
  void initState() {
    super.initState();
    _heading = 'Vorschläge';
    _resultList = _suggestedList;
    print(_resultList);
  }

  var suggestionList = [];

  void initiateSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _heading = 'Vorschläge';
        _resultList = _suggestedList;
      });
      return;
    }
    //TODO API Call
    setState(() {
      _heading = 'Ergebnisse';
      _resultList = _searchResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    _searchController.addListener(() {
      setState(() {});
    });
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                cursorColor: Colors.purple,
                style: TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.25,
                ),
                onChanged: (query) {
                  initiateSearch(query);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.black,
                  hintStyle: TextStyle(color: Colors.white70),
                  hintText: "Search",
                  contentPadding: EdgeInsets.symmetric(vertical: 0.0),
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
                            setState(() {
                              _searchController.clear();
                              _heading = 'Vorschläge';
                              _resultList = _suggestedList;
                            });
                          },
                        )
                      : null,
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
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: DividerWithText(
                dividerText: _heading,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _resultList.length,
                itemBuilder: (context, index) =>
                    buildResultCard(_resultList[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new ListViewPage2(),
        ),
      ),
      child: Container(
        // width: MediaQuery.of(context).size.width,
        height: 0.075 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 0.2,
              color: Colors.purple,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_city,
                    size: 40.0,
                    color: Colors.white70,
                  ),
                  SizedBox(
                    width: 25.0,
                  ),
                  Text(
                    data,
                    style: TextStyle(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                        letterSpacing: 1.2),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Ionicons.ios_arrow_forward,
                    size: 30.0,
                    color: Colors.white70,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

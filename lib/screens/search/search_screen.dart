import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/screens/product/offer_list_screen.dart';
import 'package:rent/widgets/divider_with_text.dart';
import '../../logic/models/models.dart';
import '../../logic/services/offer_service.dart';
import '../product/offer_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = new TextEditingController();

  Future<List<Offer>> _searchOfferList;

  final _suggestedList = [
    'Wien',
    'Amsterdam',
    'München',
    'London',
  ];

  String _heading;
  Future<List<Offer>> _resultList;

  @override
  void initState() {
    super.initState();
    _heading = 'Vorschläge';
  }

  var suggestionList = [];

  void initiateSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _heading = 'Vorschläge';
        _resultList = Future.value();
      });
      return;
    }
    _searchOfferList = ApiOfferService()
        .getAllOffers(search: query, limit: 3)
        .catchError((error) {
      setState(() {
        _heading = error.message;
      });
    });
    _searchOfferList.whenComplete(() => setState(() {
          _heading = 'Ergebnisse';
          _resultList = _searchOfferList;
        }));
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
                              _resultList = Future.value();
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
            Expanded(
              child: FutureBuilder<List<Offer>>(
                future: _resultList,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.length > 0) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Offer offer = snapshot.data[index];
                          return GestureDetector(
                            onTap: () => pushNewScreen(
                              context,
                              screen: OfferScreen(offer: offer),
                              withNavBar: false,
                            ),
                            child: buildResultCard(offer.title),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text(
                          'Die Suche ergab keine Ergebnisse',
                          style: TextStyle(fontSize: 21.0),
                        ),
                      );
                    }
                  } else if (snapshot.hasError) {
                    print(snapshot.hasError);
                    return Text(snapshot.error);
                  }
                  return Center(child: CircularProgressIndicator());
                },
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
          builder: (BuildContext context) => new ProductListScreen(),
        ),
      ),
      child: Container(
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

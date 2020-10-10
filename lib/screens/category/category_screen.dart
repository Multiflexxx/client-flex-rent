import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rent/logic/models/models.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/screens/offer/offer_list_screen.dart';
import 'package:rent/widgets/search_bar.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Future<List<Category>> categoryList;

  @override
  initState() {
    super.initState();
    categoryList = ApiOfferService().getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: SearchBar(),
            ),
            Expanded(
              child: Container(
                child: FutureBuilder<List<Category>>(
                  future: categoryList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          Category category = snapshot.data[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              new CupertinoPageRoute(
                                builder: (BuildContext context) =>
                                    new ProductListScreen(category: category),
                              ),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 0.15 * MediaQuery.of(context).size.height,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          // TODO: from api
                                          Feather.airplay,
                                          size: 40.0,
                                          color: Colors.white70,
                                        ),
                                        SizedBox(
                                          width: 25.0,
                                        ),
                                        Text(
                                          category.name,
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
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flexrent/logic/exceptions/exceptions.dart';
import 'package:flexrent/widgets/styles/error_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/screens/offer/offer_list_screen.dart';
import 'package:flexrent/widgets/styles/search_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CategoryScreen extends StatefulWidget {
  static String routeName = 'rootTabScreen';

  final VoidCallback hideNavBarFunction;

  const CategoryScreen({Key key, this.hideNavBarFunction}) : super(key: key);

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
                            onTap: () => pushNewScreenWithRouteSettings(
                              context,
                              screen: OfferListScreen(
                                category: category,
                                hideNavBarFunction: widget.hideNavBarFunction,
                              ),
                              settings: RouteSettings(
                                name: OfferListScreen.routeName,
                              ),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 0.15 * MediaQuery.of(context).size.height,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 0.25,
                                    color: Theme.of(context).accentColor,
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
                                        Container(
                                          height: 50.0,
                                          width: 50.0,
                                          child: SvgPicture.network(
                                            category.pictureLink,
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25.0,
                                        ),
                                        Text(
                                          category.name,
                                          style: TextStyle(
                                              fontSize: 21.0,
                                              fontWeight: FontWeight.w300,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              letterSpacing: 1.2),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Ionicons.ios_arrow_forward,
                                          size: 30.0,
                                          color: Theme.of(context).primaryColor,
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
                    } else if (snapshot.hasError) {
                      OfferException e = snapshot.error;
                      return ErrorBox(errorText: e.message);
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

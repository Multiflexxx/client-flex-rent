import 'package:flexrent/screens/offer/offer_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexrent/logic/blocs/authentication/authentication.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';

import 'package:flexrent/widgets/discovery_carousel.dart';
import 'package:flexrent/widgets/styles/search_bar.dart';
import 'package:flutter_svg/svg.dart';

class DiscoveryScreen extends StatefulWidget {
  @override
  _DiscoveryScreen createState() => _DiscoveryScreen();
}

class _DiscoveryScreen extends State<DiscoveryScreen> {
  User user;

  Future<Map<String, List<Offer>>> discoveryOffer;
  Future<List<Category>> topCategories;

  @override
  initState() {
    final state = BlocProvider.of<AuthenticationBloc>(context).state
        as AuthenticationAuthenticated;
    user = state.user;
    _fetchDiscoveryOffer();
    _fetchTopCategories();
    super.initState();
  }

  Future<dynamic> _fetchDiscoveryOffer() {
    var fetchData =
        ApiOfferService().getDiscoveryOffer(postCode: user.postCode);
    setState(() {
      discoveryOffer = fetchData;
    });
    return fetchData;
  }

  Future<List<Category>> _fetchTopCategories() {
    var fetchData = ApiOfferService().getTopCategory();
    setState(() {
      topCategories = fetchData;
    });
    return fetchData;
  }

  Widget _buildIcon(Category category) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) =>
                ProductListScreen(category: category),
          )),
      child: Container(
        height: 40.0,
        width: 40.0,
        child: SvgPicture.network(
          category.pictureLink,
          color: Theme.of(context).primaryColor,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildIconRow({List<Category> categories}) {
    List<Widget> widgets = [];

    categories.asMap().forEach(
      (index, category) {
        widgets.add(
          _buildIcon(category),
        );
        if (index != (categories.length - 1)) {
          widgets.add(
            Container(
              height: 30,
              child: VerticalDivider(
                color: Theme.of(context).primaryColor,
                thickness: 1.0,
              ),
            ),
          );
        }
      },
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return RefreshIndicator(
              onRefresh: () => _fetchDiscoveryOffer(),
              backgroundColor: Theme.of(context).accentColor,
              color: Colors.white,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SearchBar(),
                        Padding(
                          padding: EdgeInsets.only(top: 20.0, left: 20.0),
                          child: Text(
                            'Hallo ${user.firstName} ${user.lastName}',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        FutureBuilder<Map<String, List<Offer>>>(
                          future: discoveryOffer,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Column(
                                children: <Widget>[
                                  SizedBox(height: 20.0),
                                  DiscoveryCarousel(
                                    snapshot.data['bestOffer'],
                                    'Topseller',
                                  ),
                                  SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          'Top Kategorien',
                                          style: TextStyle(
                                            fontSize: 22.0,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 8.0),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 16.0, horizontal: 10.0),
                                    decoration: new BoxDecoration(
                                      color: Theme.of(context).cardColor,
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: FutureBuilder<List<Category>>(
                                      future: topCategories,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<Category> categories =
                                              snapshot.data;
                                          return _buildIconRow(
                                              categories: categories);
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  DiscoveryCarousel(
                                    snapshot.data['latestOffers'],
                                    'Neuste',
                                  ),
                                  SizedBox(height: 20.0),
                                  DiscoveryCarousel(
                                    snapshot.data['bestLessors'],
                                    'Beste Vermieter',
                                  ),
                                ],
                              );
                            }
                            return Expanded(
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

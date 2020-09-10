import 'package:flutter/material.dart';
import 'package:rent/widgets/circle_tab_indicator.dart';

class RentalItemsScreen extends StatefulWidget {
  RentalItemsScreen({Key key}) : super(key: key);

  @override
  _RentalItemsScreenState createState() => _RentalItemsScreenState();
}

class _RentalItemsScreenState extends State<RentalItemsScreen> {
  final List<String> _tabs = <String>[
    "Ausstehende",
    "Gemietete",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    title: const Text(
                      'Mietgegenstände',
                      style: TextStyle(
                        fontSize: 21.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                    backgroundColor: Colors.transparent,
                    floating: true,
                    pinned: true,
                    snap: false,
                    primary: true,
                    forceElevated: innerBoxIsScrolled,
                    toolbarHeight: 0.3 * MediaQuery.of(context).size.height,
                    bottom: TabBar(
                      indicator:
                          CircleTabIndicator(color: Colors.purple, radius: 3.0),
                      tabs: _tabs
                          .map(
                            (String name) => Tab(
                              child: Text(
                                name,
                                style: TextStyle(fontSize: 18.0),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverList(
                            delegate: SliverChildListDelegate(
                              <Widget>[
                                name == 'Ausstehende'
                                    ? Container(
                                        color: Colors.red,
                                        child: Text('Hallo'),
                                      )
                                    : Container(
                                        color: Colors.green,
                                        child: Text('Tschau'),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
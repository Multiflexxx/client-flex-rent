import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rent/models/product_model.dart';

class ProductScreen extends StatefulWidget {
  final Product product;

  ProductScreen({this.product});
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              return;
            },
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: Icon(Feather.arrow_left),
              iconSize: 30.0,
              color: Colors.white,
              onPressed: () => Navigator.pop(context),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Feather.share),
                iconSize: 30.0,
                color: Colors.white,
                onPressed: () => Navigator.pop(context),
              ),
            ],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            expandedHeight: MediaQuery.of(context).size.width,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.product.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
              ),
              // title: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     Row(
              //       children: <Widget>[
              //         Text(
              //           widget.product.title,
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 21.0,
              //             fontWeight: FontWeight.w500,
              //             letterSpacing: 1.2,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              background: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.width,
                        child: Hero(
                          tag: widget.product.productId,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30.0),
                              bottomRight: Radius.circular(30.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 50.0),
                              child: Image(
                                image: AssetImage(widget.product.imageUrl),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Sunday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Monday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Sunday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Monday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Sunday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Monday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Sunday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Monday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Sunday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Monday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Sunday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Monday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Sunday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Monday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Sunday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
              ListTile(
                leading: Icon(Icons.wb_sunny),
                title: Text(
                  'Monday',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text('sunny, h: 80, l: 65'),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

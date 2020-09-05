import 'package:flutter/material.dart';
import 'package:rent/models/offer_model.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Infinite List"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new ListViewPage2()));
              },
              leading: Text("$index"),
              title: Text("Number $index"));
        },
      ),
    );
  }
}

class ListViewPage2 extends StatelessWidget {
  const ListViewPage2({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Infinite List 2"),
      ),
      body: ListView.builder(
        itemCount: productSuggestionList.length,
        itemBuilder: (context, index) {
          Offer offer = productSuggestionList[index];

          return Container(
            margin: EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 12.0),
            decoration: BoxDecoration(
              color: Color(0xFF202020),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image(
                          height: 175,
                          width: 175,
                          image: AssetImage(offer.imageUrl),
                        ),
                      ),
                      // Flexible(
                      //   child: Text(
                      //     '${offer.title}',
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 18.0,
                      //       letterSpacing: 1.2,
                      //     ),
                      //     maxLines: 1,
                      //     overflow: TextOverflow.ellipsis,
                      //   ),
                      // ),
                      Flexible(
                        child: Text(
                          '${offer.description}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            letterSpacing: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );

          // child: Row(
          //   children: <Widget>[
          //     Padding(
          //       padding: const EdgeInsets.all(10.0),
          //       child: Image(
          //         height: 170.0,
          //         width: 170.0,
          //         image: AssetImage(product.imageUrl),
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         children: <Widget>[
          //           Text(
          //             '${product.title}',

          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 17.0,
          //               fontWeight: FontWeight.w500,
          //               letterSpacing: 1.2,
          //             ),
          //             maxLines: 3,
          //                overflow: TextOverflow.ellipsis,

          //           ),
          //           Text(
          //             '${product.description}',

          //             style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 14.0,
          //               letterSpacing: 1.2,
          //             ),
          //             maxLines: 1,
          //             overflow: TextOverflow.ellipsis,
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
        },
      ),
    );
  }
}

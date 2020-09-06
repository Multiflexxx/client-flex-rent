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
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 240,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: <Widget>[
                      Positioned(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(100.0, 0, 10, 0),
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Color(0xFF202020),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Flexible(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    100.0, 20.0, 20.0, 20.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${offer.title}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.2,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${offer.description}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        letterSpacing: 1.2,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '${offer.price}',
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 1.2,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      'Bewertung',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                        letterSpacing: 1.2,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 170,
                        height: 200,
                        margin: EdgeInsets.fromLTRB(15.0, 0.0, 0, 0),
                        // color: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            height: 100,
                            width: 200,
                            image: AssetImage(offer.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

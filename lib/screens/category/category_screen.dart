import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:rent/models/category_model.dart';
import 'package:rent/screens/category/category_detail_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            Category category = categoryList[index];
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                  builder: (BuildContext context) => new ListViewPage2(),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(
                            category.icon,
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
        ),
      ),
    );
  }
}

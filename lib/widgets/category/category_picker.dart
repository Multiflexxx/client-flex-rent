import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/slideIns/slide_bar.dart';
import 'package:flutter_svg/svg.dart';

class CategoryPicker extends StatefulWidget {
  final ScrollController scrollController;

  CategoryPicker({this.scrollController});

  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  List<Category> categoryList;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  void getCategories() async {
    List<Category> _categoryList = await ApiOfferService().getAllCategory();
    setState(() {
      categoryList = _categoryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SlideBar(),
            categoryList != null
                ? Flexible(
                    child: ListView.builder(
                        itemCount: categoryList.length,
                        itemBuilder: (context, index) {
                          Category _category = categoryList[index];
                          return ListTile(
                            title: Text(
                              _category.name,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                letterSpacing: 1.2,
                              ),
                            ),
                            leading: Container(
                              height: 25.0,
                              width: 25.0,
                              child: SvgPicture.network(
                                _category.pictureLink,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                            onTap: () => Navigator.pop(context, _category),
                          );
                        }),
                  )
                : Container(
                    child: Text('Warten auf Kategorien!'),
                  ),
          ],
        ),
      ),
    );
  }
}

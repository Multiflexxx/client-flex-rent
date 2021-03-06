import 'package:flexrent/widgets/slideIns/slideIn.dart';
import 'package:flutter/material.dart';
import 'package:flexrent/logic/models/models.dart';
import 'package:flexrent/logic/services/services.dart';
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
    return SlideIn(
      top: false,
      widgetList: [
        categoryList != null
            ? Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
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
                  },
                ),
              )
            : ListTile(
                title: Text(
                  'Warten auf Kategorien!',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
                leading: Icon(
                  Icons.info_outline,
                  color: Theme.of(context).primaryColor,
                ),
              ),
      ],
    );
  }
}

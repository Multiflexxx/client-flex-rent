import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flexrent/logic/models/category/category.dart';
import 'package:flexrent/logic/models/offer/offer.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/category/category_picker.dart';
import 'package:flexrent/widgets/styles/formfield_styled.dart';
import 'package:flexrent/widgets/layout/standard_sliver_appbar_list.dart';

class AddItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StandardSliverAppBarList(
      title: 'Produkt einstellen',
      bodyWidget: _AddItemBody(),
    );
  }
}

class _AddItemBody extends StatefulWidget {
  @override
  _AddItemBodyState createState() => _AddItemBodyState();
}

class _AddItemBodyState extends State<_AddItemBody> {
  final _key = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descritpionController = TextEditingController();
  final _priceController = TextEditingController();

  http.Response apiResult;

  String barcodeResult = '';
  Category _category;
  AutovalidateMode _validateMode;

  @override
  void initState() {
    super.initState();
    _validateMode = AutovalidateMode.disabled;
  }

  void _selectCategory({BuildContext parentContext}) async {
    final Category _selectedCategory = await showCupertinoModalBottomSheet(
      expand: false,
      useRootNavigator: true,
      context: context,
      barrierColor: Colors.black45,
      builder: (context, scrollController) => CategoryPicker(
        scrollController: scrollController,
      ),
    );
    if (_selectedCategory != null) {
      setState(() {
        _category = _selectedCategory;
      });
    }
  }

  void _createOffer() async {
    setState(() {
      _validateMode = AutovalidateMode.always;
    });
    if (_key.currentState.validate() && _category != null) {
      Offer offer = Offer(
        title: _titleController.text,
        description: _descritpionController.text,
        category: _category,
        price: double.parse(_priceController.text),
      );
      Offer backendOffer = await ApiOfferService().createOffer(newOffer: offer);
      // Keep that!!!!
      // Navigator.of(context).pushAndRemoveUntil(
      //   CupertinoPageRoute(
      //     builder: (BuildContext context) {
      //       return UpdateOfferScreen(
      //         offer: backendOffer,
      //       );
      //     },
      //   ),
      //   ModalRoute.withName(Navigator.defaultRouteName),
      // );
      Navigator.pop(context, backendOffer);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          decoration: new BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Form(
            key: _key,
            autovalidateMode: _validateMode,
            child: Column(
              children: [
                FormFieldStyled(
                  controller: _titleController,
                  hintText: "Produktname",
                  autocorrect: true,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Produktname notwendig';
                    }
                  },
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).cardColor,
                    textColor: Colors.white,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: (_validateMode == AutovalidateMode.always &&
                                _category == null)
                            ? Colors.red
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        _category != null ? _category.name : 'Kategorie',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.w400),
                      ),
                    ),
                    onPressed: () => _selectCategory(parentContext: context),
                  ),
                ),
                SizedBox(height: 16.0),
                FormFieldStyled(
                  controller: _descritpionController,
                  hintText: "Beschreibung",
                  autocorrect: true,
                  maxLines: 8,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Beschreibung notwendig';
                    }
                  },
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FormFieldStyled(
                        controller: _priceController,
                        hintText: "Preis",
                        autocorrect: true,
                        type: TextInputType.numberWithOptions(
                          signed: false,
                          decimal: true,
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Produktname notwendig';
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                        child: Text('€ Pro Tag',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor)),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(16),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(8.0)),
                    child: Text('Speichern'),
                    onPressed: () {
                      _createOffer();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 75.0,
        ),
      ],
    );
  }

  void _showError(Exception e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Fehler",
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          content: new Text(
            e.toString(),
            style: TextStyle(color: Theme.of(context).backgroundColor),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Schließen"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:flexrent/logic/models/category/category.dart';
import 'package:flexrent/logic/models/offer/offer.dart';
import 'package:flexrent/logic/services/services.dart';
import 'package:flexrent/widgets/category/category_picker.dart';
import 'package:flexrent/widgets/formfieldstyled.dart';
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Center(
                  child: Text('Manuell oder'),
                ),
              ),
              Expanded(
                flex: 1,
                child: RaisedButton.icon(
                  icon: Icon(
                    Icons.qr_code_scanner_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                  color: Colors.transparent,
                  padding: EdgeInsets.all(16.0),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0),
                      side: BorderSide(
                          color: Theme.of(context).accentColor, width: 1.75)),
                  onPressed: () async {
                    barcodeResult = await FlutterBarcodeScanner.scanBarcode(
                        '#FF5733', 'Abbrechen', true, ScanMode.BARCODE);
                    String url =
                        'http://opengtindb.org/?ean=$barcodeResult&cmd=query&queryid=400000000';
                    String differentUrl =
                        'https://api.barcodelookup.com/v2/products?barcode=$barcodeResult&formatted=y&key=6y8fd1esob8wg7lq6wbt65bpx45tar';
                    if (barcodeResult != "-1") {
                      //-1 heißt der barcode scanner wurde abgebrochen
                      apiResult = await http.get(url);
                      try {
                        setState(() {
                          Offer product = apiResponseToOffer(apiResult);
                          _titleController.text = product.title;
                          _descritpionController.text = product.description;
                        });
                      } catch (e) {
                        _showError(e);
                      }
                    }
                  },
                  label: Text(
                    'Scan',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              )
            ],
          ),
        ),
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
                    textColor: Theme.of(context).primaryColor,
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
                    textColor: Theme.of(context).primaryColor,
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

  Offer apiResponseToOffer(http.Response apiResult) {
    String result = apiResult.body;
    Offer offer = Offer(
      title: "",
      price: 0.0,
      offerId: null,
      description: "",
      category: null,
      numberOfRatings: null,
      rating: null,
    );
    //fehlercodes:
    //0 - OK - Operation war erfolgreich
    // 1 - not found - die EAN konnte nicht gefunden werden
    // 2 - checksum - die EAN war fehlerhaft (Checksummenfehler)
    // 3 - EAN-format - die EAN war fehlerhaft (ungültiges Format / fehlerhafte Ziffernanzahl)
    // 4 - not a global, unique EAN - es wurde eine für interne Anwendungen reservierte EAN eingegeben (In-Store, Coupon etc.)
    // 5 - access limit exceeded - Zugriffslimit auf die Datenbank wurde überschritten
    // 6 - no product name - es wurde kein Produktname angegeben
    // 7 - product name too long - der Produktname ist zu lang (max. 20 Zeichen)
    // 8 - no or wrong main category id - die Nummer für die Hauptkategorie fehlt oder liegt außerhalb des erlaubten Bereiches
    // 9 - no or wrong sub category id - die Nummer für die zugehörige Unterkategorie fehlt oder liegt außerhalb des erlaubten Bereiches
    // 10 - illegal data in vendor field - unerlaubte Daten im Herstellerfeld
    // 11 - illegal data in description field - unerlaubte Daten im Beschreibungsfeld
    // 12 - data already submitted - Daten wurden bereits übertragen
    // 13 - queryid missing or wrong - die UserID/queryid fehlt in der Abfrage oder ist für diese Funktion nicht freigeschaltet
    // 14 - unknown command - es wurde mit dem Parameter "cmd" ein unbekanntes Kommando übergeben

    //result = "error=0\n---\nasin=\nname=Spekulatius\ndetailname=netto spekulatius\nvendor=santa claus town\nmaincat=Süsswaren, Snacks\nsubcat=Bisquits, Kekse, Konfekt\nmaincatnum=20\nsubcatnum=0\ncontents=0\npack=0\norigin=Deutschland\ndescr=\nname_en=\ndetailname_en=\ndescr_en=\nvalidated=50 %\n---";
    String error = result.substring(7, 8);
    if (error == "0") {
      //offer.description = result;
      //print(result);
      //result.split('---');
      //decoded = result[1];
      LineSplitter ls = new LineSplitter();
      List lines = ls.convert(result);
      //List lines = result.split("\n");
      //print(lines[0]);
      //print(lines[1]);
      for (int i = 1; i < lines.length; i++) {
        List<String> newLine = lines[i].split("=");
        if (newLine.length > 1) {
          lines[i - 1] = newLine[1];
        } else {
          lines[i - 1] = "";
        }
      }
      //indizes
      //0=error
      //1=---
      //2=asin
      //3=name
      //4=detailname
      //5=verkäufer
      //6=kategorie
      //7=unterkategorie
      //8=kategorienummer
      //9="contents"
      //10="pack"
      //11=Herkunft
      //12=Beschreibung
      //13=name_en(oft leer)
      //14=detailname_en(oft leer)
      //15=validated (prozent)
      //16=---
      //print(lines);
      offer.title = lines[4];
      offer.description = lines[13];
    } else if (error == "1") {
      throw Exception('Artikel nicht gefunden');
    } else if (error == "2") {
      throw Exception('Fehler bei der Übertragung');
    } else if (error == "3") {
      throw Exception('Fehler beim Scannen des Codes');
    } else if (error == "5") {
      throw Exception('Limit überschritten');
    } else {
      throw Exception('API Fehler');
    }
    return offer;
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

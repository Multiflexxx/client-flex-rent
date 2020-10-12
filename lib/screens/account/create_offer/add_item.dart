import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rent/logic/models/category/category.dart';
import 'package:rent/logic/models/offer/offer.dart';
import 'package:rent/logic/services/services.dart';
import 'package:rent/screens/account/create_offer/add_images.dart';
import 'package:rent/widgets/formfieldstyled.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descritpionController = TextEditingController();
  final _priceController = TextEditingController();

  String barcodeResult = '';
  Category category;

  http.Response apiResult;
  Future<List<Category>> categoryList;

  @override
  void initState() {
    super.initState();
    categoryList = ApiOfferService().getAllCategory();
  }

  void _createOffer() {
    Offer offer = Offer(
      title: _titleController.text,
      description: _descritpionController.text,
      category: category,
      price: double.parse(_priceController.text),
    );

    Future<Offer> backendOffer = ApiOfferService().createOffer(newOffer: offer);
    pushNewScreen(
      context,
      screen: AddImages(
        offer: backendOffer,
      ),
      withNavBar: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ein Produkt einstellen'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(60.0),
                        child: Image(
                          width: 200,
                          height: 200,
                          image: AssetImage('assets/images/jett.jpg'),
                        ),
                      ),
                      Expanded(
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton.icon(
                            icon: Icon(Icons.search),
                            onPressed: () {},
                            label: Text('Search'),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton.icon(
                            icon: Icon(Icons.qr_code_scanner_outlined),
                            onPressed: () async {
                              barcodeResult =
                                  await FlutterBarcodeScanner.scanBarcode(
                                      '#FF5733',
                                      'Abbrechen',
                                      true,
                                      ScanMode.BARCODE);
                              String url =
                                  'http://opengtindb.org/?ean=$barcodeResult&cmd=query&queryid=400000000';
                              String differentUrl =
                                  'https://api.barcodelookup.com/v2/products?barcode=$barcodeResult&formatted=y&key=6y8fd1esob8wg7lq6wbt65bpx45tar';
                              if (barcodeResult != "-1") {
                                //-1 heißt der barcode scanner wurde abgebrochen
                                apiResult = await http.get(url);
                                //apiResult = new http.Response(" error=0\n---\nasin=\nname=Spekulatius\ndetailname=netto spekulatius\nvendor=santa claus town\nmaincat=Süsswaren, Snacks\nsubcat=Bisquits, Kekse, Konfekt\nmaincatnum=20\nsubcatnum=0\ncontents=0\npack=0\norigin=Deutschland\ndescr=\nname_en=\ndetailname_en=\ndescr_en=\nvalidated=50 %\n---", 400);
                                try {
                                  setState(() {
                                    Offer product = apiResponseToOffer(apiResult);
                                    _titleController.text = product.title;
                                    _descritpionController.text = product.description;
                                  });
                                } catch (e) {
                                  _showError(e);
                                  //error handling
                                }
                              }
                            },
                            label: Text('Scan'),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  FormFieldStyled(
                    controller: _titleController,
                    hintText: "Produktname",
                    autocorrect: true,
                  ),
                  SizedBox(height: 10.0),
                  FutureBuilder<List<Category>>(
                    future: categoryList,
                    builder: (context, categories) {
                      if (categories.hasData) {
                        return SizedBox(
                          width: double.infinity,
                          child: DropdownButton<Category>(
                            dropdownColor: Colors.black,
                            hint: Text(
                              'Kategorie',
                              style: TextStyle(color: Colors.white),
                            ),
                            items: categories.data
                                .map<DropdownMenuItem<Category>>(
                                    (Category category) {
                              return DropdownMenuItem<Category>(
                                value: category,
                                child: Text(
                                  category.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                category = value;
                              });
                            },
                            value: category,
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  SizedBox(height: 10.0),
                  FormFieldStyled(
                    controller: _descritpionController,
                    hintText: "Beschreibung",
                    autocorrect: true,
                    maxLines: 8,
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FormFieldStyled(
                          controller: _priceController,
                          hintText: "Preis",
                          autocorrect: true,
                          type: TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                          child: Text('€ Pro Tag',
                              style: TextStyle(color: Colors.white)),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(8.0)),
                      child: Text('Speichern'),
                      onPressed: () {
                        _createOffer();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
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
      //offer.category=lines[6]; Kategorie scheint objekt zu sein
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
    /*
    switch (error) {
      case "0":
        {
          offer.description = result;
          //result.split('---');
          //decoded = result[1];
          LineSplitter ls = new LineSplitter();
          List<String> lines = ls.convert(result);
        }
        break;
      case '1':
        {
          throw Exception('Artikel nicht gefunden');
        }
        break;
      case '2':
        {
          throw Exception('Fehler bei der Übertragung');
        }
        break;
      case '3':
        {
          throw Exception('Fehler beim Scannen des Codes');
        }
        break;
    }*/
    return offer;
  }

  void _showError(Exception e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(
            "Fehler",
            style: TextStyle(color: Colors.black),
          ),
          content: new Text(
            e.toString(),
            style: TextStyle(color: Colors.black),
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

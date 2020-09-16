import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String barcodeResult = '';
  http.Response apiResult;
  String product = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          barcodeResult = await FlutterBarcodeScanner.scanBarcode('#FF5733', 'Abbrechen', true, ScanMode.BARCODE);
          String url = 'http://opengtindb.org/?ean=$barcodeResult&cmd=query&queryid=400000000';
          String differentUrl = 'https://api.barcodelookup.com/v2/products?barcode=$barcodeResult&formatted=y&key=6y8fd1esob8wg7lq6wbt65bpx45tar';
          apiResult = await http.get(url);
          setState((){
            barcodeResult= barcodeResult;
            print(barcodeResult);
            product = apiResult.body;
          });
        },
        child: Text('Scan'),

      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(barcodeResult, style: TextStyle(color: Colors.white),),
            Text(product, style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }

  String decodeApiResponse(http.Response apiResult){
    String result = apiResult.body;
    String decoded = '';
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

    String error = result.substring(7,9);
    print(error);
    switch (error) {
      case '0':{
        decoded = result;
        //result.split('---');
        //decoded = result[1];
        LineSplitter ls = new LineSplitter();
        List<String> lines = ls.convert(result);

      } break;
      case '1':{ decoded = 'Artikel nicht gefunden'; } break;
      case '2':{ decoded = 'Fehler bei der Übertragung'; } break;

    }
    return decoded;

  }
}

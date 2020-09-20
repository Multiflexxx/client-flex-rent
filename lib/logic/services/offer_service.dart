import 'dart:convert';
import 'dart:developer';

import 'package:rent/logic/models/offer/offer.dart';

import 'package:http/http.dart' as http;

abstract class OfferService {
  Future<List<Offer>> getAllOffers();
  Future<Offer> getOfferById();
}

class ApiOfferService extends OfferService {
  @override
  Future<List<Offer>> getAllOffers(
      {int limit, int category, String search}) async {
    String url = 'https://flexrent.multiflexxx.de/offer/all?';

    if (limit != null) {
      url += 'limit=$limit&';
    }

    if (category != null) {
      url += 'category=$category&';
    }

    if (search != null) {
      url += 'search=$search&';
    }

    final response = await http.get(url);

    final List<dynamic> jsonBody = json.decode(response.body);
    inspect(jsonBody);
    return null;
  }

  @override
  Future<Offer> getOfferById() async {
    final response = await http.get('https://flexrent.multiflexxx.de/offer/1 ');

    final Map<String, dynamic> jsonBody = json.decode(response.body);
    inspect(jsonBody);
    return null;
  }
}

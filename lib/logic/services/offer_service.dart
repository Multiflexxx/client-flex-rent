import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:rent/logic/models/models.dart';

abstract class OfferService {
  Future<List<Offer>> getAllOffers();
  Future<Offer> getOfferById();
  Future<Map<String, List<Offer>>> getDiscoveryOffer();
  Future<List<Category>> getAllCategory();
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

    if (response.statusCode == 200) {
      final List<dynamic> jsonBody = json.decode(response.body);
      final List<Offer> offerList =
          (jsonBody).map((i) => Offer.fromJson(i)).toList();

      inspect(offerList);
      return offerList;
    } else {
      inspect(response);
      return null;
    }
  }

  @override
  Future<Offer> getOfferById() async {
    final response = await http.get('https://flexrent.multiflexxx.de/offer/1');

    final Map<String, dynamic> jsonBody = json.decode(response.body);
    return Offer.fromJson(jsonBody);
  }

  @override
  Future<Map<String, List<Offer>>> getDiscoveryOffer() async {
    final response = await http.get('https://flexrent.multiflexxx.de/offer/');

    final jsonBody = json.decode(response.body);

    Map<String, List<Offer>> discoveryOffer = Map<String, List<Offer>>();

    discoveryOffer.putIfAbsent(
      'bestOffer',
      () => (jsonBody['best_offers'] as List)
          .map((i) => Offer.fromJson(i))
          .toList(),
    );

    discoveryOffer.putIfAbsent(
      'bestLessors',
      () => (jsonBody['best_lessors'] as List)
          .map((i) => Offer.fromJson(i))
          .toList(),
    );

    discoveryOffer.putIfAbsent(
      'latestOffers',
      () => (jsonBody['latest_offers'] as List)
          .map((i) => Offer.fromJson(i))
          .toList(),
    );

    inspect(discoveryOffer);

    return discoveryOffer;
  }

  @override
  Future<List<Category>> getAllCategory() async {
    final response =
        await http.get('https://flexrent.multiflexxx.de/offer/categories');

    if (response.statusCode == 200) {
      final List<dynamic> jsonBody = json.decode(response.body);
      final List<Category> categoryList =
          (jsonBody).map((i) => Category.fromJson(i)).toList();
      inspect(categoryList);
      return categoryList;
    } else {
      inspect(response);
      return null;
    }
  }
}

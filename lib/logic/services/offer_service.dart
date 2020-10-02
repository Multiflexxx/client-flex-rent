import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rent/logic/models/models.dart';

import '../exceptions/exceptions.dart';

abstract class OfferService {
  Future<List<Offer>> getAllOffers();
  Future<Offer> getOfferById();
  Future<Map<String, List<Offer>>> getDiscoveryOffer();
  Future<List<Category>> getAllCategory();
  Future<Offer> createOffer();
  List<String> getSuggestion();
  void setSuggestion();
}

class ApiOfferService extends OfferService {
  final _storage = FlutterSecureStorage();

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

      if (jsonBody.isNotEmpty) {
        final List<Offer> offerList =
            (jsonBody).map((i) => Offer.fromJson(i)).toList();
        return offerList;
      } else {
        return Future.error(
            OfferException(message: 'Die Suche ergab keine Ergebnisse'));
      }
    } else {
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
      return categoryList;
    } else {
      return null;
    }
  }

  @override
  Future<Offer> createOffer({Offer newOffer}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);

    final response = await http.put('https://flexrent.multiflexxx.de/offer/',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          'session': session.toJson(),
          'offer': newOffer.toJson()
        }));

    if (response.statusCode == 200) {
      final dynamic jsonBody = json.decode(response.body);
      final Offer offer = Offer.fromJson(jsonBody);
      return offer;
    } else {
      return null;
    }
  }

  @override
  List<String> getSuggestion() {
    var suggestions = _storage.read(key: 'suggestions');
    final _suggestedList = [
      'Test',
      'Title',
      'Teufel',
    ];
    return _suggestedList;
  }

  @override
  void setSuggestion({String query}) {
    var suggestions = _storage.read(key: 'suggestions');
    // _storage.write(key: 'suggestions', value: null);
  }
}

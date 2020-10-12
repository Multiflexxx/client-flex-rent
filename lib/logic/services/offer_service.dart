import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
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
  Future<List<Offer>> getOfferbyUser();
  void addImage();
  List<String> getSuggestion();
  void setSuggestion();
  Future<OfferRequest> bookOffer();
  Future<List<OfferRequest>> getAllOfferRequestsbyStatusCode();
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
  Future<Offer> getOfferById({String offerId}) async {
    final response =
        await http.get('https://flexrent.multiflexxx.de/offer/$offerId');

    final Map<String, dynamic> jsonBody = json.decode(response.body);
    Offer offer = Offer.fromJson(jsonBody);
    return offer;
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
  Future<List<Offer>> getOfferbyUser() async {
    final String userId = await _storage.read(key: 'userId');

    final response = await http
        .get('https://flexrent.multiflexxx.de/offer/user-offers/$userId');

    if (response.statusCode == 200) {
      final List<dynamic> jsonBody = json.decode(response.body);

      if (jsonBody.isNotEmpty) {
        inspect(jsonBody);
        final List<Offer> offerList =
            (jsonBody).map((i) => Offer.fromJson(i)).toList();
        return offerList;
      } else {
        return Future.error(
            OfferException(message: 'Fange jetzt an zu Vermieten!'));
      }
    }
    return Future.error(
        OfferException(message: 'Fange jetzt an zu Vermieten!'));
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
  Future<Offer> addImage({Offer offer, String imagePath}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    var multipartFile = await http.MultipartFile.fromPath('images', imagePath,
        filename: imagePath);

    var uri = Uri.parse('https://flexrent.multiflexxx.de/offer/images');
    var request = http.MultipartRequest('POST', uri)
      ..fields['session_id'] = sessionId
      ..fields['offer_id'] = offer.offerId
      ..fields['user_id'] = userId
      ..files.add(multipartFile);

    http.Response response =
        await http.Response.fromStream(await request.send());

    if (response.statusCode == 201) {
      final dynamic jsonBody = json.decode(response.body);
      final Offer offer = Offer.fromJson(jsonBody);
      return offer;
    } else {
      print(response.statusCode);
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

  @override
  Future<OfferRequest> bookOffer({String offerId, DateRange dateRange}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);

    final response = await http.post(
        'https://flexrent.multiflexxx.de/offer/$offerId',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          'session': session.toJson(),
          'message': '',
          'date_range': dateRange.toJson()
        }));

    if (response.statusCode == 201) {
      final dynamic jsonBody = json.decode(response.body);
      OfferRequest offerRequest = OfferRequest.fromJson(jsonBody);

      inspect(offerRequest);
    } else {
      inspect(response);
    }
  }

  @override
  Future<List<OfferRequest>> getAllOfferRequestsbyStatusCode(
      {int statusCode, OfferRequest offerRequest}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);

    final response = await http.post(
      'https://flexrent.multiflexxx.de/offer/user-requests',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'session': session.toJson(),
        'status_code': statusCode,
      }),
    );

    if (response.statusCode == 201) {
      final List<dynamic> jsonBody = json.decode(response.body);
      inspect(jsonBody);

      if (jsonBody.isNotEmpty) {
        final List<OfferRequest> offerRequestList =
            (jsonBody).map((i) => OfferRequest.fromJson(i)).toList();
        return offerRequestList;
      }
    } else {
      return Future.error(OfferException(message: 'Fange jetzt an zu mieten!'));
    }
  }
}

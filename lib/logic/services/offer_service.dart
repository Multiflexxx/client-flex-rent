import 'dart:convert';
import 'dart:developer';
import 'package:flexrent/logic/config/config.dart';
import 'package:meta/meta.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flexrent/logic/models/models.dart';

import '../exceptions/exceptions.dart';

abstract class OfferService {
  Future<List<Offer>> getAllOffers();
  Future<Offer> getOfferById();
  Future<Map<String, List<Offer>>> getDiscoveryOffer();
  Future<List<Offer>> getAllDiscoveryOffers();
  Future<List<Category>> getAllCategory();
  Future<Offer> createOffer();
  Future<Offer> updateOffer();
  Future<List<Offer>> getOfferbyUser();
  void addImage();
  Future<List<dynamic>> getSuggestion();
  void setSuggestion();
  void deleteSuggestion();
  Future<OfferRequest> bookOffer();
  Future<List<OfferRequest>> getAllOfferRequestsbyStatusCode();
  Future<OfferRequest> getOfferRequestbyRequest();
  Future<OfferRequest> updateOfferRequest();
  Future<Offer> deleteOffer();
}

class ApiOfferService extends OfferService {
  final _storage = FlutterSecureStorage();

  @override
  Future<List<Offer>> getAllOffers({
    @required String postCode,
    int distance,
    int limit,
    int category,
    String search,
  }) async {
    String url = '${CONFIG.url}/offer/all?post_code=$postCode&';

    if (distance != null) {
      url += 'distance=$distance&';
    }

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
    final response = await http.get('${CONFIG.url}/offer/$offerId');

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      Offer offer = Offer.fromJson(jsonBody);
      return offer;
    } else {
      throw OfferException(message: 'Der Gegenstand ist nicht verfügbar');
    }
  }

  @override
  Future<Map<String, List<Offer>>> getDiscoveryOffer({String postCode}) async {
    final response = await http.get('${CONFIG.url}/offer/?post_code=$postCode');

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
  Future<List<Offer>> getAllDiscoveryOffers({
    @required String postCode,
    @required String discoveryTitle,
  }) async {
    final response = await http.get('${CONFIG.url}/offer/?post_code=$postCode');
    List<dynamic> jsonBody;
    if (response.statusCode == 200) {
      if (discoveryTitle == 'Neuste') {
        jsonBody = json.decode(response.body)['latest_offers'];
      } else if (discoveryTitle == 'Topseller') {
        jsonBody = json.decode(response.body)['best_offers'];
      } else if (discoveryTitle == 'Beste Vermieter') {
        jsonBody = json.decode(response.body)['best_lessors'];
      }
      if (jsonBody.isNotEmpty) {
        final List<Offer> offerList =
            (jsonBody).map((i) => Offer.fromJson(i)).toList();
        return offerList;
      } else {
        return Future.error(
            OfferException(message: 'Gerade sind keine Angebote verfügbar!'));
      }
    }
    return Future.error(
        OfferException(message: 'Gerade sind keine Angebote verfügbar!'));
  }

  @override
  Future<List<Offer>> getOfferbyUser() async {
    final String userId = await _storage.read(key: 'userId');

    final response = await http.get('${CONFIG.url}/offer/user-offers/$userId');

    if (response.statusCode == 200) {
      final List<dynamic> jsonBody = json.decode(response.body);

      if (jsonBody.isNotEmpty) {
        final List<Offer> offerList =
            (jsonBody).map((i) => Offer.fromJson(i)).toList();
        return offerList;
      } else {
        return Future.error(
            OfferException(message: 'Fange jetzt an zu vermieten!'));
      }
    }
    return Future.error(
        OfferException(message: 'Fange jetzt an zu vermieten!'));
  }

  @override
  Future<List<Category>> getAllCategory() async {
    final response = await http.get('${CONFIG.url}/offer/categories');

    if (response.statusCode == 200) {
      final List<dynamic> jsonBody = json.decode(response.body);
      final List<Category> categoryList =
          (jsonBody).map((i) => Category.fromJson(i)).toList();
      return categoryList;
    } else {
      throw OfferException(
          message: 'Derzeit können keine Kategorien geladen werden.');
    }
  }

  @override
  Future<Offer> createOffer({Offer newOffer}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);

    final response = await http.put('${CONFIG.url}/offer/',
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
      throw OfferException(
          message: 'Dein Produkt konnte nicht angelgt werden.');
    }
  }

  @override
  Future<Offer> updateOffer({Offer updateOffer, List<String> images}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);

    final response =
        await http.patch('${CONFIG.url}/offer/${updateOffer.offerId}',
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(<String, dynamic>{
              'session': session.toJson(),
              'offer': updateOffer.toJson(),
              'delete_images': images,
            }));

    if (response.statusCode == 200) {
      final dynamic jsonBody = json.decode(response.body);
      final Offer offer = Offer.fromJson(jsonBody);
      return offer;
    } else {
      throw OfferException(
          message: 'Dein Produkt konnte nicht geupdated werden.');
    }
  }

  @override
  Future<Offer> addImage({Offer offer, String imagePath}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    var multipartFile = await http.MultipartFile.fromPath('images', imagePath,
        filename: imagePath);

    var uri = Uri.parse('${CONFIG.url}/offer/images');
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
  Future<List<dynamic>> getSuggestion() async {
    var suggestions = await _storage.read(key: 'suggestions');
    List<dynamic> _suggestionsList = List<String>();
    if (suggestions != null) {
      _suggestionsList = jsonDecode(suggestions);
    } else {
      _suggestionsList = [
        'Box',
        'Taschenrechner',
        'Controller',
      ];
    }
    return _suggestionsList;
  }

  @override
  void setSuggestion({String query}) async {
    var suggestions = await _storage.read(key: 'suggestions');
    List<dynamic> _suggestionsList = List<dynamic>();
    if (suggestions == null) {
      _suggestionsList.add(query);
    } else {
      _suggestionsList = jsonDecode(suggestions);
      if (!_suggestionsList.contains(query)) {
        if (_suggestionsList.length == 5) {
          _suggestionsList.removeAt(0);
        }
        _suggestionsList.add(query);
      }
    }
    _storage.write(key: 'suggestions', value: jsonEncode(_suggestionsList));
  }

  @override
  void deleteSuggestion() {
    _storage.deleteAll();
  }

  @override
  Future<OfferRequest> bookOffer({String offerId, DateRange dateRange}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);

    final response = await http.post('${CONFIG.url}/offer/$offerId',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(<String, dynamic>{
          'session': session.toJson(),
          'message': '',
          'date_range': dateRange.toJson()
        }));

    if (response.statusCode == 201) {
      final dynamic jsonBody = json.decode(response.body);
      OfferRequest offerRequest = OfferRequest.fromJson(jsonBody);
      return offerRequest;
    } else {
      return null;
    }
  }

  @override
  Future<List<OfferRequest>> getAllOfferRequestsbyStatusCode(
      {int statusCode, bool lessor}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);

    final response = await http.post(
      '${CONFIG.url}/offer/user-requests',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'session': session.toJson(),
        'status_code': statusCode,
        'lessor': lessor,
      }),
    );

    if (response.statusCode == 201) {
      final List<dynamic> jsonBody = json.decode(response.body);

      if (jsonBody.isNotEmpty) {
        final List<OfferRequest> offerRequestList =
            (jsonBody).map((i) => OfferRequest.fromJson(i)).toList();
        return offerRequestList;
      } else {
        String text = 'Fange jetzt an zu ';
        text += lessor ? 'vermieten!' : 'mieten!';
        return Future.error(
          OfferException(message: text),
        );
      }
    } else {
      return Future.error(
        OfferException(
            message:
                'Hier ist etwas schief gelaufen. Versuche es später nocheinmal.'),
      );
    }
  }

  @override
  Future<OfferRequest> getOfferRequestbyRequest(
      {OfferRequest offerRequest}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);

    final response = await http.post(
      '${CONFIG.url}/offer/user-requests',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'session': session.toJson(),
        'request': offerRequest.toJson(),
      }),
    );

    if (response.statusCode == 201) {
      final dynamic jsonBody = json.decode(response.body);
      final OfferRequest offerRequest = OfferRequest.fromJson(jsonBody);
      return offerRequest;
    }
    return null;
  }

  @override
  Future<OfferRequest> updateOfferRequest({OfferRequest offerRequest}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);

    final response = await http.post(
      '${CONFIG.url}/offer/handle-requests',
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'session': session.toJson(),
        'request': offerRequest.toJson(),
      }),
    );

    if (response.statusCode == 201) {
      final dynamic jsonBody = json.decode(response.body);
      final OfferRequest offerRequest = OfferRequest.fromJson(jsonBody);
      return offerRequest;
    } else {
      inspect(response);
    }
    return null;
  }

  @override
  Future<Offer> deleteOffer({Offer offer}) async {
    final String sessionId = await _storage.read(key: 'sessionId');
    final String userId = await _storage.read(key: 'userId');

    Session session = Session(sessionId: sessionId, userId: userId);

    final response =
        await http.patch('${CONFIG.url}/offer/delete-offer/${offer.offerId}',
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(<String, dynamic>{
              'session': session.toJson(),
            }));

    if (response.statusCode == 200) {
      final dynamic jsonBody = json.decode(response.body);
      final Offer offer = Offer.fromJson(jsonBody);
      return offer;
    } else {
      throw OfferException(
          message: 'Dein Produkt konnte nicht gelöscht werden.');
    }
  }
}

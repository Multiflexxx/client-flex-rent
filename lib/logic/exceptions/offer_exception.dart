class OfferException implements Exception {
  final String message;

  OfferException({this.message = 'Unknown error occurred.'});
}

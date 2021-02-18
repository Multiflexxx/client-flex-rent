class RatingException implements Exception {
  final String message;

  RatingException({this.message = 'Unknown error occurred.'});
}

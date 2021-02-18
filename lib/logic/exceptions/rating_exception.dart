abstract class RatingException implements Exception {
  final String message;

  RatingException({this.message = 'Unknown error occurred.'});
}

class UserRatingException extends RatingException {
  UserRatingException({message}) : super(message: message);
}

class OfferRatingException extends RatingException {}

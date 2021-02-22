class UserException implements Exception {
  final String message;

  UserException({this.message = 'Unknown error occurred.'});
}

class RegisterException implements Exception {
  final String message;

  RegisterException({this.message = 'Unknown error occurred.'});
}

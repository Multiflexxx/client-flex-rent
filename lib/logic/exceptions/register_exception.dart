class RegisterException implements Exception {
  final int statusCode;
  final String message;

  RegisterException(
      {this.message = 'Unknown error occurred.', this.statusCode = 0});
}

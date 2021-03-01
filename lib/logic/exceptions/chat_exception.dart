class ChatException implements Exception {
  final String message;

  ChatException({this.message = 'Unknown error occurred.'});
}

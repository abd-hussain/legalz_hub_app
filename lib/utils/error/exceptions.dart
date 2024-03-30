class HttpException implements Exception {
  final String message;
  final int status;
  final String requestId;

  HttpException(
      {required this.status, required this.message, required this.requestId});
}

class ConnectionException implements Exception {
  final String message;
  ConnectionException({required this.message});
}

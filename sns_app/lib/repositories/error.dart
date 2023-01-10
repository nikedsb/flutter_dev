class ErrorResponseException implements Exception {
  const ErrorResponseException({
    required String message,
    required this.code,
    required this.body,
  });

  final int code;
  final String body;

  @override
  String toString() {
    return 'ErrorResponseException: code=$code, body=$body';
  }
}

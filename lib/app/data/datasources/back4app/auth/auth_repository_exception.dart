class AuthRepositoryException implements Exception {
  final String code;
  final String message;
  AuthRepositoryException({
    required this.code,
    required this.message,
  });
}

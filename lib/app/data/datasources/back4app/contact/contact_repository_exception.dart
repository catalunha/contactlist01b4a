class ContactRepositoryException implements Exception {
  final String message;
  ContactRepositoryException({
    required this.message,
  });
}

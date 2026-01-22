/// Base exception class for the application
abstract class AppException implements Exception {
  final String message;
  final dynamic originalError;

  AppException(this.message, {this.originalError});

  @override
  String toString() => '$runtimeType: $message ${originalError ?? ''}';
}

/// Custom exception for secure storage operations
class SecureStorageException extends AppException {
  SecureStorageException(super.message, {super.originalError});
}

/// Custom exception for network operations
class NetworkException extends AppException {
  NetworkException(super.message, {super.originalError});
}

/// Custom exception for cache operations
class CacheException extends AppException {
  CacheException(super.message, {super.originalError});
}

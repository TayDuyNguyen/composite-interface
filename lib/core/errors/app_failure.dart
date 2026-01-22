/// Base failure class for error handling
/// Provides a common interface for all error types
abstract class Failure {
  const Failure({
    required this.message,
    this.code,
    this.details,
    this.stackTrace,
  });

  /// Error message
  final String message;

  /// Error code
  final String? code;

  /// Error details
  final dynamic details;

  /// Error stack trace
  final StackTrace? stackTrace;

  @override
  String toString() =>
      'Failure: $message${code != null ? ' (Code: $code)' : ''}';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure && other.message == message && other.code == code;
  }

  @override
  int get hashCode => message.hashCode ^ code.hashCode;
}

/// Application-specific failure class
/// Extends the base Failure class for app-specific error handling
class AppFailure extends Failure {
  const AppFailure({
    required super.message,
    super.code,
    super.details,
    super.stackTrace,
  });

  // Default messages registry
  static const Map<String, String> _defaultMessages = {
    'NETWORK_ERROR':
        'Network connection error. Please check your internet connection.',
    'SERVER_ERROR': 'Server error occurred. Please try again later.',
    'AUTH_ERROR': 'Authentication failed. Please check your credentials.',
    'VALIDATION_ERROR': 'Validation error. Please check your input.',
    'CACHE_ERROR': 'Cache error occurred. Please try again.',
    'FILE_SYSTEM_ERROR': 'File system error occurred. Please try again.',
    'PERMISSION_ERROR': 'Permission denied. Please check your permissions.',
    'TIMEOUT_ERROR': 'Request timeout. Please try again.',
    'BUSINESS_ERROR': 'Business logic error. Please try again.',
    'DATABASE_ERROR': 'Database error occurred. Please try again.',
    'CONFIGURATION_ERROR': 'Configuration error. Please contact support.',
    'SECURITY_ERROR': 'Security error occurred. Please try again.',
    'RATE_LIMIT_ERROR': 'Too many requests. Please try again later.',
    'MAINTENANCE_ERROR':
        'System maintenance in progress. Please try again later.',
    'FEATURE_NOT_AVAILABLE_ERROR':
        'Feature not available. Please try again later.',
    'INSUFFICIENT_PERMISSIONS_ERROR':
        'Insufficient permissions. Please contact support.',
    'RESOURCE_NOT_FOUND_ERROR': 'Resource not found. Please try again.',
    'CONFLICT_ERROR': 'Conflict error. Please try again.',
    'UNPROCESSABLE_ENTITY_ERROR':
        'Unprocessable entity. Please check your input.',
    'TOO_MANY_REQUESTS_ERROR': 'Too many requests. Please try again later.',
    'INTERNAL_SERVER_ERROR': 'Internal server error. Please try again later.',
    'BAD_GATEWAY_ERROR': 'Bad gateway error. Please try again later.',
    'SERVICE_UNAVAILABLE_ERROR': 'Service unavailable. Please try again later.',
    'GATEWAY_TIMEOUT_ERROR': 'Gateway timeout. Please try again later.',
  };

  // --- Factories ---

  factory AppFailure.fromFailure(Failure failure) => AppFailure(
        message: failure.message,
        code: failure.code,
        details: failure.details,
        stackTrace: failure.stackTrace,
      );

  factory AppFailure.fromException(Exception exception,
          {StackTrace? stackTrace}) =>
      AppFailure(
          message: exception.toString(),
          code: 'EXCEPTION',
          details: exception,
          stackTrace: stackTrace);

  factory AppFailure.fromError(Object error, {StackTrace? stackTrace}) =>
      AppFailure(
          message: error.toString(),
          code: 'ERROR',
          details: error,
          stackTrace: stackTrace);

  // Common semantic factories
  factory AppFailure.network(String message, {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'NETWORK_ERROR', details: details);

  factory AppFailure.server(String message, {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'SERVER_ERROR', details: details);

  factory AppFailure.auth(String message, {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'AUTH_ERROR', details: details);

  factory AppFailure.validation(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'VALIDATION_ERROR', details: details);

  factory AppFailure.cache(String message, {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'CACHE_ERROR', details: details);

  factory AppFailure.security(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'SECURITY_ERROR', details: details);

  factory AppFailure.insufficientPermissions(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message,
          code: code ?? 'INSUFFICIENT_PERMISSIONS_ERROR',
          details: details);

  factory AppFailure.resourceNotFound(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message,
          code: code ?? 'RESOURCE_NOT_FOUND_ERROR',
          details: details);

  factory AppFailure.rateLimit(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'RATE_LIMIT_ERROR', details: details);

  factory AppFailure.timeout(String message, {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'TIMEOUT_ERROR', details: details);

  factory AppFailure.database(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'DATABASE_ERROR', details: details);

  factory AppFailure.internalServerError(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message,
          code: code ?? 'INTERNAL_SERVER_ERROR',
          details: details);

  factory AppFailure.badGateway(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message,
          code: code ?? 'BAD_GATEWAY_ERROR',
          details: details);

  factory AppFailure.serviceUnavailable(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message,
          code: code ?? 'SERVICE_UNAVAILABLE_ERROR',
          details: details);

  factory AppFailure.gatewayTimeout(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message,
          code: code ?? 'GATEWAY_TIMEOUT_ERROR',
          details: details);

  factory AppFailure.business(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'BUSINESS_ERROR', details: details);

  factory AppFailure.conflict(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message, code: code ?? 'CONFLICT_ERROR', details: details);

  factory AppFailure.unprocessableEntity(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message,
          code: code ?? 'UNPROCESSABLE_ENTITY_ERROR',
          details: details);

  factory AppFailure.tooManyRequests(String message,
          {String? code, dynamic details}) =>
      AppFailure(
          message: message,
          code: code ?? 'TOO_MANY_REQUESTS_ERROR',
          details: details);

  // Generic factory for other types
  factory AppFailure.byCode(String code, {String? message, dynamic details}) =>
      AppFailure(
          message: message ?? _defaultMessages[code] ?? 'An error occurred',
          code: code,
          details: details);

  // --- Getters ---

  bool get isNetworkError => code == 'NETWORK_ERROR';
  bool get isServerError => code == 'SERVER_ERROR';
  bool get isAuthError => code == 'AUTH_ERROR';
  bool get isValidationError => code == 'VALIDATION_ERROR';

  /// Get user-friendly error message
  String get userFriendlyMessage => _defaultMessages[code] ?? message;

  @override
  String toString() =>
      'AppFailure: $message${code != null ? ' (Code: $code)' : ''}';
}

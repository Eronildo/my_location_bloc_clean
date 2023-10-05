/// [HttpException], throw when some server error happens.
class HttpException implements Exception {
  /// Create a Http Exception.
  HttpException({
    this.statusCode,
    this.message,
    this.stackTrace,
  });

  /// Exception StatusCode.
  final int? statusCode;

  /// Exception Message.
  final String? message;

  /// Stack Trace of [Exception].
  final StackTrace? stackTrace;
}

///
class ServerException implements Exception {}

///
class NetworkException implements Exception {}

/// Location base exception.
sealed class LocationException implements Exception {}

/// [LocationUnavailableException]
///
/// Throws when location service is not available.
class LocationUnavailableException extends LocationException {}

/// [LocationDeniedException]
///
/// Throws when user denies location permission.
class LocationDeniedException extends LocationException {}

/// [LocationDeniedForeverException]
///
/// Throws when user denies location permission multiple times.
class LocationDeniedForeverException extends LocationException {}

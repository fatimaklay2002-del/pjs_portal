class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, [this.code]);

  @override
  String toString() => message;
}

class ServerException extends AppException {
  ServerException([super.message = 'Server error occurred', super.code]);
}

class NetworkException extends AppException {
  NetworkException([super.message = 'Network connection failed', super.code]);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([super.message = 'Unauthorized access', super.code]);
}

class NotFoundException extends AppException {
  NotFoundException([super.message = 'Resource not found', super.code]);
}

class CacheException extends AppException {
  CacheException([super.message = 'Cache error occurred', super.code]);
}

class ValidationException extends AppException {
  ValidationException([super.message = 'Validation error', super.code]);
}

class FileUploadException extends AppException {
  FileUploadException([super.message = 'File upload failed', super.code]);
}

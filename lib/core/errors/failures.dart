import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

// Server Failures
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network connection failed']);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([super.message = 'Unauthorized access']);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Resource not found']);
}

// Cache Failures
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

// Validation Failures
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation error']);
}

// Authentication Failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure([super.message = 'Authentication failed']);
}

// File Upload Failures
class FileUploadFailure extends Failure {
  const FileUploadFailure([super.message = 'File upload failed']);
}

// General Failures
class GeneralFailure extends Failure {
  const GeneralFailure([super.message = 'An error occurred']);
}

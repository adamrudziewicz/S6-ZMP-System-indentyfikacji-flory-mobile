abstract class AuthException implements Exception {
  final String? message;
  const AuthException([this.message]);
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException([String? message]) : super(message);
}

class EmailNotVerifiedException extends AuthException {
  const EmailNotVerifiedException([String? message]) : super(message);
}

class InvalidRequestException extends AuthException {
  const InvalidRequestException([String? message]) : super(message);
}

class UserConflictException extends AuthException {
  const UserConflictException([String? message]) : super(message);
}

class UnknownAuthException extends AuthException {
  const UnknownAuthException([String? message]) : super(message);
}

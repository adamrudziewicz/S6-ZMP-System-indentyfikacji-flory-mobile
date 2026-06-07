import '../../l10n/app_localizations.dart';

abstract class AppException implements Exception {
  final String? serverMessage;

  AppException([this.serverMessage]);

  String getLocalizedMessage(AppLocalizations l10n);

  @override
  String toString() => serverMessage ?? 'AppException';
}

class SessionExpiredException extends AppException {
  SessionExpiredException([super.serverMessage]);
  
  @override
  String getLocalizedMessage(AppLocalizations l10n) => l10n.errorSessionExpired;
}

class ForbiddenException extends AppException {
  ForbiddenException([super.serverMessage]);
  
  @override
  String getLocalizedMessage(AppLocalizations l10n) => serverMessage ?? l10n.errorAccessDenied;
}

class NotFoundException extends AppException {
  NotFoundException([super.serverMessage]);
  
  @override
  String getLocalizedMessage(AppLocalizations l10n) => l10n.errorNotFound;
}

class ConflictException extends AppException {
  ConflictException([super.serverMessage]);
  
  @override
  String getLocalizedMessage(AppLocalizations l10n) => serverMessage ?? l10n.errorConflict;
}

class NetworkException extends AppException {
  NetworkException([super.serverMessage]);
  
  @override
  String getLocalizedMessage(AppLocalizations l10n) => l10n.errorConnection;
}

class UnknownException extends AppException {
  UnknownException([super.serverMessage]);
  
  @override
  String getLocalizedMessage(AppLocalizations l10n) => l10n.errorUnexpected;
}

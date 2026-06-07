import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';
import '../../../../l10n/app_localizations.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User? user;

  const AuthAuthenticated({this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthCredentialsLoaded extends AuthState {
  final String login;
  final String password;
  final bool rememberMe;
  final bool isBiometryAvailable;

  const AuthCredentialsLoaded({
    required this.login,
    required this.password,
    required this.rememberMe,
    required this.isBiometryAvailable,
  });

  @override
  List<Object?> get props => [login, password, rememberMe, isBiometryAvailable];
}

// Errors
abstract class AuthError extends AuthState {
  const AuthError();
}

class AuthErrorInvalidCredentials extends AuthError {}
class AuthErrorEmailNotVerified extends AuthError {}
class AuthErrorInvalidRequest extends AuthError {}
class AuthErrorUserConflict extends AuthError {}
class AuthErrorUnknown extends AuthError {}

// Successes
abstract class AuthActionSuccess extends AuthState {
  const AuthActionSuccess();
}

class AuthForgotPasswordSuccess extends AuthActionSuccess {}
class AuthResendVerificationSuccess extends AuthActionSuccess {}
class AuthRegisterSuccess extends AuthActionSuccess {}

extension AuthErrorLocalization on AuthError {
  String getLocalizedMessage(AppLocalizations l10n) {
    if (this is AuthErrorInvalidCredentials) return l10n.loginInvalidCredentialsError;
    if (this is AuthErrorEmailNotVerified) return l10n.emailNotVerifiedError;
    if (this is AuthErrorInvalidRequest) return l10n.loginInvalidRequestError;
    if (this is AuthErrorUserConflict) return l10n.registerConflictError;
    return l10n.loginErrorMessage;
  }
}

extension AuthSuccessLocalization on AuthActionSuccess {
  String getLocalizedMessage(AppLocalizations l10n) {
    if (this is AuthForgotPasswordSuccess) return l10n.forgotPasswordSuccessMessage;
    if (this is AuthResendVerificationSuccess) return l10n.resendVerificationSuccessMessage;
    if (this is AuthRegisterSuccess) return l10n.registerSuccessMessage;
    return '';
  }
}

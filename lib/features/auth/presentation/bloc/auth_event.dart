import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class AuthLoginRequested extends AuthEvent {
  final String login;
  final String password;
  final bool rememberMe;

  const AuthLoginRequested(this.login, this.password, {this.rememberMe = false});

  @override
  List<Object> get props => [login, password, rememberMe];
}

class AuthRegisterRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;

  const AuthRegisterRequested(this.username, this.email, this.password);

  @override
  List<Object> get props => [username, email, password];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;

  const AuthForgotPasswordRequested(this.email);

  @override
  List<Object> get props => [email];
}

class AuthResendVerificationEmailRequested extends AuthEvent {
  final String email;

  const AuthResendVerificationEmailRequested(this.email);

  @override
  List<Object> get props => [email];
}

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

  const AuthLoginRequested(this.login, this.password);

  @override
  List<Object> get props => [login, password];
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

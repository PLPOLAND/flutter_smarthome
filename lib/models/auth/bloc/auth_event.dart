import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class LoggedOut extends AuthEvent {}

class LogginIn extends AuthEvent {
  final String email;
  final String password;

  const LogginIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LogginIn { email: $email, password: $password }';
}

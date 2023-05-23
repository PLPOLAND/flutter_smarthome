part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {}

class LogOut extends AuthEvent {}

class LogIn extends AuthEvent {
  final String email;
  final String password;

  const LogIn({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LogginIn { email: $email, password: $password }';
}

class LogInDemo extends AuthEvent {}

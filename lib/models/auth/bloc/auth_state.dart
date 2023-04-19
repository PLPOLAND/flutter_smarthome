import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smarthome/models/auth/user_data.dart';

enum AuthStatus { initial, authenticated, unauthenticated, error, loading }

extension AuthStatusExtension on AuthStatus {
  bool get isUnknown => this == AuthStatus.initial;
  bool get isAuthenticated => this == AuthStatus.authenticated;
  bool get isUnauthenticated => this == AuthStatus.unauthenticated;
  bool get isError => this == AuthStatus.error;
  bool get isLoading => this == AuthStatus.loading;
}

class AuthState extends Equatable {
  final AuthStatus status;
  final UserData userData;

  const AuthState._({
    this.status = AuthStatus.initial,
    this.userData = const UserData.nullData(),
  });

  const AuthState.initial() : this._();

  const AuthState.authenticated() : this._(status: AuthStatus.authenticated);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  const AuthState.error(String message) : this._(status: AuthStatus.error);

  const AuthState.loading() : this._(status: AuthStatus.loading);

  @override
  List<Object> get props => [status, userData];

  @override
  String toString() => 'AuthState { status: $status, userData: $userData }';

  AuthState copyWith({
    AuthStatus? status,
    UserData? userData,
  }) {
    return AuthState._(
      status: status ?? this.status,
      userData: userData ?? this.userData,
    );
  }
}

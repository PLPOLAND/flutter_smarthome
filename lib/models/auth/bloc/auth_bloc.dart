import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_smarthome/models/auth/bloc/auth_event.dart';
import 'package:flutter_smarthome/models/auth/bloc/auth_state.dart';
import 'package:flutter_smarthome/models/auth/user_data.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<AppStarted>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      var sharedPrefs = await SharedPreferences.getInstance();
      var userData = sharedPrefs.get('userData')
          as UserData?; // get user data from shared preferences
      if (userData != null) {
        // if user data is not null then user is authenticated
        emit(state.copyWith(
            status: AuthStatus.authenticated, userData: userData));
      } else {
        // if user data is null then user is unauthenticated
        emit(state.copyWith(status: AuthStatus.authenticated));
      }
    });

    on<LoggedIn>((event, emit) {
      emit(state.copyWith(status: AuthStatus.authenticated));
    });

    on<LoggedOut>((event, emit) async {
      emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          userData: const UserData.nullData()));
    });

    on<LogginIn>((event, emit) async {
      emit(const AuthState.loading());
      //TODO: implement login logic
    });
  }
}

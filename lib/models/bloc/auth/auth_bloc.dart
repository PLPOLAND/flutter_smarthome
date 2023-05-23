import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_smarthome/models/auth/user_data.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState.initial()) {
    on<AppStarted>((event, emit) async {
      print('AppStarted event');
      emit(state.copyWith(status: AuthStatus.loading));
      var sharedPrefs = await SharedPreferences.getInstance();
      // get user data from shared preferences
      var userDataJSON = sharedPrefs.getString('userData');

      // get server ip from shared preferences
      var ip = sharedPrefs.getString('serverIp');
      if (ip != null) {
        RESTClient().setIP(ip);
      } else {
        // if server ip is not set, then log out
        sharedPrefs.remove('userData');
        emit(state.copyWith(
            status: AuthStatus.unauthenticated,
            userData: const UserData.nullData()));
      }

      if (userDataJSON != null) {
        // if user data is not null then user is authenticated
        var userData = UserData.fromJson(jsonDecode(userDataJSON));

        //check if token is still valid
        try {
          await RESTClient().getUserData(token: userData.token);
        } on Exception catch (e) {
          log("error: ", error: e);
          // if token is not valid then log out
          sharedPrefs.remove('userData');
          emit(state.copyWith(
              status: AuthStatus.unauthenticated,
              userData: const UserData.nullData()));
          return;
        }
        //user is authenticated
        emit(state.copyWith(
            status: AuthStatus.authenticated, userData: userData));
      } else {
        // if user data is null then user is unauthenticated
        emit(state.copyWith(status: AuthStatus.unauthenticated));
      }
    });

    // on<LogIn>((event, emit) {
    //   emit(state.copyWith(status: AuthStatus.authenticated));
    // });

    on<LogOut>((event, emit) async {
      print('LogOut event');
      var sharedPrefs = await SharedPreferences.getInstance();
      sharedPrefs.remove('userData');
      emit(state.copyWith(
          status: AuthStatus.unauthenticated,
          userData: const UserData.nullData()));
    });

    on<LogIn>((event, emit) async {
      print('LogIn event');
      emit(state.copyWith(status: AuthStatus.loading));
      try {
        String token = await RESTClient()
            .logIn(nick: event.email, password: event.password);
        UserData userData = await RESTClient().getUserData(token: token);
        print(userData);
        var sharedPrefs = await SharedPreferences.getInstance();
        sharedPrefs.setString("userData", userData.toJson());
        emit(state.copyWith(
            status: AuthStatus.authenticated, userData: userData));
        sharedPrefs.setString("serverIp", RESTClient().getIP());
      } catch (e) {
        print(e); // TODO: handle exception
      }
      //TODO: implement login logic
    });
    on<LogInDemo>(
      (event, emit) {
        print('LogInDemo event');
        UserData userData =
            UserData("demo", "demo", "demo@demo.pl", "demoToken", null);
        emit(state.copyWith(status: AuthStatus.demo, userData: userData));
      },
    );
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    log(change.toString());
  }
}

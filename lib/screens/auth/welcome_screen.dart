import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/bloc/auth/auth_bloc.dart';
import 'package:flutter_smarthome/models/bloc/devices/devices_bloc.dart';
import 'package:flutter_smarthome/models/bloc/rooms/rooms_bloc.dart';
import 'package:flutter_smarthome/screens/auth/login_screen.dart';
import 'package:flutter_smarthome/screens/home/homepage_screen.dart';

import '../../models/bloc/sensors/sensors_bloc.dart' as sensors;

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/auth';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.read<AuthBloc>().state.status.isAuthenticated) {
      return HomepageScreen();
    } else {
      return BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) async {
          log('WelcomeScreen: $state');
          if (state.status.isAuthenticated) {
            context.read<DevicesBloc>().add(LoadDevices());
            context.read<sensors.SensorsBloc>().add(sensors.LoadSensors());
            context.read<RoomsBloc>().add(LoadRooms());
          }
          if (state.status.isAuthenticated || state.status.isDemo) {
            Navigator.of(context)
                .pushReplacementNamed(HomepageScreen.routeName);
          }
        },
        builder: (context, state) {
          if (state.status.isUnauthenticated) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            alignment: Alignment.center,
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                            child: const Text('SmartHome icon'),
                          )),
                      const SizedBox(height: 10),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Welcome!',
                                style:
                                    Theme.of(context).textTheme.headlineLarge),
                            const SizedBox(height: 10),
                            const Text('Please login or open demo mode!'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(LoginScreen.routeName);
                                    },
                                    child: const Text('Login'),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<DevicesBloc>().add(LoadDemo());
                                context
                                    .read<sensors.SensorsBloc>()
                                    .add(sensors.LoadDemoSensors());
                                context.read<RoomsBloc>().add(LoadDemoRooms());
                                context.read<AuthBloc>().add(LogInDemo());

                                Navigator.of(context).pushNamed(
                                  HomepageScreen.routeName,
                                );
                              },
                              child: const Text('Demo mode'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state.status.isDemo) {
            return HomepageScreen();
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
    }
  }
}

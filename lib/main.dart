import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/bloc/devices/devices_bloc.dart';
import 'package:provider/provider.dart';

import 'helpers/rest_client/rest_client.dart';
import 'models/bloc/auth/auth_bloc.dart';
import 'repositories/device_repository.dart';
import 'providers/room_provider.dart';
import 'providers/sensors_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/devices/add_edit_device_screen.dart';
import 'screens/devices_screen.dart';
import 'screens/homepage_screen.dart';
import 'screens/room_detail_page.dart';
import 'screens/rooms/add_edit_room_screen.dart';
import 'screens/rooms_page.dart';
import 'screens/sensors/add_edit_sensor_screen.dart';
import 'screens/sensors_screen.dart';
import 'screens/settings_screen.dart';
import 'themes/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (BuildContext context) {
            return RESTClient();
          },
        ),
        RepositoryProvider(
          create: (BuildContext context) {
            return DevicesRepository();
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (context) => AuthBloc()..add(AppStarted())),
          BlocProvider(
              create: (context) =>
                  DevicesBloc(context.read<DevicesRepository>())),
        ],
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ThemesMenager()),
            ChangeNotifierProvider(create: (context) => SensorsProvider()),
            ChangeNotifierProvider(create: (context) => RoomsProvider()),
          ],
          builder: (context, child) {
            return BlocListener<AuthBloc, AuthState>(
                listener: (context, state) {
              if (state.status.isUnauthenticated) {
                context.read<DevicesBloc>().add(StopUpdating());
              }
            }, child: DynamicColorBuilder(builder: (lightDynamic, darkDynamic) {
              Provider.of<ThemesMenager>(context, listen: false)
                  .addDynamic(lightDynamic, darkDynamic);
              return MaterialApp(
                title: 'Smarthome',
                theme: ThemeData(
                  useMaterial3: true,
                  colorScheme: Provider.of<ThemesMenager>(context)
                      .getColorScheme(systemAutoBrightness: true),
                ),
                home: const WelcomeScreen(),
                routes: {
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  HomepageScreen.routeName: (context) => const HomepageScreen(),
                  RoomDetailScreen.routeName: (context) =>
                      const RoomDetailScreen(),
                  RoomsPage.routeName: (context) => const RoomsPage(),
                  SettingsScreen.routeName: (context) => SettingsScreen(),
                  DevicesScreen.routeName: (context) => const DevicesScreen(),
                  Sensors.routeName: (context) => const Sensors(),
                  AddEditRoomScreen.routeName: (context) => AddEditRoomScreen(),
                  AddEditDeviceScreen.routeName: (context) =>
                      const AddEditDeviceScreen(),
                  AddEditSensorScreen.routeName: (context) =>
                      const AddEditSensorScreen(),
                },
              );
            }));
          },
        ),
      ),
    );
  }
}

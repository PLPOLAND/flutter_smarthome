import 'package:flutter/material.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:flutter_smarthome/screens/devices_screen.dart';
import 'package:flutter_smarthome/screens/homepage_screen.dart';
import 'package:flutter_smarthome/screens/room_detail_page.dart';
import 'package:flutter_smarthome/screens/rooms/add_edit_room_screen.dart';
import 'package:flutter_smarthome/screens/rooms_page.dart';
import 'package:flutter_smarthome/screens/sensors/add_edit_sensor_screen.dart';
import 'package:flutter_smarthome/screens/sensors_screen.dart';
import 'package:flutter_smarthome/screens/settings_screen.dart';
import 'package:flutter_smarthome/themes/themes.dart';
import 'package:provider/provider.dart';

import 'providers/room_provider.dart';
import 'providers/sensors_provider.dart';
import 'screens/devices/add_edit_device_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemesMenager();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DevicesProvider()),
        ChangeNotifierProvider(create: (context) => SensorsProvider()),
        ChangeNotifierProvider(create: (context) => RoomsProvider()),
      ],
      child: MaterialApp(
        title: 'Smarthome',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ThemesMenager.getColorScheme(systemAutoBrightness: true),

          // const ColorScheme(
          //   brightness: Brightness.light,
          //   primary: Colors.pink,
          //   onPrimary: Colors.white,
          //   primaryContainer: Color.fromARGB(255, 228, 145, 172),
          //   secondary: Color.fromARGB(255, 250, 186, 134),
          //   onSecondary: Colors.black,
          //   secondaryContainer: Color.fromARGB(255, 250, 186, 134),
          //   background: Color(0xFFFFF5F5),
          //   onBackground: Colors.black,
          //   error: Colors.red,
          //   onError: Colors.white,
          //   surface: Color(0xFFFFF5F5),
          //   onSurface: Colors.black,
          // ),
        ),
        home: const HomepageScreen(),
        routes: {
          HomepageScreen.routeName: (context) => const HomepageScreen(),
          RoomDetailScreen.routeName: (context) => const RoomDetailScreen(),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:flutter_smarthome/screens/devices_screen.dart';
import 'package:flutter_smarthome/screens/homepage_screen.dart';
import 'package:flutter_smarthome/screens/room_detail_page.dart';
import 'package:flutter_smarthome/screens/rooms/add_edit_room_screen.dart';
import 'package:flutter_smarthome/screens/rooms_page.dart';
import 'package:flutter_smarthome/screens/sensors_screen.dart';
import 'package:flutter_smarthome/screens/settings_screen.dart';
import 'package:provider/provider.dart';

import 'providers/room_provider.dart';
import 'providers/sensors_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DevicesProvider()),
        ChangeNotifierProvider(create: (context) => SensorsProvider()),
        ChangeNotifierProvider(create: (context) => RoomsProvider()),
      ],
      child: MaterialApp(
        title: 'Smarthome',
        theme: ThemeData(
          primarySwatch: Colors.pink,
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
        },
      ),
    );
  }
}

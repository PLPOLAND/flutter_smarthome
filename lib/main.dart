import 'package:flutter/material.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:flutter_smarthome/screens/homepage_screen.dart';
import 'package:flutter_smarthome/screens/room_detail_page.dart';
import 'package:flutter_smarthome/screens/rooms_page.dart';
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
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomepageScreen(),
        routes: {
          HomepageScreen.routeName: (context) => HomepageScreen(),
          RoomDetailScreen.routeName: (context) => RoomDetailScreen(),
          RoomsPage.routeName: (context) => RoomsPage(),
        },
      ),
    );
  }
}

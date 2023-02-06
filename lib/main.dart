import 'package:flutter/material.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:flutter_smarthome/screens/homepage_screen.dart';
import 'package:provider/provider.dart';

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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        routes: {
          '/': (context) => HomepageScreen(),
          HomepageScreen.routeName: (context) => HomepageScreen(),
        },
      ),
    );
  }
}

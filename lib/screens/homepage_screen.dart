import 'package:flutter/material.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:flutter_smarthome/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../models/devices/blind.dart';
import '../models/devices/device.dart';
import '../models/devices/fan.dart';
import '../models/devices/light.dart';
import '../models/devices/outlet.dart';
import '../models/sensors/sensor.dart';
import '../providers/sensors_provider.dart';
import '../widgets/deviceWidget.dart';
import '../widgets/sensorWidget.dart';

class HomepageScreen extends StatelessWidget {
  static const routeName = '/homepage';

  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homepage'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text("Homepage"),
        ),
      ),
      drawer: const MainDrawer(),
    );
  }
}

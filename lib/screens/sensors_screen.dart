import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/sensors_provider.dart';
import '../widgets/devicesListItemWidget.dart';
import '../widgets/main_drawer.dart';
import '../widgets/sensorsListItemWidget.dart';

class Sensors extends StatelessWidget {
  static const routeName = '/sensors';
  const Sensors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors'),
      ),
      drawer: const MainDrawer(),
      body: Consumer<SensorsProvider>(
        builder: (context, data, _) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: data.sensors[index],
                  child: const SensorsListItemWidget());
            },
            itemCount: data.sensors.length,
          );
        },
      ),
    );
  }
}

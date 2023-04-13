import 'package:flutter/material.dart';
import 'package:flutter_smarthome/screens/sensors/add_edit_sensor_screen.dart';
import 'package:provider/provider.dart';

import '../providers/sensors_provider.dart';
import '../widgets/devicesListItemWidget.dart';
import '../widgets/main_drawer.dart';
import '../widgets/sensors_list_item_widget.dart';

class Sensors extends StatelessWidget {
  static const routeName = '/sensors';
  const Sensors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditSensorScreen.routeName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEditSensorScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
      drawer: const MainDrawer(),
      body: Consumer<SensorsProvider>(
        builder: (context, data, _) {
          return data.sensors.isEmpty
              ? const Center(
                  child: Text(
                    "There is no sensors yet. \nAdd some!",
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    if (index == data.sensors.length) {
                      return const SizedBox(
                        height: 80,
                      );
                    }
                    return ChangeNotifierProvider.value(
                      value: data.sensors[index],
                      child: const SensorsListItemWidget(),
                    );
                  },
                  itemCount: data.sensors.length + 1,
                );
        },
      ),
    );
  }
}

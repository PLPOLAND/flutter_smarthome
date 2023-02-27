import 'package:flutter/material.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:flutter_smarthome/widgets/devicesListItemWidget.dart';
import 'package:flutter_smarthome/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

class DevicesScreen extends StatelessWidget {
  static const routeName = '/devices';
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices'),
      ),
      drawer: const MainDrawer(),
      body: Consumer<DevicesProvider>(
        builder: (context, data, _) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: data.devices[index],
                  child: const DevicesListItemWidget());
            },
            itemCount: data.devices.length,
          );
        },
      ),
    );
  }
}

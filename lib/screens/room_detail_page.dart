import 'package:flutter/material.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:provider/provider.dart';

import '../models/devices/blind.dart';
import '../models/devices/device.dart';
import '../models/devices/fan.dart';
import '../models/devices/light.dart';
import '../models/devices/outlet.dart';
import '../models/room.dart';
import '../models/sensors/sensor.dart';
import '../providers/sensors_provider.dart';
import '../widgets/deviceWidget.dart';
import '../widgets/sensorWidget.dart';

class RoomDetailScreen extends StatelessWidget {
  static const routeName = '/roomDetails';

  const RoomDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Room room = ModalRoute.of(context)!.settings.arguments as Room;
    List<Device> devices =
        Provider.of<DevicesProvider>(context).getDevicesByRoomId(room.id);
    List<Sensor> sensors =
        Provider.of<SensorsProvider>(context).getSensorsByRoomId(room.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(room.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              itemBuilder: (ctx, index) {
                if (index < devices.length) {
                  if (devices[index] is Light) {
                    return ChangeNotifierProvider.value(
                        value: devices[index], child: const DeviceWidget());
                  } else if (devices[index] is Blind) {
                    return ChangeNotifierProvider.value(
                        value: devices[index], child: const DeviceWidget());
                  } else if (devices[index] is Outlet) {
                    return ChangeNotifierProvider.value(
                        value: devices[index], child: const DeviceWidget());
                  } else if (devices[index] is Fan) {
                    return ChangeNotifierProvider.value(
                        value: devices[index], child: const DeviceWidget());
                  }
                } else if (index < devices.length + sensors.length) {
                  return ChangeNotifierProvider.value(
                      value: sensors[index - devices.length],
                      child: const SensorWidget());
                } else {
                  return Card(
                    color: Theme.of(context).colorScheme.error,
                    child: Text(
                      "Unknow Device Type",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onError),
                    ),
                  );
                }
              },
              itemCount: devices.length + sensors.length,
            ),
          ),
        ],
      ),
    );
  }
}

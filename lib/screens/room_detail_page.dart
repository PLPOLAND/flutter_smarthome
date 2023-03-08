import 'package:flutter/material.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:flutter_smarthome/providers/room_provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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

class RoomDetailScreen extends StatefulWidget {
  static const routeName = '/roomDetails';

  const RoomDetailScreen({super.key});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
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
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/rooms/add-edit-room', arguments: room.id);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              Provider.of<RoomsProvider>(context, listen: false)
                  .removeRoomById(room.id);
              //TODO ask for confirmation
              Navigator.of(context).pop();
            },
          ),
          IconButton(
            icon: room.isFavorite ? Icon(Icons.star) : Icon(Icons.star_outline),
            onPressed: () {
              setState(() {
                room.toggleFavorite();
              });
            },
          ),
        ],
      ),
      body: devices.isEmpty && sensors.isEmpty
          ? const Center(
              child: Text("No sensors and devices there. Add some!"),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    itemBuilder: (ctx, index) {
                      if (index < devices.length) {
                        if (devices[index] is Light) {
                          return ChangeNotifierProvider.value(
                              value: devices[index],
                              child: const DeviceWidget());
                        } else if (devices[index] is Blind) {
                          return ChangeNotifierProvider.value(
                              value: devices[index],
                              child: const DeviceWidget());
                        } else if (devices[index] is Outlet) {
                          return ChangeNotifierProvider.value(
                              value: devices[index],
                              child: const DeviceWidget());
                        } else if (devices[index] is Fan) {
                          return ChangeNotifierProvider.value(
                              value: devices[index],
                              child: const DeviceWidget());
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
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        children: [
          SpeedDialChild(
            child: Icon(Icons.storage),
            // label: "Device",
            onTap: () {
              Navigator.of(context).pushNamed('/devices/add-edit-device',
                  arguments: {'roomId': room.id});
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.sensors),
            // label: "Sensor",
            onTap: () {
              Navigator.of(context).pushNamed('/sensors/add-edit-sensor',
                  arguments: {'roomId': room.id});
            },
          ),
        ],
      ),
      // FloatingActionButton(
      //   tooltip: 'Add ...',
      //   onPressed: () {},
      //   child: ,
      // ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:flutter_smarthome/providers/room_provider.dart';
import 'package:flutter_smarthome/widgets/homeScreen/room_card.dart';
import 'package:flutter_smarthome/widgets/main_drawer.dart';
import 'package:provider/provider.dart';

import '../models/devices/blind.dart';
import '../models/devices/device.dart';
import '../models/devices/fan.dart';
import '../models/devices/light.dart';
import '../models/devices/outlet.dart';
import '../models/sensors/sensor.dart';
import '../providers/sensors_provider.dart';
import '../widgets/device_widget.dart';
import '../widgets/sensor_widget.dart';

class HomepageScreen extends StatelessWidget {
  static const routeName = '/homepage';

  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = Provider.of<RoomsProvider>(context).rooms;
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              final room =
                  rooms.where((element) => element.isFavorite).toList()[index];
              return ChangeNotifierProvider.value(
                  value: room, child: const RoomCard());
            },
            itemCount:
                rooms.where((element) => element.isFavorite).toList().length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ),
      drawer: const MainDrawer(),
    );
  }
}

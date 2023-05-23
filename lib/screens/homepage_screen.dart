import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/bloc/auth/auth_bloc.dart';
import 'package:flutter_smarthome/repositories/device_repository.dart';
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
    final favRooms = rooms.where((element) => element.isFavorite).toList();
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Witaj ${context.read<AuthBloc>().state.userData.showName}!"),
      ),
      body: favRooms.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "You didn't add any room to favorite list! \n Navigate to rooms list and click some stars!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20)),
              ),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final room = favRooms[index];
                    return ChangeNotifierProvider.value(
                        value: room, child: const RoomCard());
                  },
                  itemCount: rooms
                      .where((element) => element.isFavorite)
                      .toList()
                      .length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ),
      drawer: const MainDrawer(),
    );
  }
}

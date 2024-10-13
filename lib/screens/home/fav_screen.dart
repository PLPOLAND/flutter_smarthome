import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/bloc/devices/devices_bloc.dart';
import 'package:flutter_smarthome/models/bloc/rooms/rooms_bloc.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/models/room.dart';
import 'package:flutter_smarthome/widgets/homeScreen/room_card.dart';
import 'package:flutter_smarthome/widgets/homeScreen/room_card2.dart';

class FavScreen extends StatelessWidget {
  // static const routeName = '/fav';
  const FavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var favRooms = <Room>[];
    return BlocBuilder<RoomsBloc, RoomsState>(builder: (context, rooms) {
      return BlocBuilder<DevicesBloc, DevicesState>(
        builder: (context, devices) {
          if (rooms.status == RoomsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          Map<Room, List<Device>> favRoomsMap = {};
          for (var device in devices.devices) {
            if (device.isFav) {
              var room = rooms.rooms
                  .firstWhere((element) => element.id == device.roomId);
              if (favRoomsMap.containsKey(room)) {
                favRoomsMap[room]!.add(device);
              } else {
                favRoomsMap[room] = [device];
              }
            }
          }

          return favRoomsMap.isEmpty
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
                        final room = favRoomsMap.keys.elementAt(index);
                        return BlocBuilder<Room, RoomCubitState>(
                          bloc: room,
                          builder: (context, state) {
                            return RoomCard2(
                                room: room, devices: favRoomsMap[room]!);
                          },
                        );
                      },
                      itemCount: favRoomsMap.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                );
        },
      );
    });
  }
}

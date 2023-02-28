import 'package:flutter/material.dart';
import 'package:flutter_smarthome/widgets/main_drawer.dart';
import '../models/room.dart';
import '../providers/room_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/roomWidget.dart';

class RoomsPage extends StatelessWidget {
  static const routeName = '/rooms';

  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Room> rooms = Provider.of<RoomsProvider>(context).rooms;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/rooms/add-room');
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
        itemCount: rooms.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: rooms[index],
            child: RoomWidget(),
          );
        },
      ),
      drawer: const MainDrawer(),
    );
  }
}

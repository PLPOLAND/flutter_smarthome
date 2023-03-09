import 'package:flutter/material.dart';
import 'package:flutter_smarthome/widgets/main_drawer.dart';
import '../models/room.dart';
import '../providers/room_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/room_widget.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: rooms.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 2
                  : 3,
          childAspectRatio: 2 / 1,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ChangeNotifierProvider.value(
            value: rooms[index],
            child: const RoomWidget(),
          );
        },
      ),
      drawer: const MainDrawer(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/bloc/rooms/rooms_bloc.dart';
import 'package:flutter_smarthome/repositories/rooms_repository.dart';
import 'package:flutter_smarthome/widgets/main_drawer.dart';
import '../models/room.dart';

import '../widgets/room_widget.dart';

class RoomsPage extends StatelessWidget {
  static const routeName = '/rooms';

  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Room> rooms = context.read<RoomsRepository>().rooms;

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
      body: BlocBuilder<RoomsBloc, RoomsState>(
          bloc: context.read<RoomsBloc>(),
          builder: (context, state) {
            if (state.status.isLoaded || state.status.isDemo) {
              return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  return BlocBuilder(
                    bloc: rooms[index],
                    builder: (context, state) {
                      return RoomWidget(room: rooms[index]);
                    },
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
      drawer: const MainDrawer(),
    );
  }
}

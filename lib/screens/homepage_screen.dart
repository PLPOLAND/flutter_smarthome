import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/bloc/auth/auth_bloc.dart';
import 'package:flutter_smarthome/models/bloc/rooms/rooms_bloc.dart';
import 'package:flutter_smarthome/models/room.dart';
import 'package:flutter_smarthome/widgets/homeScreen/room_card.dart';
import 'package:flutter_smarthome/widgets/main_drawer.dart';

import '../repositories/rooms_repository.dart';

class HomepageScreen extends StatelessWidget {
  static const routeName = '/homepage';

  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var favRooms = <Room>[];
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Witaj ${context.read<AuthBloc>().state.userData.showName}!"),
      ),
      body: BlocBuilder<RoomsBloc, RoomsState>(
        builder: (context, state) {
          if (state.status == RoomsStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          favRooms =
              state.rooms.where((element) => element.isFavorite).toList();
          return favRooms.isEmpty
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
                        return BlocBuilder<Room, RoomCubitState>(
                          bloc: room,
                          builder: (context, state) {
                            return RoomCard(room: room);
                          },
                        );
                        // return ChangeNotifierProvider.value(
                        //     value: room, child: const RoomCard());
                      },
                      itemCount: favRooms.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                  ),
                );
        },
      ),
      drawer: const MainDrawer(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/bloc/auth/auth_bloc.dart';
import 'package:flutter_smarthome/models/bloc/rooms/rooms_bloc.dart';
import 'package:flutter_smarthome/models/room.dart';
import 'package:flutter_smarthome/screens/automations/add_edit_automation_screent.dart';
import 'package:flutter_smarthome/screens/devices/add_edit_device_screen.dart';
import 'package:flutter_smarthome/screens/devices_screen.dart';
import 'package:flutter_smarthome/screens/home/automations_screen.dart';
import 'package:flutter_smarthome/screens/home/fav_screen.dart';
import 'package:flutter_smarthome/screens/rooms/add_edit_room_screen.dart';
import 'package:flutter_smarthome/screens/rooms_page.dart';
import 'package:flutter_smarthome/screens/sensors/add_edit_sensor_screen.dart';
import 'package:flutter_smarthome/screens/sensors_screen.dart';
import 'package:flutter_smarthome/widgets/homeScreen/room_card.dart';
import 'package:flutter_smarthome/widgets/main_drawer.dart';

import '../../repositories/rooms_repository.dart';

class HomepageScreen extends StatefulWidget {
  static const routeName = '/homepage';
  HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  List<Widget> pages = [
    FavScreen(),
    RoomsPage(),
    DevicesScreen(),
    Sensors(),
    AutomationsScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Witaj ${context.read<AuthBloc>().state.userData.showName}!"),
      ),
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: "Ulubione"),
          NavigationDestination(
              icon: Icon(Icons.room_preferences_outlined),
              selectedIcon: Icon(Icons.room_preferences),
              label: "Pokoje"),
          NavigationDestination(
              icon: Icon(Icons.storage_outlined),
              selectedIcon: Icon(Icons.storage),
              label: "Urządzenia"),
          NavigationDestination(
              icon: Icon(Icons.sensors_outlined),
              selectedIcon: Icon(Icons.sensors),
              label: "Sensors"),
          NavigationDestination(
              icon: Icon(Icons.precision_manufacturing_outlined),
              selectedIcon: Icon(Icons.precision_manufacturing),
              label: "Automatyzacje"),
        ],
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
      floatingActionButton: currentIndex == 1 &&
              context.read<AuthBloc>().state.userData.nickName == "PLPOLAND"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddEditRoomScreen.routeName);
              },
              child: const Icon(Icons.add),
            )
          : currentIndex == 2 &&
                  context.read<AuthBloc>().state.userData.nickName == "PLPOLAND"
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(AddEditDeviceScreen.routeName);
                  },
                  child: const Icon(Icons.add),
                )
              : currentIndex == 3 &&
                      context.read<AuthBloc>().state.userData.nickName ==
                          "PLPOLAND"
                  ? FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(AddEditSensorScreen.routeName);
                      },
                      child: const Icon(Icons.add),
                    )
                  : currentIndex == 4 &&
                          context.read<AuthBloc>().state.userData.nickName ==
                              "PLPOLAND"
                      ? FloatingActionButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AddEditAutomationScreen.routeName);
                          },
                          child: const Icon(Icons.add),
                        )
                      : null,
      drawer: const MainDrawer(),
    );
  }
}

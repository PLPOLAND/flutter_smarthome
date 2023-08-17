import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/bloc/auth/auth_bloc.dart';
import 'package:flutter_smarthome/models/bloc/rooms/rooms_bloc.dart';
import 'package:flutter_smarthome/models/room.dart';
import 'package:flutter_smarthome/screens/home/automations_screen.dart';
import 'package:flutter_smarthome/screens/home/fav_screen.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Ulubione"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Automatyzacje"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      drawer: const MainDrawer(),
    );
  }
}

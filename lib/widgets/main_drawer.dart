import 'package:flutter/material.dart';
import 'package:flutter_smarthome/screens/rooms_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Menu'),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Homepage'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          ListTile(
            leading: const Icon(Icons.room_preferences),
            title: const Text('Rooms'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(RoomsPage.routeName),
          ),
          ListTile(
            leading: const Icon(Icons.storage),
            title: const Text('Devices'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/devices'),
          ),
          ListTile(
            leading: const Icon(Icons.sensors),
            title: const Text('Sensors'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/sensors'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed('/settings'),
          ),
        ],
      ),
    ));
  }
}

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
            leading: Icon(Icons.home),
            title: Text('Homepage'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          ListTile(
            leading: Icon(Icons.room_preferences),
            title: Text('Rooms'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(RoomsPage.routeName),
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Devices'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/devices'),
          ),
          ListTile(
            leading: Icon(Icons.sensors),
            title: Text('Sensors'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/sensors'),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () =>
                Navigator.of(context).pushReplacementNamed('/settings'),
          ),
        ],
      ),
    ));
  }
}

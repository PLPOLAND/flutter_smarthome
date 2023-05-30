import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/bloc/devices/devices_bloc.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/widgets/devicesListItemWidget.dart';
import 'package:flutter_smarthome/widgets/main_drawer.dart';

class DevicesScreen extends StatelessWidget {
  static const routeName = '/devices';
  const DevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed('/devices/add-edit-device');
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('/devices/add-edit-device');
        },
        child: const Icon(Icons.add),
      ),
      drawer: const MainDrawer(),
      body: BlocConsumer<DevicesBloc, DevicesState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          return ListView.builder(
            itemBuilder: (context, index) {
              if (index == state.devices.length) {
                return const SizedBox(
                  height: 80,
                );
              }
              return BlocBuilder<Device, DeviceCubitState>(
                  bloc: state.devices[index],
                  builder: (context, locState) =>
                      DevicesListItemWidget(state.devices[index]));
            },
            itemCount: state.devices.length + 1,
          );
        },
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/bloc/sensors/sensors_bloc.dart';
import 'package:flutter_smarthome/models/sensors/sensor.dart';
import 'package:flutter_smarthome/screens/sensors/add_edit_sensor_screen.dart';

import '../widgets/main_drawer.dart';
import '../widgets/sensors_list_item_widget.dart';

class Sensors extends StatelessWidget {
  static const routeName = '/sensors';
  const Sensors({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddEditSensorScreen.routeName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddEditSensorScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
      drawer: const MainDrawer(),
      body: BlocBuilder<SensorsBloc, SensorsState>(
        builder: (context, state) {
          log("building sensors screen");
          log(state.toString());
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.sensors.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                if (index == state.sensors.length) {
                  return const SizedBox(
                    height: 80,
                  );
                }
                Sensor sensor = state.sensors[index];
                return BlocBuilder<Sensor, SensorCubitState>(
                  bloc: sensor,
                  builder: (context, state) {
                    return SensorsListItemWidget(
                      sensor: sensor,
                    );
                  },
                );
              },
              itemCount: state.sensors.length + 1,
            );
          } else {
            return const Center(
              child: Text(
                "There is no sensors yet. \nAdd some!",
                textAlign: TextAlign.center,
              ),
            );
          }
        },
        // builder: (context, data, _) {
        //   return data.sensors.isEmpty
        //       ? const Center(
        //           child: Text(
        //             "There is no sensors yet. \nAdd some!",
        //             textAlign: TextAlign.center,
        //           ),
        //         )
        //       : ListView.builder(
        //           itemBuilder: (context, index) {
        //             if (index == data.sensors.length) {
        //               return const SizedBox(
        //                 height: 80,
        //               );
        //             }
        //             return ChangeNotifierProvider.value(
        //               value: data.sensors[index],
        //               child: const SensorsListItemWidget(),
        //             );
        //           },
        //           itemCount: data.sensors.length + 1,
        //         );
        // },
      ),
    );
  }
}

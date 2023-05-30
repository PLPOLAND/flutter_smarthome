import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/models/sensors/sensor.dart';
import 'package:flutter_smarthome/widgets/homeScreen/blind_widget.dart';
import 'package:flutter_smarthome/widgets/homeScreen/light_widget_container.dart';
import 'package:flutter_smarthome/widgets/homeScreen/outlet_widget.dart';
import 'package:provider/provider.dart';

import '../../models/devices/blind.dart';
import '../../models/devices/fan.dart';
import '../../models/devices/light.dart';
import '../../models/devices/outlet.dart';
import '../../models/room.dart';
import '../../repositories/device_repository.dart';
import '../../repositories/sensors_repository.dart';
import 'sensor_widget.dart';
import 'fan_widget.dart';

class RoomCard extends StatelessWidget {
  final Room room;
  const RoomCard({required this.room, super.key});

  @override
  Widget build(BuildContext context) {
    final sensors =
        context.read<SensorsRepository>().getSensorsByRoomId(room.id);
    final devices = context
        .read<DevicesRepository>()
        .devices
        .where((device) => device.roomId == room.id)
        .toList();

    final bool anyThermometer =
        sensors.any((sensor) => sensor.type == SensorType.thermometer);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  room.name,
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (anyThermometer) ...{
                      ...sensors.map((e) {
                        if (e.type == SensorType.thermometer ||
                            e.type == SensorType.hygrometer) {
                          return BlocBuilder<Sensor, SensorCubitState>(
                              builder: (context, state) {
                                return SensorWidget(
                                  sensor: e,
                                );
                              },
                              bloc: e);
                        }
                        return const SizedBox(width: 0, height: 0);
                      }),
                    },
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          if (devices.isEmpty) const Center(child: Text('No devices')),
          if (devices.any((device) => device.type == DeviceType.light))
            LightWidgetContainer(
              lights: devices
                  .where((device) => device.type == DeviceType.light)
                  .map((e) => e as Light)
                  .toList(),
            ),
          const SizedBox(height: 10),
          ...devices
              .where((device) => device.state.type == DeviceType.blind)
              .map(
                (e) => BlocBuilder(
                    builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          BlindWidget(
                            blind: e as Blind,
                          ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                    bloc: e),
              ),
          ...devices
              .where((device) => device.type == DeviceType.outlet)
              .map((e) => BlocBuilder(
                      bloc: e,
                      builder: (context, state) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            OutletWidget(
                              outlet: e as Outlet,
                            ),
                            const SizedBox(height: 10),
                          ],
                        );
                      })
                  // ChangeNotifierProvider.value(
                  //   value: e,
                  //   child: Column(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       OutletWidget(
                  //         outlet: e as Outlet,
                  //       ),
                  //       const SizedBox(height: 10),
                  //     ],
                  //   ),
                  // ),
                  ),
          ...devices.where((device) => device.type == DeviceType.fan).map(
                (e) => BlocBuilder(
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FanWidget(
                          fan: e as Fan,
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                  bloc: e,
                ),
                // ChangeNotifierProvider.value(
                //   value: e,
                //   child: Column(
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       FanWidget(
                //         fan: e as Fan,
                //       ),
                //       const SizedBox(height: 10),
                //     ],
                //   ),
                // ),
              ),
        ],
      ),
    );
  }
}

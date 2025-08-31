import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/devices/blind.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/models/devices/light.dart';
import 'package:flutter_smarthome/models/sensors/sensor.dart';
import 'package:flutter_smarthome/screens/room_detail_page.dart';
import 'package:flutter_smarthome/widgets/homeScreen/blind_widget2.dart';
import 'package:flutter_smarthome/widgets/homeScreen/dual_state_device_widget.dart';
import 'package:flutter_smarthome/widgets/homeScreen/dual_state_multi_device_widget.dart';
import 'package:flutter_smarthome/widgets/homeScreen/sensor_widget2.dart';

import '../../models/room.dart';
import '../../repositories/sensors_repository.dart';
import 'sensor_widget.dart';

class RoomCard2 extends StatefulWidget {
  final Room room;
  final List<Device> devices;
  final List<Sensor> sensors;
  RoomCard2({
    required this.room,
    List<Device>? devices,
    super.key,
    List<Sensor>? sensors,
  })  : devices = devices ?? [],
        sensors = sensors ?? [];

  @override
  State<RoomCard2> createState() => _RoomCard2State();
}

class _RoomCard2State extends State<RoomCard2> {
  bool show = true;
  @override
  Widget build(BuildContext context) {
    final sensors =
        context.read<SensorsRepository>().getSensorsByRoomId(widget.room.id);
    final bool anyThermometer = sensors.any((sensor) =>
        sensor.type == SensorType.thermometer ||
        sensor.type == SensorType.hygrometer ||
        sensor.type == SensorType.hygroThermometer ||
        sensor.type == SensorType.twilight ||
        sensor.type == SensorType.hygrometer);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      // padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Theme.of(context).colorScheme.primaryContainer,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
            child: InkWell(
              onTap: () => setState(() {
                show = !show;
              }),
              onLongPress: () => Navigator.pushNamed(
                  context, RoomDetailScreen.routeName,
                  arguments: widget.room),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.room.name,
                    style: const TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (anyThermometer && !show) ...{
                        ...sensors.map((e) {
                          if (e.type == SensorType.thermometer ||
                              e.type == SensorType.hygrometer ||
                              e.type == SensorType.hygroThermometer) {
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
                      IconButton(
                        onPressed: () => setState(() {
                          show = !show;
                        }),
                        icon: !show
                            ? Icon(Icons.arrow_drop_down)
                            : Icon(Icons.arrow_drop_up),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // const SizedBox(height: 10),
          // if (widget.devices.isEmpty) const Center(child: Text('No devices')),
          // if (devices.any((device) =>
          //     device.type == DeviceType.light ||
          //     device.type == DeviceType.outlet ||
          //     device.type == DeviceType.fan))
          if (show)
            Wrap(
              children: [
                ...widget.sensors
                    .where((sensor) =>
                        sensor.type == SensorType.thermometer ||
                        sensor.type == SensorType.hygrometer)
                    .map(
                      (e) => BlocBuilder<Sensor, SensorCubitState>(
                        builder: (context, state) {
                          return e.isFavorite
                              ? SensorWidget2(
                                  sensor: e,
                                )
                              : Container();
                        },
                        bloc: e,
                      ),
                    ),
                _createFullLightWidget(widget.devices),
                ...widget.devices
                    .where((device) => device.type == DeviceType.blind)
                    .map(
                      (e) => BlocBuilder<Device, DeviceCubitState>(
                        builder: (context, state) {
                          return BlindWidget2(device: e as Blind);
                        },
                        bloc: e,
                      ),
                    ),
                ...widget.devices
                    .where((device) =>
                        device.type == DeviceType.light ||
                        device.type == DeviceType.outlet ||
                        device.type == DeviceType.fan)
                    .map(
                      (e) => BlocBuilder<Device, DeviceCubitState>(
                        builder: (context, state) {
                          return DualStateDeviceWidget(device: e);
                        },
                        bloc: e,
                      ),
                    ),
              ],
            ),

          // if (devices.any((device) => device.type == DeviceType.light))
          //   LightWidgetContainer(
          //     lights: devices
          //         .where((device) => device.type == DeviceType.light)
          //         .map((e) => e as Light)
          //         .toList(),
          //   ),
          // const SizedBox(height: 10),
          // ...devices
          //     .where((device) => device.state.type == DeviceType.blind)
          //     .map((e) => Column(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             BlindWidget(
          //               blind: e as Blind,
          //             ),
          //             const SizedBox(height: 10),
          //           ],
          //         )),
          // ...devices
          //     .where((device) => device.type == DeviceType.outlet)
          //     .map((e) => BlocBuilder<Outlet, DeviceCubitState>(
          //             bloc: e as Outlet,
          //             builder: (context, state) {
          //               return Column(
          //                 mainAxisSize: MainAxisSize.min,
          //                 children: [
          //                   OutletWidget(
          //                     outlet: e,
          //                   ),
          //                   const SizedBox(height: 10),
          //                 ],
          //               );
          //             })
          //         ),
          // ...devices.where((device) => device.type == DeviceType.fan).map(
          //       (e) => BlocBuilder<Fan, DeviceCubitState>(
          //         builder: (context, state) {
          //           return Column(
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               FanWidget(
          //                 fan: e,
          //               ),
          //               const SizedBox(height: 10),
          //             ],
          //           );
          //         },
          //         bloc: e as Fan,
          //       ),
          //     ),
        ],
      ),
    );
  }

  Widget _createFullLightWidget(List<Device> devices) {
    final List<Light> lights = devices.whereType<Light>().toList();

    return lights.isEmpty
        ? Container()
        : DualStateMultiDeviceWidget(devices: lights);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/models/sensors/sensor.dart';
import 'package:flutter_smarthome/widgets/homeScreen/blind_widget.dart';
import 'package:flutter_smarthome/widgets/homeScreen/outlet_widget.dart';

import '../../models/devices/blind.dart';
import '../../models/devices/fan.dart';
import '../../models/devices/light.dart';
import '../../models/devices/outlet.dart';
import 'fan_widget.dart';
import 'light_widget.dart';

class RoomCard extends StatelessWidget {
  const RoomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
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
                  'Łazienka Duża',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.left,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Sensor.icon(SensorType.thermometer)),
                    Text('20.5 °C'),
                    const SizedBox(width: 10),
                    Icon(Sensor.icon(SensorType.hygrometer)),
                    Text('20 %'),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          LightWidget(
            lights: [
              Light(
                id: 1,
                name: 'Light 1',
                state: DeviceState.on,
              ),
              Light(
                id: 2,
                name: 'Light 2',
                state: DeviceState.on,
              ),
            ],
          ),
          SizedBox(height: 10),
          BlindWidget(
            blind: Blind(
              id: 1,
              name: 'Blind 1',
            ),
          ),
          SizedBox(height: 10),
          OutletWidget(outlet: Outlet(id: 1, name: 'Outlet 1')),
          SizedBox(height: 10),
          FanWidget(fan: Fan(id: 1, name: 'Fan 1')),
        ],
      ),
    );
  }
}

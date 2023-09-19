import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/sensors/hygro_termometer.dart';
import 'package:flutter_smarthome/models/sensors/hygrometer.dart';
import 'package:flutter_smarthome/models/sensors/thermometer.dart';

import '../../models/sensors/sensor.dart';

class SensorWidget extends StatelessWidget {
  final Sensor sensor;
  const SensorWidget({required this.sensor, super.key});

  @override
  Widget build(BuildContext context) {
    String value = "";
    String value2 = "";
    if (sensor.state.type == SensorType.thermometer) {
      value = "${(sensor as Thermometer).temperatureToString()}°C";
    } else if (sensor.state.type == SensorType.hygrometer) {
      value = "${(sensor as Hygrometer).humidityToString()}%";
    } else if (sensor.state.type == SensorType.hygroThermometer) {
      value = "${(sensor as HygroThermometer).humidity}% ";
      value2 = "${(sensor as HygroThermometer).temperatureToString()}°C";
    } else {
      value = "err sensor type";
    }
    return Row(
      children: [
        if (sensor.state.type == SensorType.hygroThermometer) ...{
          // hygroThermometer has two values to display
          Icon(Sensor.icon(SensorType.hygrometer)),
          const SizedBox(width: 10),
          Text(value),
          Icon(Sensor.icon(SensorType.thermometer)),
          const SizedBox(width: 10),
          Text(value2),
        },
        if (sensor.state.type != SensorType.hygroThermometer) ...{
          // other sensors have one value to display
          Icon(Sensor.icon(sensor.type)),
          const SizedBox(width: 10),
          Text(value),
        }
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/sensors/hygrometer.dart';
import 'package:flutter_smarthome/models/sensors/thermometer.dart';
import 'package:provider/provider.dart';

import '../../models/sensors/sensor.dart';

class SensorWidget extends StatelessWidget {
  const SensorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sensor = Provider.of<Sensor>(context);
    String value = "";
    if (sensor.type != SensorType.thermometer &&
        sensor.type != SensorType.hygrometer) {
      value = "err sensor type";
    } else if (sensor.type == SensorType.thermometer) {
      value = "${(sensor as Thermometer).temperatureToString()}°C";
    } else if (sensor.type == SensorType.hygrometer) {
      value = "${(sensor as Hygrometer).humidityToString()}%";
    }
    return Row(
      children: [
        Icon(Sensor.icon(sensor.type)),
        const SizedBox(width: 10),
        Text(value),
      ],
    );
  }
}

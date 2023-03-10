import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/sensors/thermometer.dart';
import '../models/sensors/hygrometer.dart';
import '../models/sensors/motion.dart';
import '../models/sensors/sensor.dart';
import 'package:provider/provider.dart';

import '../models/sensors/twilight.dart';

class SensorWidget extends StatelessWidget {
  const SensorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Sensor sensor = Provider.of<Sensor>(context);
    Icon sensorIcon = const Icon(Icons.error);

    Widget sensorTrailing = const Icon(Icons.error);

    BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      gradient: LinearGradient(colors: [
        Theme.of(context).colorScheme.primary,
        Color.alphaBlend(Colors.white.withAlpha(0x55),
            Theme.of(context).colorScheme.primary),
      ]),
    );

    switch (sensor.type) {
      case SensorType.thermometer:
        sensorIcon = Icon(Icons.thermostat,
            color: Theme.of(context).colorScheme.onPrimary);
        sensorTrailing =
            Text("${(sensor as Thermometer).temperatureToString()} °C",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                ));
        break;
      case SensorType.hygrometer:
        sensorIcon = Icon(Icons.water_drop,
            color: Theme.of(context).colorScheme.onPrimary);
        sensorTrailing = Text("${(sensor as Hygrometer).humidityToString()} %",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
            ));
        break;
      case SensorType.motion:
        var motion = sensor as Motion;
        sensorIcon = Icon(
          Icons.directions_run,
          color: Theme.of(context).colorScheme.onPrimary,
        );
        sensorTrailing = const Text("");
        if (!motion.isMotionDetected) {
          boxDecoration = BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade600
                : Colors.grey.shade500,
          );
        }
        break;
      case SensorType.twilight:
        var twilight = sensor as Twilight;
        sensorIcon = Icon(Icons.brightness_4,
            color: Theme.of(context).colorScheme.onPrimary);
        sensorTrailing = Text("${twilight.valueToString()} %",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
            ));
        if (!twilight.isDay) {
          boxDecoration = BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.grey.shade600
                : Colors.grey.shade500,
          );
        }
        break;

      default:
        sensorIcon =
            Icon(Icons.error, color: Theme.of(context).colorScheme.onPrimary);
    }

    // Icon deviceTrailingIcon = const Icon(Icons.power_settings_new);
    // if (device.state == DeviceState.on) {
    //   deviceTrailingIcon = const Icon(Icons.power_settings_new);
    // } else if (device.state == DeviceState.off) {
    //   deviceTrailingIcon = const Icon(Icons.power_settings_new_outlined);
    // } else if (device.state == DeviceState.up ||
    //     device.state == DeviceState.middle) {
    //   deviceTrailingIcon = const Icon(Icons.arrow_downward);
    // } else if (device.state == DeviceState.down) {
    //   deviceTrailingIcon = const Icon(Icons.arrow_upward);
    // }

    return Container(
      decoration: boxDecoration,
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          //TODO implement sensor window with details
        },
        child: ListTile(
          leading: sensorIcon,
          title: Text(
            sensor.name,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          trailing: sensorTrailing,
        ),
      ),
    );
  }
}

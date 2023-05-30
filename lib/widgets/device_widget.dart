import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/devices/device.dart';

class DeviceWidget extends StatefulWidget {
  const DeviceWidget({super.key});

  @override
  State<DeviceWidget> createState() => _DeviceWidgetState();
}

class _DeviceWidgetState extends State<DeviceWidget> {
  @override
  Widget build(BuildContext context) {
    final Device device = Provider.of<Device>(context);
    Icon deviceIcon = const Icon(Icons.error);

    switch (device.type) {
      case DeviceType.light:
        if (device.state == DeviceState.on) {
          deviceIcon = Icon(Icons.lightbulb,
              color: Theme.of(context).colorScheme.onPrimary);
        } else {
          deviceIcon = Icon(Icons.lightbulb_outline,
              color: Theme.of(context).colorScheme.onPrimary);
        }
        break;
      case DeviceType.blind:
        if (device.state == DeviceState.up) {
          deviceIcon = Icon(Icons.roller_shades,
              color: Theme.of(context).colorScheme.onPrimary);
        } else {
          deviceIcon = Icon(Icons.roller_shades_closed,
              color: Theme.of(context).colorScheme.onPrimary);
        }
        break;
      case DeviceType.outlet:
        if (device.state == DeviceState.on) {
          deviceIcon = Icon(Icons.outlet,
              color: Theme.of(context).colorScheme.onPrimary);
        } else {
          deviceIcon = Icon(Icons.outlet_outlined,
              color: Theme.of(context).colorScheme.onPrimary);
        }
        break;
      case DeviceType.fan:
        if (device.state == DeviceState.on) {
          deviceIcon = Icon(Icons.heat_pump,
              color: Theme.of(context).colorScheme.onPrimary);
        } else {
          deviceIcon = Icon(Icons.heat_pump_outlined,
              color: Theme.of(context).colorScheme.onPrimary);
        }
        break;
      default:
    }

    BoxDecoration boxDecoration =
        device.state == DeviceState.up || device.state == DeviceState.on
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primary,
                  Color.alphaBlend(Colors.white.withAlpha(0x33),
                      Theme.of(context).colorScheme.primary),
                ]))
            : BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(colors: [
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade600
                      : Colors.grey.shade500,
                  Theme.of(context).brightness == Brightness.light
                      ? Colors.grey.shade500
                      : Colors.grey.shade400,
                ]));

    Icon deviceTrailingIcon = const Icon(Icons.power_settings_new);
    if (device.state == DeviceState.on) {
      deviceTrailingIcon = Icon(Icons.power_settings_new,
          color: Theme.of(context).colorScheme.onPrimary);
    } else if (device.state == DeviceState.off) {
      deviceTrailingIcon = Icon(Icons.power_settings_new_outlined,
          color: Theme.of(context).colorScheme.onPrimary);
    } else if (device.state == DeviceState.up ||
        device.state == DeviceState.middle) {
      deviceTrailingIcon = Icon(Icons.arrow_downward,
          color: Theme.of(context).colorScheme.onPrimary);
    } else if (device.state == DeviceState.down) {
      deviceTrailingIcon = Icon(Icons.arrow_upward,
          color: Theme.of(context).colorScheme.onPrimary);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      clipBehavior: Clip.hardEdge,
      decoration: boxDecoration,
      margin: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      padding: const EdgeInsets.all(4),
      child: InkWell(
        onTap: () {
          device.changeState();
        },
        child: ListTile(
          leading: deviceIcon,
          title: Text(
            device.name,
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          trailing: deviceTrailingIcon,
        ),
      ),
    );
  }
}

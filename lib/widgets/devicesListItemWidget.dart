import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/bloc/devices/devices_bloc.dart';
import 'package:flutter_smarthome/models/room.dart';
import 'package:flutter_smarthome/repositories/rooms_repository.dart';
import 'package:provider/provider.dart';

import '../models/devices/device.dart';
import '../repositories/device_repository.dart';

class DevicesListItemWidget extends StatelessWidget {
  Device device;
  DevicesListItemWidget(this.device, {super.key});

  void showLoosingDataDialog(BuildContext context, Device device, Room room) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text("Are you sure?"),
              content: Text("You will delete ${device.name} from ${room.name}"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<DevicesBloc>().add(RemoveDevice(device.id));
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes'),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    final RoomsRepository rooms = context.read<RoomsRepository>();
    Icon deviceIcon = const Icon(Icons.error);

    switch (device.type) {
      case DeviceType.light:
        if (device.state.deviceState == DeviceState.on) {
          deviceIcon = Icon(Icons.lightbulb,
              color: Theme.of(context).colorScheme.onPrimary);
        } else {
          deviceIcon = Icon(Icons.lightbulb_outline,
              color: Theme.of(context).colorScheme.onPrimary);
        }
        break;
      case DeviceType.blind:
        if (device.state.deviceState == DeviceState.up) {
          deviceIcon = Icon(Icons.roller_shades,
              color: Theme.of(context).colorScheme.onPrimary);
        } else {
          deviceIcon = Icon(Icons.roller_shades_closed,
              color: Theme.of(context).colorScheme.onPrimary);
        }
        break;
      case DeviceType.outlet:
        if (device.state.deviceState == DeviceState.on) {
          deviceIcon = Icon(Icons.outlet,
              color: Theme.of(context).colorScheme.onPrimary);
        } else {
          deviceIcon = Icon(Icons.outlet_outlined,
              color: Theme.of(context).colorScheme.onPrimary);
        }
        break;
      case DeviceType.fan:
        if (device.state.deviceState == DeviceState.on) {
          deviceIcon = Icon(Icons.heat_pump,
              color: Theme.of(context).colorScheme.onPrimary);
        } else {
          deviceIcon = Icon(Icons.heat_pump_outlined,
              color: Theme.of(context).colorScheme.onPrimary);
        }
        break;
      default:
    }

    BoxDecoration boxDecoration = device.state.deviceState == DeviceState.up ||
            device.state.deviceState == DeviceState.on
        ? BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Color.alphaBlend(Colors.white.withAlpha(0x55),
                  Theme.of(context).colorScheme.primary),
            ]))
        : BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade600,
          );

    Widget deviceTrailingIcon = const Icon(Icons.power_settings_new);
    if (device.state.deviceState == DeviceState.on) {
      deviceTrailingIcon = Icon(Icons.power_settings_new,
          color: Theme.of(context).colorScheme.onPrimary);
    } else if (device.state.deviceState == DeviceState.off) {
      deviceTrailingIcon = Icon(Icons.power_settings_new_outlined,
          color: Theme.of(context).colorScheme.onPrimary);
    } else if (device.state.deviceState == DeviceState.up ||
        device.state.deviceState == DeviceState.middle) {
      deviceTrailingIcon = Icon(Icons.arrow_downward,
          color: Theme.of(context).colorScheme.onPrimary);
    } else if (device.state.deviceState == DeviceState.down) {
      deviceTrailingIcon = Icon(Icons.arrow_upward,
          color: Theme.of(context).colorScheme.onPrimary);
    }
    deviceTrailingIcon = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        // deviceTrailingIcon,
        IconButton(
          onPressed: () {
            log("Edit ${device.name}");
            Navigator.of(context).pushNamed(
              '/devices/add-edit-device',
              arguments: {'deviceId': device.id},
            );
          },
          icon: const Icon(Icons.edit),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        IconButton(
          onPressed: () {
            log("Delete ${device.name}");
            showLoosingDataDialog(
              context,
              device,
              rooms.getRoomById(device.roomId),
            );
          },
          icon: const Icon(Icons.delete),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ],
    );
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: boxDecoration,
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            device.changeState();
          },
          child: ListTile(
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [deviceIcon],
            ),
            title: Text(
              device.name,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            subtitle: Text(
              rooms.getRoomById(device.roomId).name,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            trailing: deviceTrailingIcon,
          ),
        ),
      ),
    );
  }
}

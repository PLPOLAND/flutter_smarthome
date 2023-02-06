import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/device.dart';
import 'package:flutter_smarthome/models/light.dart';
import 'package:provider/provider.dart';

import '../providers/devices_provider.dart';

class LightWidget extends StatelessWidget {
  const LightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Light light = Provider.of<Light>(context);
    return Container(
      decoration: light.state == DeviceState.on
          ? BoxDecoration(
              gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(0.8),
            ]))
          : BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary
              ]),
            ),
      child: ListTile(
        leading: Icon(Icons.lightbulb),
        title: Text(
          light.name,
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        ),
        trailing: IconButton(
            icon: Icon(Icons.power_settings_new),
            onPressed: () {
              light.changeState();
            }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/devices/outlet.dart';

import '../../models/devices/device.dart';

class OutletWidget extends StatefulWidget {
  final Outlet outlet;
  const OutletWidget({super.key, required this.outlet});

  @override
  State<OutletWidget> createState() => _OutletWidgetState();
}

class _OutletWidgetState extends State<OutletWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Device.icon(DeviceType.outlet)),
          const SizedBox(width: 10),
          Expanded(
              flex: 2,
              child: ElevatedButton.icon(
                icon: Icon(Icons.power_settings_new),
                label: Text(widget.outlet.name),
                onPressed: () {
                  setState(() {
                    widget.outlet.changeState();
                  });
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(
                    widget.outlet.state == DeviceState.on
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Color.alphaBlend(Colors.grey.withAlpha(0xA3),
                            Theme.of(context).colorScheme.primaryContainer),
                  ),
                  foregroundColor: MaterialStatePropertyAll<Color>(
                      Theme.of(context).colorScheme.onPrimaryContainer),
                ),
              )),
        ],
      ),
    );
  }
}

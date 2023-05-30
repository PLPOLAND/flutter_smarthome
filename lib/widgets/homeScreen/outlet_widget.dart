import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/devices/outlet.dart';
import 'package:flutter_smarthome/themes/themes.dart';
import 'package:provider/provider.dart';

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.outlet.name),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: 100,
                    child: IconButton(
                      icon: const Icon(Icons.power_settings_new),
                      onPressed: () {
                        setState(() {
                          widget.outlet.changeState();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          widget.outlet.state.deviceState == DeviceState.on
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : Color.alphaBlend(
                                  Provider.of<ThemesMenager>(context,
                                                  listen: false)
                                              .themeMode ==
                                          ThemeMode.light
                                      ? Colors.grey.withAlpha(0xA3)
                                      : Colors.black.withAlpha(0xA3),
                                  Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer),
                        ),
                        foregroundColor: MaterialStatePropertyAll<Color>(
                            Theme.of(context).colorScheme.onSecondaryContainer),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

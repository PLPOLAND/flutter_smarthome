import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/devices/fan.dart';
import 'package:provider/provider.dart';

import '../../models/devices/device.dart';
import '../../themes/themes.dart';

class FanWidget extends StatefulWidget {
  final Fan fan;
  const FanWidget({super.key, required this.fan});

  @override
  State<FanWidget> createState() => _FanWidgetState();
}

class _FanWidgetState extends State<FanWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Device.icon(DeviceType.fan)),
          const SizedBox(width: 10),
          Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.fan.name),
                  const SizedBox(width: 20),
                  Container(
                    width: 100,
                    child: IconButton(
                      icon: Icon(Icons.power_settings_new),
                      onPressed: () {
                        setState(() {
                          widget.fan.changeState();
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(
                          widget.fan.state.deviceState == DeviceState.on
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

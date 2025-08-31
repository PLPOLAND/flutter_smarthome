import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:provider/provider.dart';

import '../../models/devices/light.dart';
import '../../themes/themes.dart';

class DualStateMultiDeviceWidget extends StatefulWidget {
  final List<Light> devices;
  const DualStateMultiDeviceWidget({super.key, required this.devices});

  final double height = 125;

  @override
  State<DualStateMultiDeviceWidget> createState() => _DualStateDeviceWidget();
}

class _DualStateDeviceWidget extends State<DualStateMultiDeviceWidget> {
  @override
  Widget build(BuildContext context) {
    bool state = widget.devices
        .any((element) => element.state.deviceState == DeviceState.on);
    IconData icon = Device.icon(DeviceType.light, isOn: state);

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Card.filled(
        color: Theme.of(context).colorScheme.primaryContainer,
        margin: const EdgeInsets.all(5.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            for (var element in widget.devices) {
              element.setState(state ? DeviceState.off : DeviceState.on);
            }
          },
          child: SizedBox(
            height: widget.height,
            width: widget.height * 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: state
                            ? Colors.yellow.harmonizeWith(
                                Theme.of(context).colorScheme.primary)
                            : Theme.of(context).colorScheme.onPrimaryContainer,
                        shadows: state
                            ? [
                                BoxShadow(
                                  color: Colors.black38,
                                  blurRadius: 10,
                                  spreadRadius: 1,
                                  offset: Offset(1, 1),
                                )
                              ]
                            : null,
                        size: 35,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          "Światła",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

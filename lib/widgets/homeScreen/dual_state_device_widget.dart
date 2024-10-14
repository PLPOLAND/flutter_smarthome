import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:provider/provider.dart';

import '../../models/devices/light.dart';
import '../../themes/themes.dart';

class DualStateDeviceWidget extends StatefulWidget {
  final Device device;
  const DualStateDeviceWidget({super.key, required this.device});

  final double height = 125;

  @override
  State<DualStateDeviceWidget> createState() => _DualStateDeviceWidget();
}

class _DualStateDeviceWidget extends State<DualStateDeviceWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Device, DeviceCubitState>(
        bloc: widget.device,
        builder: (context, state) {
          IconData icon = Device.icon(widget.device.type,
              isOn: widget.device.deviceState.isOn);

          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card.filled(
              color: Theme.of(context).colorScheme.primaryContainer,
              margin: const EdgeInsets.all(5.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  widget.device.changeState();
                },
                onLongPress: () {
                  //TODO open device info page
                },
                child: SizedBox(
                  height: widget.height,
                  width: widget.height * 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Icon(
                              icon,
                              color: widget.device.deviceState.isOn
                                  ? widget.device.type == DeviceType.light
                                      ? Colors.yellow.harmonizeWith(
                                          Theme.of(context).colorScheme.primary)
                                      : Colors.green.harmonizeWith(
                                          Theme.of(context).colorScheme.primary)
                                  : Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                              shadows: widget.device.type == DeviceType.light &&
                                      widget.device.deviceState.isOn
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.device.name,
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
        });
  }
}

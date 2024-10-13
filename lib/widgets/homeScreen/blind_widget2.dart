import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/devices/blind.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:provider/provider.dart';

import '../../models/devices/light.dart';
import '../../themes/themes.dart';

class BlindWidget2 extends StatefulWidget {
  final Blind device;
  const BlindWidget2({super.key, required this.device});

  final double height = 125;

  @override
  State<BlindWidget2> createState() => _DualStateDeviceWidget();
}

class _DualStateDeviceWidget extends State<BlindWidget2> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Device, DeviceCubitState>(
        bloc: widget.device,
        builder: (context, state) {
          IconData icon = Device.icon(widget.device.type);

          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card.filled(
              color: Theme.of(context).colorScheme.primaryContainer,
              margin: const EdgeInsets.all(5.0),
              child: SizedBox(
                height: widget.height,
                width: widget.height * 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                    ? Colors.yellow
                                    : Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                size: 30,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.device.name,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (widget.device.deviceState.isRun)
                            Expanded(
                              child: InkWell(
                                  onTap: () => widget.device
                                      .setState(DeviceState.middle),
                                  child: const Arrow(icon: Icons.pause)),
                            ),
                          if (!widget.device.deviceState.isRun &&
                              !widget.device.deviceState.isUp)
                            Expanded(
                              child: InkWell(
                                onTap: () =>
                                    widget.device.setState(DeviceState.up),
                                // hoverColor: Colors.transparent,
                                child: const Arrow(icon: Icons.arrow_upward),
                              ),
                            ),
                          // if (!widget.device.deviceState.isRun) Divider(),
                          if (!widget.device.deviceState.isRun &&
                              !widget.device.deviceState.isDown)
                            Expanded(
                              child: InkWell(
                                onTap: () =>
                                    widget.device.setState(DeviceState.down),
                                // hoverColor: Colors.transparent,
                                child: const Arrow(icon: Icons.arrow_downward),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class Arrow extends StatelessWidget {
  const Arrow({
    super.key,
    required this.icon,
  });

  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        size: 25,
      ),
    );
  }
}

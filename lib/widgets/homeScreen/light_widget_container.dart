import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/widgets/homeScreen/multi_light_widget.dart';

import '../../models/devices/light.dart';
import '../../themes/themes.dart';

class LightWidgetContainer extends StatefulWidget {
  final List<Light> lights;
  const LightWidgetContainer({super.key, required this.lights});

  @override
  State<LightWidgetContainer> createState() => _LightWidgetContainerState();
}

class _LightWidgetContainerState extends State<LightWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    final double _sliderValue = widget.lights
        .where((element) => element.state == DeviceState.on)
        .length
        .toDouble();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Device.icon(DeviceType.light)),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Text(
                    _sliderValue == 0
                        ? 'Off'
                        : _sliderValue == widget.lights.length.toDouble()
                            ? 'Full'
                            : '${_sliderValue.toInt()}/${widget.lights.length}',
                  ),
                  flex: 1,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: MultiLightWidget(lights: widget.lights),
                  flex: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

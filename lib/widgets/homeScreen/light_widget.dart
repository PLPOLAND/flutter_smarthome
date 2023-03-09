import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/devices/device.dart';

import '../../models/devices/light.dart';

class LightWidget extends StatefulWidget {
  final List<Light> lights;
  const LightWidget({super.key, required this.lights});

  @override
  State<LightWidget> createState() => _LightWidgetState();
}

class _LightWidgetState extends State<LightWidget> {
  double _sliderValue = 0;

  @override
  Widget build(BuildContext context) {
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
                Text(
                  _sliderValue == 0
                      ? 'Off'
                      : _sliderValue == widget.lights.length.toDouble()
                          ? 'Full'
                          : '${_sliderValue.toInt()}/${widget.lights.length}',
                ),
                const SizedBox(width: 10),
                Slider(
                  max: widget.lights.length.toDouble(),
                  min: 0,
                  divisions: widget.lights.length,
                  activeColor: _sliderValue == 0
                      ? Colors.grey
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                  inactiveColor: _sliderValue == 0
                      ? Colors.grey
                      : Theme.of(context).colorScheme.onPrimaryContainer,
                  label: _sliderValue == 0
                      ? 'Off'
                      : _sliderValue == widget.lights.length.toDouble()
                          ? 'Full'
                          : '${_sliderValue.toInt()}/${widget.lights.length}',
                  value: _sliderValue,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                    });
                  },
                  onChangeEnd: (value) {
                    if (value == 0) {
                      widget.lights.forEach((light) {
                        light.setState(DeviceState.off);
                      });
                    } else if (value == widget.lights.length.toDouble()) {
                      widget.lights.forEach((light) {
                        light.setState(DeviceState.on);
                      });
                    } else {
                      for (var i = 0; i < widget.lights.length; i++) {
                        widget.lights[i].setState(i < value.toInt()
                            ? DeviceState.on
                            : DeviceState.off);
                      }
                    }
                    print("end");
                  },
                  semanticFormatterCallback: (value) {
                    if (value == 0) {
                      return 'Off';
                    } else if (value == widget.lights.length.toDouble()) {
                      return 'Full';
                    } else {
                      return '${value.toInt()}/${widget.lights.length}';
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

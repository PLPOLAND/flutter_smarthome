import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/widgets/homeScreen/multi_light_widget.dart';
import 'package:provider/provider.dart';

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
    final double sliderValue = widget.lights
        .where((element) => element.state.deviceState == DeviceState.on)
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sliderValue == 0
                      ? 'Off'
                      : sliderValue == widget.lights.length.toDouble()
                          ? widget.lights.length == 1
                              ? 'On'
                              : 'Full'
                          : '${sliderValue.toInt()}/${widget.lights.length}',
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: widget.lights.length < 2
                      ? 100
                      : widget.lights.length < 5
                          ? 150
                          : 230,
                  child: widget.lights.length < 2
                      ? IconButton(
                          icon: const Icon(Icons.power_settings_new),
                          onPressed: () {
                            setState(() {
                              widget.lights.first.changeState();
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              widget.lights.first.state.deviceState ==
                                      DeviceState.on
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
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
                                Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer),
                          ),
                        )
                      : MultiLightWidget(
                          lights: widget.lights,
                          onClick: () {
                            setState(() {});
                          }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

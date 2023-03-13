import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/devices/device.dart';

import '../../models/devices/light.dart';
import '../../themes/themes.dart';

class MultiLightWidget extends StatefulWidget {
  final List<Light> lights;
  const MultiLightWidget({super.key, required this.lights});

  @override
  State<MultiLightWidget> createState() => _MultiLightWidgetState();
}

class _MultiLightWidgetState extends State<MultiLightWidget> {
  List<Widget> _buildLightWidgets() {
    final List<Widget> lightWidgets = [];
    for (int i = 0; i < widget.lights.length; i++) {
      lightWidgets.add(
        InkWell(
          onTap: () {
            setState(() {
              widget.lights[i].changeState();
            });
          },
          child: Container(
            width: 50,
            height: 30,
            decoration: BoxDecoration(
              color: widget.lights[i].state == DeviceState.on
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Color.alphaBlend(
                      ThemesMenager.themeMode == ThemeMode.light
                          ? Colors.grey.withAlpha(0xA3)
                          : Colors.black.withAlpha(0xA3),
                      Theme.of(context).colorScheme.secondaryContainer),
              borderRadius: i == 0
                  ? BorderRadius.horizontal(left: Radius.circular(10))
                  : i == widget.lights.length - 1
                      ? BorderRadius.horizontal(right: Radius.circular(10))
                      : BorderRadius.zero,
            ),
            child: i != widget.lights.length - 1
                ? Row(
                    children: [
                      Container(
                          height: double.infinity,
                          width: 1,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                  )
                : null,
          ),
        ),
      );
    }
    return lightWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ..._buildLightWidgets(),
        ],
      ),
    );
  }
}

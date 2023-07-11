import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:provider/provider.dart';

import '../../models/devices/light.dart';
import '../../themes/themes.dart';

class MultiLightWidget extends StatefulWidget {
  final List<Light> lights;
  final Function()? onClick;
  const MultiLightWidget({super.key, required this.lights, this.onClick});

  @override
  State<MultiLightWidget> createState() => _MultiLightWidgetState();
}

class _MultiLightWidgetState extends State<MultiLightWidget> {
  List<Widget> _buildLightWidgets() {
    final List<Widget> lightWidgets = [];
    for (int i = 0; i < widget.lights.length; i++) {
      /// If it's first light, set left border radius, if it's last light, set right border radius
      var calculatedBorederRadius = i == 0
          ? const BorderRadius.horizontal(left: Radius.circular(30))
          : i == widget.lights.length - 1
              ? const BorderRadius.horizontal(right: Radius.circular(30))
              : BorderRadius.zero;

      /// Add light widget to list
      lightWidgets.add(
        BlocBuilder<Light, DeviceCubitState>(
          bloc: widget.lights[i],
          builder: (context, state) {
            return Expanded(
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: widget.lights[i].state.deviceState == DeviceState.on
                      ? Theme.of(context).colorScheme.secondaryContainer
                      : Color.alphaBlend(
                          Provider.of<ThemesMenager>(context).themeMode ==
                                  ThemeMode.light
                              ? Colors.grey.withAlpha(0xA3)
                              : Colors.black.withAlpha(0xA3),
                          Theme.of(context).colorScheme.secondaryContainer),
                  borderRadius: calculatedBorederRadius,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: calculatedBorederRadius,
                    ),
                    onTap: () {
                      setState(() {
                        widget.lights[i].changeState();
                      });
                      if (widget.onClick != null) {
                        widget.onClick!();
                      }
                    },
                    child: i != widget.lights.length - 1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                height: double.infinity,
                                width: 1,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                            ],
                          )
                        : null,
                  ),
                ),
              ),
            );
          },
        ),
      );
    }
    return lightWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ..._buildLightWidgets(),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            icon: const Icon(Icons.power_settings_new),
            onPressed: () {
              setState(() {
                var anyDeviceOff = widget.lights.any(
                    (element) => element.state.deviceState == DeviceState.off);
                for (var element in widget.lights) {
                  if (anyDeviceOff) {
                    element.setState(DeviceState.on);
                  } else {
                    element.setState(DeviceState.off);
                  }
                }
              });
              if (widget.onClick != null) {
                widget.onClick!();
              }
            },
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                !widget.lights.any((element) =>
                        element.state.deviceState == DeviceState.off)
                    ? Theme.of(context).colorScheme.secondaryContainer
                    : Color.alphaBlend(
                        Provider.of<ThemesMenager>(context).themeMode ==
                                ThemeMode.light
                            ? Colors.grey.withAlpha(0xA3)
                            : Colors.black.withAlpha(0xA3),
                        Theme.of(context).colorScheme.secondaryContainer),
              ),
              foregroundColor: MaterialStatePropertyAll<Color>(
                  Theme.of(context).colorScheme.onSecondaryContainer),
            ),
          ),
        ],
      ),
    );
  }
}

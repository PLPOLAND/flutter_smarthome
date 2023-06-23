import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/devices/blind.dart';
import 'package:flutter_smarthome/models/devices/device.dart';

class BlindWidget extends StatelessWidget {
  final Blind blind;
  const BlindWidget({super.key, required this.blind});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Blind, DeviceCubitState>(
      bloc: blind,
      // buildWhen: (previous, current) {
      //   if (current.deviceState != DeviceState.run) {
      //     return true;
      //   }
      //   return false;
      // },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Device.icon(DeviceType.blind)),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(child: Text(blind.name)),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 150,
                      child: SegmentedButton<DeviceState>(
                          showSelectedIcon: false,
                          segments: const [
                            ButtonSegment<DeviceState>(
                                value: DeviceState.down,
                                icon: Icon(Icons.arrow_downward)),
                            ButtonSegment<DeviceState>(
                              value: DeviceState.middle,
                              icon: Icon(Icons.pause),
                            ),
                            ButtonSegment<DeviceState>(
                              value: DeviceState.up,
                              icon: Icon(Icons.arrow_upward),
                            )
                          ],
                          selected: {blind.state.deviceState},
                          onSelectionChanged: (value) {
                            blind.setState(value.first);
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                // return Colors.green;
                                return Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer;
                              }
                              return Theme.of(context)
                                  .colorScheme
                                  .primaryContainer;
                            }),
                            foregroundColor:
                                MaterialStateProperty.resolveWith((states) {
                              if (states.contains(MaterialState.selected)) {
                                return Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer;
                              }
                              return Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer;
                            }),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

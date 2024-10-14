import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/devices/blind.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/models/sensors/hygro_termometer.dart';
import 'package:flutter_smarthome/models/sensors/sensor.dart';
import 'package:flutter_smarthome/models/sensors/thermometer.dart';
import 'package:provider/provider.dart';

import '../../models/devices/light.dart';
import '../../themes/themes.dart';

class SensorWidget2 extends StatefulWidget {
  final Sensor sensor;
  const SensorWidget2({super.key, required this.sensor});

  final double height = 125;

  @override
  State<SensorWidget2> createState() => _DualStateDeviceWidget();
}

class _DualStateDeviceWidget extends State<SensorWidget2> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Sensor, SensorCubitState>(
        bloc: widget.sensor,
        builder: (context, state) {
          IconData icon = Sensor.icon(widget.sensor.type);

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
                                color: Theme.of(context)
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
                                  widget.sensor.name,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 90,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (widget.sensor.type.isTemperature())
                              Text(
                                "${(widget.sensor as Thermometer).temperature.toStringAsFixed(1)}°C",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            if (widget.sensor.type.isHumidity())
                              Text(
                                "${(widget.sensor as HygroThermometer).humidity.toStringAsFixed(1)}%",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            if (widget.sensor.type.isTwilight())
                              Text(
                                "${(widget.sensor as Thermometer).temperature.toStringAsFixed(1)}%",
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                          ],
                        ),
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

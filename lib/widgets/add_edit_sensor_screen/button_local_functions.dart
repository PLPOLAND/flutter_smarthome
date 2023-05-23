import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/sensors/button.dart';
import 'package:flutter_smarthome/repositories/device_repository.dart';
import 'package:flutter_smarthome/providers/sensors_provider.dart';
import 'package:provider/provider.dart';

import '../../models/devices/device.dart';

class ButtonLocalClickFunctionsWidget extends StatefulWidget {
  final int? sensorID;
  final int roomID;
  Null Function(List<ButtonLocalClickFunction>) saveFunctions;
  Null Function() anyChange;
  ButtonLocalClickFunctionsWidget(
      {super.key,
      required this.sensorID,
      required this.roomID,
      required this.anyChange,
      required this.saveFunctions});

  @override
  State<ButtonLocalClickFunctionsWidget> createState() =>
      _ButtonLocalClickFunctionsWidgetState();
}

class _ButtonLocalClickFunctionsWidgetState
    extends State<ButtonLocalClickFunctionsWidget> {
  List<ButtonLocalClickFunction> functions = [];

  Widget buildButtonLocalClickFunctionWidget(
      int roomID, BuildContext context, ButtonLocalClickFunction? function) {
    bool hasFunction = function != null;
    if (hasFunction) {
      hasFunction = function.deviceID != -1;
    }
    function ??= ButtonLocalClickFunction(deviceID: -1, clicks: 0);
    final devices = context
        .read<DevicesRepository>()
        .devices
        .where((element) => element.roomId == roomID)
        .toList();
    if (hasFunction) {
      if (devices
          .where((element) => element.id == function!.deviceID)
          .isEmpty) {
        function.deviceID = -1;
        function.state = null;
        function.clicks = 0;
      }
    }
    var textEditingController = TextEditingController(
        text: hasFunction ? function.clicks.toString() : "0");
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          //Select device
          flex: 4,
          child: DropdownButtonFormField(
            decoration: const InputDecoration(
              labelText: "Device:",
            ),
            items: devices
                .map((dev) => DropdownMenuItem(
                      value: dev.id,
                      child: Text(dev.name,
                          style:
                              const TextStyle(fontWeight: FontWeight.normal)),
                    ))
                .toList(),
            onChanged: (value) {
              widget.anyChange();
              setState(() {
                function!.deviceID = value as int;
              });
              widget.saveFunctions(functions);
            },
            value: hasFunction
                ? function.deviceID == -1
                    ? null
                    : function.deviceID
                : null,
          ),
        ),
        // if (hasFunction &&
        //     devices
        //             .firstWhere((element) => element.id == function!.deviceID)
        //             .type ==
        //         DeviceType.blind)
        Expanded(
            //Select state
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: DropdownButtonFormField(
                decoration: const InputDecoration(
                  labelText: "State:",
                ),
                items: const [
                  DropdownMenuItem(
                    value: DeviceState.up,
                    child: Text("Up"),
                  ),
                  DropdownMenuItem(
                    value: DeviceState.down,
                    child: Text("Down"),
                  ),
                  DropdownMenuItem(
                    value: DeviceState.middle,
                    child: Text("Stop"),
                  ),
                ],
                onChanged: (value) {
                  widget.anyChange();

                  widget.saveFunctions(functions);
                  function!.state = value as DeviceState;
                },
                value: function.state != DeviceState.up ||
                        function.state != DeviceState.down ||
                        function.state != DeviceState.middle
                    ? DeviceState.up
                    : function.state,
              ),
            )),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Clicks:",
              ),
              keyboardType: TextInputType.number,
              controller: textEditingController,
              onChanged: (value) {
                widget.anyChange();

                widget.saveFunctions(functions);
                if (value.isNotEmpty) {
                  function!.clicks = int.tryParse(value) ?? 0;
                }
              },
              onFieldSubmitted: (value) {
                if (value.isEmpty) {
                  function!.clicks = 0;
                  textEditingController.text = "0";
                }
              },
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            setState(() {
              functions.remove(function);
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.sensorID != null) {
      // if sensorID is null, it is a new sensor and we don't need to load the functions
      final button = Provider.of<SensorsProvider>(context)
          .getSensorById(widget.sensorID!) as Button;
      if (button.localFunctions.isNotEmpty) {
        functions = button.localFunctions;
      }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Local functions:",
              textAlign: TextAlign.left,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  widget.anyChange();
                  functions.add(ButtonLocalClickFunction(
                      deviceID: -1, clicks: 0, state: DeviceState.none));
                });
              },
            ),
          ],
        ),
        for (var function in functions)
          buildButtonLocalClickFunctionWidget(widget.roomID, context, function),
      ],
    );
  }
}

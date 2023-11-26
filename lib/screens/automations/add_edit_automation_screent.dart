import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smarthome/models/automations/function_type.dart';
import 'package:flutter_smarthome/models/bloc/devices/devices_bloc.dart';
import 'package:flutter_smarthome/models/room.dart';
import 'package:flutter_smarthome/models/sensors/sensor.dart';
import 'package:flutter_smarthome/repositories/device_repository.dart';
import 'package:flutter_smarthome/repositories/rooms_repository.dart';
import 'package:flutter_smarthome/repositories/sensors_repository.dart';
import 'package:flutter_smarthome/screens/sensors_screen.dart';

class AddEditAutomationScreen extends StatefulWidget {
  static const routeName = '/automations/add_edit_automation';

  const AddEditAutomationScreen({super.key});

  @override
  State<AddEditAutomationScreen> createState() =>
      _AddEditAutomationScreenState();
}

class _AddEditAutomationScreenState extends State<AddEditAutomationScreen> {
  final formKey = GlobalKey<FormState>();

  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  var tmp = 1;
  var selectedFunctionType = FunctionType.user;

  int buttonID = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> userFunctions = [
      DropdownButtonFormField(
        decoration: const InputDecoration(
          labelText: "Użytkownik",
          prefixIcon: Icon(Icons.people),
        ),
        value: tmp,
        onChanged: null,
        items: const [
          DropdownMenuItem(value: 1, child: Text("Tymczasowy")),
        ],
      ),
    ];

    List<Sensor> buttons = context
        .read<SensorsRepository>()
        .sensors
        .where((element) => element.type == SensorType.button)
        .toList();
    buttonID = buttons.first.id;
    List<Room> rooms = context.read<RoomsRepository>().rooms;

    List<Widget> buttonFunctions = [
      DropdownButtonFormField<int>(
        items: [
          ...buttons.map((e) {
            return DropdownMenuItem<int>(
              value: e.id,
              child: Text("${rooms[e.roomId].name} - ${e.name}"),
            );
          }).toList(),
        ],
        onChanged: (val) {},
        decoration: const InputDecoration(
          labelText: "Przycisk",
          prefixIcon: Icon(Icons.touch_app),
        ),
        value: buttonID,
      ),
    ];

    List<Widget> automationFunctions = [Text("TODO")];

    return Scaffold(
        appBar: AppBar(
          title: const Text('Dodaj automatyzację'),
          actions: [IconButton(onPressed: null, icon: const Icon(Icons.save))],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Nazwa:',
                    style: _textStyle,
                  ),
                  TextFormField(
                    controller: null,
                    decoration: const InputDecoration(labelText: "Nazwa"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Typ automatyzacji:",
                      style: _textStyle,
                    ),
                  ),
                  SegmentedButton<FunctionType>(
                    segments: const [
                      ButtonSegment(
                        value: FunctionType.user,
                        icon: Icon(Icons.people),
                        label: Text('Użytkownika'),
                      ),
                      ButtonSegment(
                        value: FunctionType.button,
                        icon: Icon(Icons.touch_app),
                        label: Text('Przycisk'),
                      ),
                      ButtonSegment(
                        value: FunctionType.autmation,
                        icon: Icon(Icons.auto_mode),
                        label: Text("Automatyczna"),
                      ),
                    ],
                    selected: <FunctionType>{
                      selectedFunctionType,
                    },
                    onSelectionChanged: (Set<FunctionType> selected) {
                      setState(() {
                        selectedFunctionType = selected.first;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      "Akcje:", //TODO adding actions
                      style: _textStyle,
                    ),
                  ),
                  if (selectedFunctionType == FunctionType.user)
                    ...userFunctions,
                  if (selectedFunctionType == FunctionType.button)
                    ...buttonFunctions,
                  if (selectedFunctionType == FunctionType.autmation)
                    ...automationFunctions,
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // if (anyChange) {
                          // showLoosingDataDialog(isEditing);
                          // } else {
                          Navigator.of(context).pop();
                          // }
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text('Cancel'),
                      ),
                      FilledButton.icon(
                        onPressed:
                            //showSaveIndicator
                            //?
                            null,
                        // : () {
                        //     save(sensorId);
                        //   },
                        icon:
                            // showSaveIndicator
                            false
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                    ))
                                : const Icon(Icons.save),
                        label: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

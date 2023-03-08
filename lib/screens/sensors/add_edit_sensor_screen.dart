import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/models/devices/light.dart';
import 'package:flutter_smarthome/models/devices/outlet.dart';
import 'package:flutter_smarthome/models/sensors/button.dart';
import 'package:flutter_smarthome/models/sensors/hygrometer.dart';
import 'package:flutter_smarthome/models/sensors/sensor.dart';
import 'package:flutter_smarthome/providers/devices_provider.dart';
import 'package:provider/provider.dart';

import '../../models/devices/blind.dart';
import '../../models/devices/fan.dart';
import '../../models/room.dart';
import '../../models/sensors/motion.dart';
import '../../models/sensors/termometer.dart';
import '../../models/sensors/twilight.dart';
import '../../providers/room_provider.dart';
import '../../providers/sensors_provider.dart';

class AddEditSensorScreen extends StatefulWidget {
  static const routeName = '/sensors/add-edit-sensor';
  const AddEditSensorScreen({super.key});

  @override
  State<AddEditSensorScreen> createState() => _AddEditSensorScreenState();
}

class _AddEditSensorScreenState extends State<AddEditSensorScreen> {
  final formKey = GlobalKey<FormState>();
  var selectedSensorType = SensorType.button;

  var selectedRoomId = 1;
  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  TextEditingController nameController = TextEditingController();
  TextEditingController slaveAddressController = TextEditingController();
  TextEditingController slavePinController = TextEditingController();
  double dayValue = 0.5;

  bool showSaveIndicator = false;

  bool _needInit = true;

  bool anyChange = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_needInit) {
      _needInit = false;
      int? sensorId;
      int? roomId;
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        sensorId = args['sensorId'] as int?;
        roomId = args['roomId'] as int?;
      }
      if (sensorId != null) {
        final sensor = Provider.of<SensorsProvider>(context, listen: false)
            .getSensorById(sensorId);
        nameController.text = sensor.name;
        slaveAddressController.text = sensor.slaveId.toString();
        if (!(sensor is Thermometer || sensor is Hygrometer)) {
          slavePinController.text = sensor.onSlavePin.toString();
        }
        selectedRoomId = sensor.roomId;
        print(sensor.type);
        selectedSensorType = sensor.type;
      } else if (roomId != null) {
        selectedRoomId = roomId;
      }
    }
  }

  Future<void> save(int? sensorId) async {
    if (selectedSensorType == SensorType.button) {
      showButtonSensorNotImplemented(); //TODO remove after fully implementing button sensor
    }
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      showSaveIndicator = true;
    });
    if (sensorId == null) {
      // add new device
      Sensor? sensor;

      switch (selectedSensorType) {
        case SensorType.button:
          sensor = Button(
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
          );
          break;
        case SensorType.motion:
          sensor = Motion(
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
          );
          break;
        case SensorType.twilight:
          sensor = Twilight(
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
            dayValue: dayValue,
          );
          break;
        default:
          break;
      }
      if (sensor != null) {
        await Provider.of<SensorsProvider>(context, listen: false)
            .addSensor(sensor);
        setState(() {
          showSaveIndicator = false;
        });
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    } else {
      // update device
      Sensor oldDevice = Provider.of<SensorsProvider>(context, listen: false)
          .getSensorById(sensorId);
      Sensor? newSensor;

      switch (selectedSensorType) {
        case SensorType.button:
          newSensor = Button(
            id: oldDevice.id,
            onSlaveId: oldDevice.onSlaveId,
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
          );
          break;
        case SensorType.motion:
          newSensor = Motion(
            id: oldDevice.id,
            onSlaveId: oldDevice.onSlaveId,
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
          );
          break;
        case SensorType.twilight:
          newSensor = Twilight(
              id: oldDevice.id,
              onSlaveId: oldDevice.onSlaveId,
              name: nameController.text,
              roomId: selectedRoomId,
              slaveId: int.parse(slaveAddressController.text),
              onSlavePin: int.parse(slavePinController.text),
              dayValue: dayValue);
          break;
        case SensorType.thermometer:
          newSensor = Thermometer(
            id: oldDevice.id,
            onSlaveId: oldDevice.onSlaveId,
            adress: oldDevice.adress!,
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
          );
          break;
        case SensorType.hygrometer:
          newSensor = Hygrometer(
            id: oldDevice.id,
            onSlaveId: oldDevice.onSlaveId,
            adress: oldDevice.adress!,
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
          );
          break;
        default:
          break;
      }
      if (newSensor != null) {
        await Provider.of<SensorsProvider>(context, listen: false)
            .updateDevice(newSensor);
        setState(() {
          showSaveIndicator = false;
        });
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  void showButtonSensorNotImplemented() {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              icon: Icon(
                Icons.warning,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
              title: const Text("Warning"),
              content: const Text("Sensor 'Button' is not implemented yet!"),
              actions: [
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.onErrorContainer),
                    foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.errorContainer),
                  ),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: const Text("OK"),
                )
              ],
            ));
  }

  void showLoosingDataDialog(bool isEditing) {
    showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text("Are you sure?"),
              content: isEditing
                  ? const Text("You will lose all unsaved changes!")
                  : const Text("You will lose all data!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes'),
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    int? sensorId;
    int? roomId;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      sensorId = args['sensorId'] as int?;
      roomId = args['roomId'] as int?;
    }
    final List<Room> rooms = Provider.of<RoomsProvider>(context).rooms;
    final bool isEditing = sensorId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Sensor' : 'Add Sensor'),
        actions: [
          IconButton(
            icon: showSaveIndicator
                ? const SizedBox(
                    height: 16,
                    width: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                    ))
                : const Icon(Icons.save),
            onPressed: showSaveIndicator
                ? null
                : () {
                    save(sensorId);
                  },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Text('Name:', style: _textStyle),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    textInputAction: TextInputAction.next,
                    onChanged: (_) => anyChange = true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      if (value.length < 3) {
                        return 'Name must be at least 3 characters long';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Device Type:', style: _textStyle),
                  ),
                  SegmentedButton<SensorType>(
                      segments: [
                        if (isEditing) ...{
                          ButtonSegment<SensorType>(
                            value: SensorType.thermometer,
                            icon:
                                Icon(Sensor.sensorIcon(SensorType.thermometer)),
                            // label: const Text('Thermometer'),
                          ),
                          ButtonSegment<SensorType>(
                            value: SensorType.hygrometer,
                            icon:
                                Icon(Sensor.sensorIcon(SensorType.hygrometer)),
                            // label: const Text('Hygrometer'),
                          )
                        },
                        ButtonSegment<SensorType>(
                          value: SensorType.motion,
                          icon: Icon(Sensor.sensorIcon(SensorType.motion)),
                          // label: const Text('Motion'),
                        ),
                        ButtonSegment<SensorType>(
                          value: SensorType.twilight,
                          icon: Icon(Sensor.sensorIcon(SensorType.twilight)),
                          // label: const Text('Twilight'),
                        ),
                        ButtonSegment<SensorType>(
                          value: SensorType.button,
                          icon: Icon(Sensor.sensorIcon(SensorType.button)),
                          // label: const Text('Button'),
                        ),
                      ],
                      selected: <SensorType>{
                        selectedSensorType
                      },
                      onSelectionChanged: (Set<SensorType> selected) {
                        anyChange = true;
                        setState(() {
                          selectedSensorType = selected.first;
                        });
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text("Room:", style: _textStyle),
                  ),
                  DropdownButtonFormField(
                    items: rooms
                        .map((room) => DropdownMenuItem(
                              value: room.id,
                              child: Text(room.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      anyChange = true;
                      setState(() {
                        selectedRoomId = value as int;
                      });
                    },
                    value: selectedRoomId,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: Text('Slave adress', style: _textStyle),
                  // ),

                  TextFormField(
                    enabled: selectedSensorType != SensorType.hygrometer &&
                        selectedSensorType != SensorType.thermometer,
                    controller: slaveAddressController,
                    decoration:
                        const InputDecoration(labelText: 'Slave Adress'),
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    onChanged: (_) => anyChange = true,
                    validator: (value) {
                      if (selectedSensorType == SensorType.hygrometer ||
                          selectedSensorType == SensorType.thermometer) {
                        return null;
                      }
                      if (value!.isEmpty) {
                        return 'Please enter a number';
                      }
                      if (int.parse(value) > 255) {
                        return 'Please enter a smaller number';
                      }
                      if (int.parse(value) < 8) {
                        return 'Please enter a number bigger than 8';
                      }
                      return null;
                    },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 10),
                  //   child: Text('Slave Pin Number', style: _textStyle),
                  // ),
                  if (selectedSensorType != SensorType.hygrometer &&
                      selectedSensorType != SensorType.thermometer)
                    TextFormField(
                      controller: slavePinController,
                      decoration:
                          const InputDecoration(labelText: 'Slave Pin Number'),
                      textInputAction: TextInputAction.done,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      onChanged: (_) => anyChange = true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a number';
                        }
                        if (int.parse(value) > 255) {
                          return 'Please enter a smaller number';
                        }
                        if (int.parse(value) < 0) {
                          return 'Please enter a number bigger than 0';
                        }
                        return null;
                      },
                    ),
                  if (selectedSensorType == SensorType.twilight) ...{
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Day value: ${dayValue.toStringAsFixed(2)}',
                        ),
                        Slider(
                            max: 1,
                            min: 0,
                            divisions: 20,
                            label: dayValue.toString(),
                            value: dayValue,
                            onChanged: (value) {
                              anyChange = true;
                              setState(() {
                                dayValue = value;
                              });
                            }),
                      ],
                    ),
                  },
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          if (anyChange) {
                            showLoosingDataDialog(isEditing);
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text('Cancel'),
                      ),
                      FilledButton.icon(
                        onPressed: showSaveIndicator
                            ? null
                            : () {
                                save(sensorId);
                              },
                        icon: showSaveIndicator
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
            )),
      ),
    );
  }
}

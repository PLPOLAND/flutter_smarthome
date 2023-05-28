import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/models/devices/light.dart';
import 'package:flutter_smarthome/models/devices/outlet.dart';
import 'package:flutter_smarthome/repositories/device_repository.dart';
import 'package:provider/provider.dart';

import '../../models/devices/blind.dart';
import '../../models/devices/fan.dart';
import '../../models/room.dart';
import '../../providers/room_provider.dart';

class AddEditDeviceScreen extends StatefulWidget {
  static const routeName = '/devices/add-edit-device';
  const AddEditDeviceScreen({super.key});

  @override
  State<AddEditDeviceScreen> createState() => _AddEditDeviceScreenState();
}

class _AddEditDeviceScreenState extends State<AddEditDeviceScreen> {
  final formKey = GlobalKey<FormState>();
  var selectedDeviceType = DeviceType.light;

  var selectedRoomId = 1;
  final TextStyle _textStyle = const TextStyle(fontSize: 16);

  TextEditingController nameController = TextEditingController();
  TextEditingController slaveAddressController = TextEditingController();
  TextEditingController slavePinController = TextEditingController();

  bool showSaveIndicator = false;

  bool _needInit = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_needInit) {
      _needInit = false;
      int? deviceId;
      int? roomId;
      if (ModalRoute.of(context)!.settings.arguments != null) {
        final args =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        deviceId = args['deviceId'] as int?;
        roomId = args['roomId'] as int?;
      }
      if (deviceId != null) {
        final device =
            context.read<DevicesRepository>().getDeviceById(deviceId);
        nameController.text = device.name;
        slaveAddressController.text = device.slaveID.toString();
        slavePinController.text = device.onSlavePin.toString();
        selectedRoomId = device.roomId;
        selectedDeviceType = device.type;
      } else if (roomId != null) {
        selectedRoomId = roomId;
      }
    }
  }

  Future<void> save(int? deviceId) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    setState(() {
      showSaveIndicator = true;
    });
    if (deviceId == null) {
      // add new device
      Device? device;

      switch (selectedDeviceType) {
        case DeviceType.light:
          device = Light(
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
          );
          break;
        case DeviceType.blind:
          device = Blind(
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePinUp: int.parse(slavePinController.text),
          );
          break;
        case DeviceType.outlet:
          device = Fan(
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
          );
          break;
        case DeviceType.fan:
          device = Fan(
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
          );
          break;
        default:
          break;
      }
      if (device != null) {
        await context.read<DevicesRepository>().addDevice(device);
        setState(() {
          showSaveIndicator = false;
        });
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    } else {
      // update device
      Device oldDevice =
          context.read<DevicesRepository>().getDeviceById(deviceId);
      Device? newDevice;

      switch (selectedDeviceType) {
        case DeviceType.light:
          newDevice = Light(
            id: oldDevice.id,
            onSlaveId: oldDevice.onSlaveID,
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
          );
          break;
        case DeviceType.blind:
          newDevice = Blind(
            id: oldDevice.id,
            onSlaveId: oldDevice.onSlaveID,
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePinUp: int.parse(slavePinController.text),
          );
          break;
        case DeviceType.outlet:
          newDevice = Fan(
            id: oldDevice.id,
            onSlaveId: oldDevice.onSlaveID,
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
          );
          break;
        case DeviceType.fan:
          newDevice = Fan(
            id: oldDevice.id,
            onSlaveId: oldDevice.onSlaveID,
            name: nameController.text,
            roomId: selectedRoomId,
            slaveId: int.parse(slaveAddressController.text),
            onSlavePin: int.parse(slavePinController.text),
          );
          break;
        default:
          break;
      }
      if (newDevice != null) {
        await context.read<DevicesRepository>().updateDevice(newDevice);
        setState(() {
          showSaveIndicator = false;
        });
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    }
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
    int? deviceId;
    int? roomId;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      deviceId = args['deviceId'] as int?;
      roomId = args['roomId'] as int?;
    }
    final List<Room> rooms = Provider.of<RoomsProvider>(context).rooms;
    final bool isEditing = deviceId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Device' : 'Add Device'),
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
                    save(deviceId);
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
                  Text('Name:', style: _textStyle),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    textInputAction: TextInputAction.next,
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
                  SegmentedButton<DeviceType>(
                      segments: [
                        ButtonSegment<DeviceType>(
                          value: DeviceType.light,
                          icon: Icon(Device.icon(DeviceType.light)),
                          label: const Text('Light'),
                        ),
                        ButtonSegment<DeviceType>(
                          value: DeviceType.blind,
                          icon: Icon(Device.icon(DeviceType.blind)),
                          label: const Text('Blind'),
                        ),
                        ButtonSegment<DeviceType>(
                          value: DeviceType.outlet,
                          icon: Icon(Device.icon(DeviceType.outlet)),
                          label: const Text('Outlet'),
                        ),
                        ButtonSegment<DeviceType>(
                          value: DeviceType.fan,
                          icon: Icon(Device.icon(DeviceType.fan)),
                          label: const Text('Fan'),
                        ),
                      ],
                      selected: <DeviceType>{
                        selectedDeviceType
                      },
                      onSelectionChanged: (Set<DeviceType> selected) {
                        setState(() {
                          selectedDeviceType = selected.first;
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
                      setState(() {
                        selectedRoomId = value as int;
                      });
                    },
                    value: selectedRoomId,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Slave adress', style: _textStyle),
                  ),
                  TextFormField(
                    controller: slaveAddressController,
                    decoration:
                        const InputDecoration(labelText: 'Slave Adress'),
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    validator: (value) {
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('Slave adress', style: _textStyle),
                  ),
                  TextFormField(
                    controller: slavePinController,
                    decoration:
                        const InputDecoration(labelText: 'Slave Pin Number'),
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
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
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          showLoosingDataDialog(isEditing);
                        },
                        icon: const Icon(Icons.cancel),
                        label: const Text('Cancel'),
                      ),
                      ElevatedButton.icon(
                        onPressed: showSaveIndicator
                            ? null
                            : () {
                                save(deviceId);
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

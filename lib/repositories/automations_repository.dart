import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';
import 'package:flutter_smarthome/models/automations/automation.dart';
import 'package:flutter_smarthome/models/automations/button_automation.dart';
import 'package:flutter_smarthome/models/automations/function_action.dart';
import 'package:flutter_smarthome/models/sensors/button.dart';
import 'package:flutter_smarthome/repositories/dummy_data/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/devices/blind.dart';
import '../models/devices/device.dart';
import '../models/devices/fan.dart';
import '../models/devices/light.dart';
import '../models/devices/outlet.dart';

class AutomationsRepository {
  final List<Automation> _automations = [];

  RESTClient client = RESTClient();
  List<Automation> get automations => [..._automations];

  Future<void> loadDemoData() async {
    //DEMO
    var input = dummy_automations;
    _automations.clear();
    for (var automation in input) {
      switch (automation['typ']) {
        case 'BUTTON':
          _automations.add(ButtonAutomation(
            id: automation['id'] as int,
            name: automation['name'] as String,
            icon: null,
            button: automation['button'] as Button,
            actions: (automation['actions'] as List<Map<String, Object>>)
                .map<FunctionAction>((e) => FunctionAction.fromJson(e))
                .toList(),
          ));
          break;
        default:
          log("Error: Unknown device type");
      }
    }
  }

  Future<void> loadAutomations() async {
    _automations.clear();
    _automations.addAll(await client.getAutomations());
  }

  // Future<Device> addDevice(Device device) async {
  //   Device newdev = await client.addDevice(
  //     roomID: device.roomId,
  //     deviceType: device.type,
  //     slaveID: device.slaveID,
  //     name: device.name,
  //     pin: device.onSlavePin,
  //     pinDown: device.type == DeviceType.blind
  //         ? (device as Blind).onSlavePinDown
  //         : null,
  //   );
  //   _automations.add(newdev);
  //   return newdev;
  // }

  // Future<void> removeDevice(Device device) async {
  //   await client.deleteDevice(deviceID: device.id);
  //   _automations.remove(device);
  // }

  // Future<void> removeDeviceById(int deviceId) async {
  //   var dev = getDeviceById(deviceId);
  //   await removeDevice(dev);
  // }

  // Device getDeviceById(int deviceId) {
  //   return _automations.firstWhere((element) => element.id == deviceId);
  // }

  // Future<Device> updateDevice(Device newDevice) async {
  //   int index =
  //       _automations.indexWhere((element) => element.id == newDevice.id);
  //   if (index == -1) {
  //     return addDevice(newDevice);
  //   }
  //   if (_automations[index].type != newDevice.type) {
  //     //if type changed, remove old device and add new one
  //     await removeDevice(_automations[index]);
  //     Device dev = await addDevice(newDevice);
  //     return dev;
  //   }
  //   if (_automations[index].name != newDevice.name) {
  //     await client.updateDevice(deviceID: newDevice.id, name: newDevice.name);
  //   }
  //   if (_automations[index].slaveID != newDevice.slaveID) {
  //     await client.updateDevice(
  //         deviceID: newDevice.id, slaveId: newDevice.slaveID);
  //   }
  //   if (_automations[index].onSlavePin != newDevice.onSlavePin) {
  //     await client.updateDevice(
  //         deviceID: newDevice.id, pin: newDevice.onSlavePin);
  //   }
  //   if (_automations[index].type == DeviceType.blind) {
  //     if ((_automations[index] as Blind).onSlavePinDown !=
  //         (newDevice as Blind).onSlavePinDown) {
  //       await client.updateDevice(
  //           deviceID: newDevice.id, pinDown: newDevice.onSlavePinDown);
  //     }
  //   }
  //   if (_automations[index].roomId != newDevice.roomId) {
  //     await client.updateDevice(deviceID: newDevice.id, room: newDevice.roomId);
  //   }
  //   var updatedDevice = await client.getDevice(_automations[index].id);
  //   if (updatedDevice != newDevice) {
  //     throw Exception("Error: Device not updated");
  //   } else {
  //     _automations[index] = updatedDevice;
  //     log("Device updated");
  //   }
  //   return updatedDevice;
  // }

  // Future<void> updateStateOfDevices() async {
  //   var newStates = await client.getDevicesState();
  //   for (var device in _automations) {
  //     var newStateMap =
  //         newStates.where((element) => element['id'] == device.id);
  //     if (newStateMap.isNotEmpty) {
  //       var element = newStateMap.first;
  //       device.updateState(DeviceState.fromString(element['state']));
  //     }
  //   }
  // }

  // Future<void> updateListOfDevices() async {
  //   var newDevices = await client.getDevices();
  //   for (var device in newDevices) {
  //     if (!_automations.contains(device)) {
  //       _automations.add(device);
  //     }
  //   }
  // }
}

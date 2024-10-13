import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';
import 'package:flutter_smarthome/repositories/dummy_data/dummy_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/devices/blind.dart';
import '../models/devices/device.dart';
import '../models/devices/fan.dart';
import '../models/devices/light.dart';
import '../models/devices/outlet.dart';

class DevicesRepository {
  final List<Device> _devices = [];

  RESTClient client = RESTClient();
  List<Device> get devices => [..._devices];
  List<Device> getDevicesByRoomId(int roomId) {
    return _devices.where((element) => element.roomId == roomId).toList();
  }

  Future<void> loadDemoData() async {
    //DEMO
    var input = dummy_devices;
    _devices.clear();
    for (var device in input) {
      switch (device['typ']) {
        case 'LIGHT':
          _devices.add(Light.fromJson(device));
          break;
        case 'BLIND':
          _devices.add(Blind.fromJson(device));
          break;
        case 'WENTYLATOR':
          _devices.add(Fan.fromJson(device));
          break;
        case 'GNIAZDKO':
          _devices.add(Outlet.fromJson(device));
          break;
        default:
          log("Error: Unknown device type");
      }
    }
  }

  Future<void> loadDevices() async {
    _devices.clear();
    _devices.addAll(await client.getDevices());
    for (var dev in _devices) {
      dev.isFav = true;
    }
  }

  Future<Device> addDevice(Device device) async {
    Device newdev = await client.addDevice(
      roomID: device.roomId,
      deviceType: device.type,
      slaveID: device.slaveID,
      name: device.name,
      pin: device.onSlavePin,
      pinDown: device.type == DeviceType.blind
          ? (device as Blind).onSlavePinDown
          : null,
    );
    _devices.add(newdev);
    return newdev;
  }

  Future<void> removeDevice(Device device) async {
    await client.deleteDevice(deviceID: device.id);
    _devices.remove(device);
  }

  Future<void> removeDeviceById(int deviceId) async {
    var dev = getDeviceById(deviceId);
    await removeDevice(dev);
  }

  Device getDeviceById(int deviceId) {
    return _devices.firstWhere((element) => element.id == deviceId);
  }

  Future<Device> updateDevice(Device newDevice) async {
    int index = _devices.indexWhere((element) => element.id == newDevice.id);
    if (index == -1) {
      return addDevice(newDevice);
    }
    if (_devices[index].type != newDevice.type) {
      //if type changed, remove old device and add new one
      await removeDevice(_devices[index]);
      Device dev = await addDevice(newDevice);
      return dev;
    }
    if (_devices[index].name != newDevice.name) {
      await client.updateDevice(deviceID: newDevice.id, name: newDevice.name);
    }
    if (_devices[index].slaveID != newDevice.slaveID) {
      await client.updateDevice(
          deviceID: newDevice.id, slaveId: newDevice.slaveID);
    }
    if (_devices[index].onSlavePin != newDevice.onSlavePin) {
      await client.updateDevice(
          deviceID: newDevice.id, pin: newDevice.onSlavePin);
    }
    if (_devices[index].type == DeviceType.blind) {
      if ((_devices[index] as Blind).onSlavePinDown !=
          (newDevice as Blind).onSlavePinDown) {
        await client.updateDevice(
            deviceID: newDevice.id, pinDown: newDevice.onSlavePinDown);
      }
    }
    if (_devices[index].roomId != newDevice.roomId) {
      await client.updateDevice(deviceID: newDevice.id, room: newDevice.roomId);
    }
    var updatedDevice = await client.getDevice(_devices[index].id);
    if (updatedDevice != newDevice) {
      throw Exception("Error: Device not updated");
    } else {
      _devices[index] = updatedDevice;
      log("Device updated");
    }
    return updatedDevice;
  }

  Future<void> updateStateOfDevices() async {
    var newStates = await client.getDevicesState();
    for (var device in _devices) {
      var newStateMap =
          newStates.where((element) => element['id'] == device.id);
      if (newStateMap.isNotEmpty) {
        var element = newStateMap.first;
        device.updateState(DeviceState.fromString(element['state']));
      }
    }
  }

  Future<void> updateListOfDevices() async {
    var newDevices = await client.getDevices();
    for (var device in newDevices) {
      if (!_devices.contains(device)) {
        _devices.add(device);
      }
    }
  }

  Future<void> loadFavorite() async {
    String favouriteDevices = await client.getFavoriteRooms();
    var favouriteRoomsList = favouriteDevices.split(",");
    log(favouriteRoomsList.toString());
    for (Device device in _devices) {
      if (favouriteRoomsList.contains(device.id.toString())) {
        device.isFav = true;
      }
    }
  }
}

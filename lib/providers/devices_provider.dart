import 'package:flutter/material.dart';
import 'package:flutter_smarthome/dummy_data/dummy_data.dart';

import '../models/devices/blind.dart';
import '../models/devices/device.dart';
import '../models/devices/fan.dart';
import '../models/devices/light.dart';
import '../models/devices/outlet.dart';

class DevicesProvider with ChangeNotifier {
  final List<Device> _devices = [
    Light(name: "Light 1", roomId: 1),
    Blind(name: "Blind 1", roomId: 1),
    Fan(name: "Outlet 1", roomId: 1),
    Fan(name: "Fan 1", roomId: 1),
  ];

  DevicesProvider() {
    fetchAndSetDevices();
  }

  List<Device> get devices => [..._devices];
  List<Device> getDevicesByRoomId(int roomId) {
    return _devices.where((element) => element.roomId == roomId).toList();
  }

  Future<void> fetchAndSetDevices() async {
    // TODO implement the http request

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
        case 'FAN':
          _devices.add(Fan.fromJson(device));
          break;
        case 'OUTLET':
          _devices.add(Outlet.fromJson(device));
          break;
        default:
          print("Error: Unknown device type");
      }
    }

    return Future.delayed(Duration(
        seconds:
            1)); // TODO change this line after implementing the http request
  }

  Future<void> addDevice(Device device) async {
    _devices.add(device);
    notifyListeners();
    return Future.delayed(Duration(
        seconds:
            1)); // TODO change this line after implementing the http request
  }

  Future<void> removeDevice(Device device) async {
    _devices.remove(device);
    notifyListeners();
    return Future.delayed(Duration(
        seconds:
            1)); // TODO change this line after implementing the http request
  }

  Device getDeviceById(int deviceId) {
    return _devices.firstWhere((element) => element.id == deviceId);
  }

  Future<void> updateDevice(Device newDevice) async {
    final index = _devices.indexWhere((element) => element.id == newDevice.id);
    if (index >= 0) {
      _devices[index] = newDevice;
      notifyListeners();
    }
    return Future.delayed(Duration(
        seconds:
            1)); //TODO change this line after implementing the http request
  }
}

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
  }

  Future<void> addDevice(Device device) async {
    _devices.add(device);
    return Future.delayed(const Duration(
        seconds:
            1)); // TODO change this line after implementing the http request
  }

  Future<void> removeDevice(Device device) async {
    _devices.remove(device);
    return Future.delayed(const Duration(
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
    }
    return Future.delayed(const Duration(
        seconds:
            1)); //TODO change this line after implementing the http request
  }

  Future<void> updateStateOfDevices() async {
    var newStates = await client.getDevicesState();
    for (var device in _devices) {
      var newStateMap =
          newStates.where((element) => element['id'] == device.id).first;
      device.updateState(DeviceState.fromString(newStateMap['state']));
    }
  }

  Future<void> updateListOfDevices() {
    //TODO download list of devices from server and compare with local list
    return Future.delayed(const Duration(
        seconds:
            1)); //TODO change this line after implementing the http request
  }
}

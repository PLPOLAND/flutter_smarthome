import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_smarthome/repositories/dummy_data/dummy_data.dart';

import '../models/devices/blind.dart';
import '../models/devices/device.dart';
import '../models/devices/fan.dart';
import '../models/devices/light.dart';
import '../models/devices/outlet.dart';

class DevicesRepository {
  final List<Device> _devices = [];

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
        case 'FAN':
          _devices.add(Fan.fromJson(device));
          break;
        case 'OUTLET':
          _devices.add(Outlet.fromJson(device));
          break;
        default:
          log("Error: Unknown device type");
      }
    }
  }

  Future<void> loadDevices() async {
    //TODO load from server
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

  Future<void> updateStateOfDevices() {
    //TODO update state of devices
    return Future.delayed(const Duration(
        seconds:
            1)); //TODO change this line after implementing the http request
  }

  Future<void> updateListOfDevices() {
    //TODO download list of devices from server and compare with local list
    return Future.delayed(const Duration(
        seconds:
            1)); //TODO change this line after implementing the http request
  }
}

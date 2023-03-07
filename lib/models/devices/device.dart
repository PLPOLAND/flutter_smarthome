import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Device with ChangeNotifier {
  int id;
  int roomId;
  int slaveId;
  int onSlaveId;
  int onSlavePin;
  String name;
  DeviceType type;
  DeviceState state;

  Device(this.id, this.roomId, this.slaveId, this.onSlaveId, this.name,
      this.type, this.state, this.onSlavePin);

  void setState(DeviceState state); // abstract setter for device state
  Future<void> changeState(); // abstract method for changing device state

  set room(int roomId) {
    this.roomId = roomId;
    notifyListeners();
  }

  set slave(int slaveId) {
    this.slaveId = slaveId;
    notifyListeners();
  }

  set onSlave(int onSlaveId) {
    this.onSlaveId = onSlaveId;
    notifyListeners();
  }

  set deviceName(String name) {
    this.name = name;
    notifyListeners();
  }

  set deviceType(DeviceType type) {
    this.type = type;
    notifyListeners();
  }

  DeviceType get deviceType => type;

  static IconData icon(DeviceType type) {
    switch (type) {
      case DeviceType.light:
        return Icons.lightbulb_outline;
      case DeviceType.outlet:
        return Icons.power;
      case DeviceType.blind:
        return Icons.blinds;
      case DeviceType.fan:
        return Icons.heat_pump;
      default:
        return Icons.error;
    }
  }

  @override
  String toString() {
    return ", id: $id, roomId: $roomId, slaveId: $slaveId, onSlaveId: $onSlaveId, name: $name, type: $type";
  }
}

// Types of devices
enum DeviceType {
  none,
  light,
  outlet,
  blind,
  fan,
}

// States of devices
enum DeviceState {
  none,
  on,
  off,
  up, //for blinds
  down, //for blinds
  middle, //for blinds
}

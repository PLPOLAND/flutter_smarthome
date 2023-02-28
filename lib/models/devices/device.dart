import 'package:flutter/foundation.dart';

abstract class Device with ChangeNotifier {
  int id;
  int roomId;
  int slaveId;
  int onSlaveId;
  String name;
  DeviceType type;
  DeviceState state;

  Device(this.id, this.roomId, this.slaveId, this.onSlaveId, this.name,
      this.type, this.state);

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

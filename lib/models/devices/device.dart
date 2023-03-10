import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Device with ChangeNotifier {
  int _id;
  int _roomId;
  int _slaveId;
  int _onSlaveId;
  int _onSlavePin;
  String _name;
  DeviceType _type;
  DeviceState _state;

  Device(this._id, this._roomId, this._slaveId, this._onSlaveId, this._name,
      this._type, this._state, this._onSlavePin);

  void setState(DeviceState state) {
    this._state = state;
    notifyListeners();
  }

  Future<void> changeState(); // abstract method for changing device state

  set id(int id) {
    this._id = id;
    notifyListeners();
  }

  set onSlavePin(int pin) {
    this._onSlavePin = pin;
    notifyListeners();
  }

  set roomId(int roomId) {
    this._roomId = roomId;
    notifyListeners();
  }

  set slaveID(int slaveId) {
    this._slaveId = slaveId;
    notifyListeners();
  }

  set onSlaveID(int onSlaveId) {
    this._onSlaveId = onSlaveId;
    notifyListeners();
  }

  set deviceName(String name) {
    this._name = name;
    notifyListeners();
  }

  set type(DeviceType type) {
    this._type = type;
    notifyListeners();
  }

  int get id => _id;
  int get onSlavePin => _onSlavePin;
  int get roomId => _roomId;
  int get slaveID => _slaveId;
  int get onSlaveID => _onSlaveId;
  String get name => _name;
  DeviceState get state => _state;

  DeviceType get type => _type;

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
    return ", id: $_id, roomId: $_roomId, slaveId: $_slaveId, onSlaveId: $_onSlaveId, name: $_name, type: $_type";
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

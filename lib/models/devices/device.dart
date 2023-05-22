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
    _state = state;
    notifyListeners();
  }

  Future<void> changeState(); // abstract method for changing device state

  set id(int id) {
    _id = id;
    notifyListeners();
  }

  set onSlavePin(int pin) {
    _onSlavePin = pin;
    notifyListeners();
  }

  set roomId(int roomId) {
    _roomId = roomId;
    notifyListeners();
  }

  set slaveID(int slaveId) {
    _slaveId = slaveId;
    notifyListeners();
  }

  set onSlaveID(int onSlaveId) {
    _onSlaveId = onSlaveId;
    notifyListeners();
  }

  set deviceName(String name) {
    _name = name;
    notifyListeners();
  }

  set type(DeviceType type) {
    _type = type;
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
        return Icons.power_outlined;
      case DeviceType.blind:
        return Icons.blinds_outlined;
      case DeviceType.fan:
        return Icons.heat_pump_outlined;
      default:
        return Icons.error_outline;
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
  middle; //for blinds

  @override
  String toString() {
    switch (this) {
      case DeviceState.none:
        return "none";
      case DeviceState.on:
        return "on";
      case DeviceState.off:
        return "off";
      case DeviceState.up:
        return "up";
      case DeviceState.down:
        return "down";
      case DeviceState.middle:
        return "middle";
      default:
        return "none";
    }
  }
}

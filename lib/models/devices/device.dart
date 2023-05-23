import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Device extends Cubit<DeviceCubitState> {
  Device(int id, int roomId, int slaveId, int onSlaveId, String name,
      DeviceType type, DeviceState state, int onSlavePin)
      : super(DeviceCubitState(
            id, roomId, slaveId, onSlaveId, name, type, state, onSlavePin));

  void setState(DeviceState newState) {
    state.state = newState;
  }

  Future<void> changeState(); // abstract method for changing device state

  set id(int id) {
    state.id = id;
    emit(state);
  }

  set onSlavePin(int pin) {
    state.onSlavePin = pin;
    emit(state);
  }

  set roomId(int roomId) {
    state.roomId = roomId;
    emit(state);
  }

  set slaveID(int slaveId) {
    state.slaveID = slaveId;
    emit(state);
  }

  set onSlaveID(int onSlaveId) {
    state.onSlaveID = onSlaveId;
    emit(state);
  }

  set deviceName(String name) {
    state.deviceName = name;
    emit(state);
  }

  set type(DeviceType type) {
    state.type = type;
    emit(state);
  }

  int get id => state.id;
  int get onSlavePin => state.onSlavePin;
  int get roomId => state.roomId;
  int get slaveID => state.slaveID;
  int get onSlaveID => state.onSlaveID;
  String get name => state.name;
  DeviceState get deviceState => state.deviceState;

  DeviceType get type => state.type;

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
  void onChange(Change<DeviceCubitState> change) {
    super.onChange(change);
    log(change.toString());
  }
}

class DeviceCubitState {
  int _id;
  int _roomId;
  int _slaveId;
  int _onSlaveId;
  int _onSlavePin;
  String _name;
  DeviceType _type;
  DeviceState _state;

  DeviceCubitState(this._id, this._roomId, this._slaveId, this._onSlaveId,
      this._name, this._type, this._state, this._onSlavePin);

  set state(DeviceState state) {
    _state = state;
  }

  set id(int id) {
    _id = id;
  }

  set onSlavePin(int pin) {
    _onSlavePin = pin;
  }

  set roomId(int roomId) {
    _roomId = roomId;
  }

  set slaveID(int slaveId) {
    _slaveId = slaveId;
  }

  set onSlaveID(int onSlaveId) {
    _onSlaveId = onSlaveId;
  }

  set deviceName(String name) {
    _name = name;
  }

  set type(DeviceType type) {
    _type = type;
  }

  int get id => _id;
  int get onSlavePin => _onSlavePin;
  int get roomId => _roomId;
  int get slaveID => _slaveId;
  int get onSlaveID => _onSlaveId;
  String get name => _name;
  DeviceState get deviceState => _state;

  DeviceType get type => _type;

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

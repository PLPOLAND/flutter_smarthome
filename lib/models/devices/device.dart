import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';

abstract class Device extends Cubit<DeviceCubitState> {
  Device(int id, int roomId, int slaveId, int onSlaveId, String name,
      DeviceType type, DeviceState state, int onSlavePin)
      : super(DeviceCubitState(
            id, roomId, slaveId, onSlaveId, name, type, state, onSlavePin));

  Device.state(DeviceCubitState state) : super(state);

  /// The function changes the state of the device. It sends a request to the server.
  void setState(DeviceState newState) {
    if (deviceState != newState) {
      RESTClient().changeDeviceState(deviceId: id, state: newState);
      emit(state.copyWith(state: newState));
    }
  }

  void setStateLocaly(DeviceState newState) {
    emit(state.copyWith(state: newState));
  }

  /// The function changes the state of the device. It does not send a request to the server.
  void updateState(DeviceState newState) {
    emit(state.copyWith(state: newState));
  }

  Future<void> changeState(); // abstract method for changing device state

  set id(int id) {
    emit(state.copyWith(id: id));
  }

  set onSlavePin(int pin) {
    emit(state.copyWith(onSlavePin: pin));
  }

  set roomId(int roomId) {
    emit(state.copyWith(roomId: roomId));
  }

  set slaveID(int slaveId) {
    emit(state.copyWith(slaveId: slaveId));
  }

  set onSlaveID(int onSlaveId) {
    emit(state.copyWith(onSlaveId: onSlaveId));
  }

  set deviceName(String name) {
    emit(state.copyWith(name: name));
  }

  set type(DeviceType type) {
    emit(state.copyWith(type: type));
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

  @override
  bool operator ==(Object other) {
    if (other is Device) {
      return id == other.id &&
          roomId == other.roomId &&
          slaveID == other.slaveID &&
          onSlaveID == other.onSlaveID &&
          name == other.name &&
          type == other.type &&
          onSlavePin == other.onSlavePin;
    }
    return false;
  }
}

class DeviceCubitState extends Equatable {
  final int _id;
  final int _roomId;
  final int _slaveId;
  final int _onSlaveId;
  final int _onSlavePin;
  final String _name;
  final DeviceType _type;
  final DeviceState _state;

  const DeviceCubitState(this._id, this._roomId, this._slaveId, this._onSlaveId,
      this._name, this._type, this._state, this._onSlavePin);

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
    return "{id: $_id, roomId: $_roomId, slaveId: $_slaveId, onSlaveId: $_onSlaveId, name: $_name, type: $_type, state: $_state}";
  }

  DeviceCubitState copyWith({
    int? id,
    int? roomId,
    int? slaveId,
    int? onSlaveId,
    String? name,
    DeviceType? type,
    DeviceState? state,
    int? onSlavePin,
  }) {
    return DeviceCubitState(
      id ?? _id,
      roomId ?? _roomId,
      slaveId ?? _slaveId,
      onSlaveId ?? _onSlaveId,
      name ?? _name,
      type ?? _type,
      state ?? _state,
      onSlavePin ?? _onSlavePin,
    );
  }

  @override
  List<Object?> get props => [
        _id,
        _roomId,
        _slaveId,
        _onSlaveId,
        _name,
        _type,
        _state,
        _onSlavePin,
      ];
}

// Types of devices
enum DeviceType {
  none,
  light,
  outlet,
  blind,
  fan;

  @override
  String toString() {
    switch (this) {
      case DeviceType.none:
        return "none";
      case DeviceType.light:
        return "light";
      case DeviceType.outlet:
        return "outlet";
      case DeviceType.blind:
        return "blind";
      case DeviceType.fan:
        return "fan";
      default:
        return "none";
    }
  }
}

// States of devices
enum DeviceState {
  none,
  on,
  off,
  up, //for blinds
  down, //for blinds
  middle, //for blinds
  run; //for blinds when they are moving

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
      case DeviceState.run:
        return "run";
      default:
        return "none";
    }
  }

  static DeviceState fromString(String state) {
    state = state.toLowerCase();
    switch (state) {
      case "none":
      case "stop": //for blinds in localButtonFunction
        return DeviceState.none;
      case "on":
        return DeviceState.on;
      case "off":
        return DeviceState.off;
      case "up":
        return DeviceState.up;
      case "down":
        return DeviceState.down;
      case "middle":
      case "notknow":
        return DeviceState.middle;
      case "run":
        return DeviceState.run;
      default:
        return DeviceState.none;
    }
  }
}

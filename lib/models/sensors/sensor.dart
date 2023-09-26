import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class Sensor extends Cubit<SensorCubitState> {
  Sensor(int id, int roomId, int slaveId, int onSlaveId, String name,
      SensorType type, List<int>? adress)
      : super(SensorCubitState(
            id, roomId, slaveId, onSlaveId, name, type, adress));

  Sensor.state(SensorCubitState state) : super(state);

  set id(int id) {
    emit(state.copyWith(id: id));
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

  set sensorName(String name) {
    emit(state.copyWith(name: name));
  }

  set sensorType(SensorType type) {
    emit(state.copyWith(type: type));
  }

  set sensorAdress(List<int> adress) {
    emit(state.copyWith(adress: adress));
  }

  int get id => state.id;
  int get roomId => state.roomId;
  int get slaveID => state.slaveId;
  int get onSlaveID => state.onSlaveId;
  String get name => state.name;
  SensorType get type => state.type;
  List<int>? get adress => state.adress;

  static IconData icon(SensorType type) {
    switch (type) {
      case SensorType.thermometer:
        return Icons.thermostat;
      case SensorType.hygrometer:
        return Icons.water_drop;
      case SensorType.hygroThermometer:
        return Icons.dew_point;
      case SensorType.twilight:
        return Icons.brightness_4;
      case SensorType.motion:
        return Icons.directions_run;
      case SensorType.button:
        return Icons.touch_app;
      default:
        return Icons.help;
    }
  }
}

class SensorCubitState extends Equatable {
  final int _id;
  final int _roomId;
  final int _slaveId;
  final int _onSlaveId;
  final String _name;
  final List<int>? _adress;
  final SensorType _type;

  const SensorCubitState(
    int id,
    int roomId,
    int slaveId,
    int onSlaveId,
    String name,
    SensorType type,
    List<int>? adress,
  )   : _id = id,
        _roomId = roomId,
        _slaveId = slaveId,
        _onSlaveId = onSlaveId,
        _name = name,
        _type = type,
        _adress = adress;

  int get id => _id;
  int get roomId => _roomId;
  int get slaveId => _slaveId;
  int get onSlaveId => _onSlaveId;
  String get name => _name;
  get adress => _adress;
  SensorType get type => _type;

  @override
  String toString() {
    return 'SensorCubitState{id: $id, roomId: $roomId, slaveId: $slaveId, onSlaveId: $onSlaveId, name: $name, adress: $_adress, type: $type}';
  }

  @override
  List<Object?> get props =>
      [id, roomId, slaveId, onSlaveId, name, _adress, type];

  SensorCubitState copyWith({
    int? id,
    int? roomId,
    int? slaveId,
    int? onSlaveId,
    String? name,
    List<int>? adress,
    SensorType? type,
  }) {
    return SensorCubitState(
      id ?? this.id,
      roomId ?? this.roomId,
      slaveId ?? this.slaveId,
      onSlaveId ?? this.onSlaveId,
      name ?? this.name,
      type ?? this.type,
      adress ?? _adress,
    );
  }
}

// Types of sensors
enum SensorType {
  none,
  thermometer,
  hygrometer,
  hygroThermometer,
  twilight,
  motion,
  button;

  @override
  String toString() {
    switch (this) {
      case SensorType.none:
        return "none";
      case SensorType.thermometer:
        return "thermometer";
      case SensorType.hygrometer:
        return "hygrometer";
      case SensorType.hygroThermometer:
        return "hygroThermometer";
      case SensorType.twilight:
        return "twilight";
      case SensorType.motion:
        return "motion";
      case SensorType.button:
        return "button";
      default:
        return "none";
    }
  }
}

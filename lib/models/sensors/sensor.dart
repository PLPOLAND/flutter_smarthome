import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';

abstract class Sensor extends Cubit<SensorCubitState> {
  Sensor(int id, int roomId, int slaveId, int onSlaveId, String name,
      SensorType type, List<int>? adress, bool? isFavorite)
      : super(SensorCubitState(id, roomId, slaveId, onSlaveId, name, type,
            adress, isFavorite ?? false));

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

  void setIsFav(bool fav, {bool setOnlyLocal = false}) {
    emit(state.copyWith(isFavorite: fav));
    if (!setOnlyLocal) {
      if (fav) {
        RESTClient().addFavoriteDevice(id);
      } else {
        RESTClient().removeFavoriteDevice(id);
      }
    }
  }

  int get id => state.id;
  int get roomId => state.roomId;
  int get slaveID => state.slaveId;
  int get onSlaveID => state.onSlaveId;
  String get name => state.name;
  SensorType get type => state.type;
  List<int>? get adress => state.adress;
  bool get isFavorite => state._isFavorite;

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
  final bool _isFavorite;

  const SensorCubitState(
    int id,
    int roomId,
    int slaveId,
    int onSlaveId,
    String name,
    SensorType type,
    List<int>? adress,
    bool isFavorite,
  )   : _id = id,
        _roomId = roomId,
        _slaveId = slaveId,
        _onSlaveId = onSlaveId,
        _name = name,
        _type = type,
        _adress = adress,
        _isFavorite = isFavorite;

  int get id => _id;
  int get roomId => _roomId;
  int get slaveId => _slaveId;
  int get onSlaveId => _onSlaveId;
  String get name => _name;
  get adress => _adress;
  SensorType get type => _type;
  bool get isFavorite => _isFavorite;

  @override
  String toString() {
    return 'SensorCubitState{id: $id, roomId: $roomId, slaveId: $slaveId, onSlaveId: $onSlaveId, name: $name, adress: $_adress, type: $type, isFavorite: $_isFavorite}';
  }

  @override
  List<Object?> get props =>
      [id, roomId, slaveId, onSlaveId, name, _adress, type, _isFavorite];

  SensorCubitState copyWith({
    int? id,
    int? roomId,
    int? slaveId,
    int? onSlaveId,
    String? name,
    List<int>? adress,
    SensorType? type,
    bool? isFavorite,
  }) {
    return SensorCubitState(
      id ?? this.id,
      roomId ?? this.roomId,
      slaveId ?? this.slaveId,
      onSlaveId ?? this.onSlaveId,
      name ?? this.name,
      type ?? this.type,
      adress ?? _adress,
      isFavorite ?? _isFavorite,
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

  bool isTemperature() {
    return this == SensorType.thermometer ||
        this == SensorType.hygroThermometer;
  }

  bool isHumidity() {
    return this == SensorType.hygrometer || this == SensorType.hygroThermometer;
  }

  bool isTwilight() {
    return this == SensorType.twilight;
  }

  bool isMotion() {
    return this == SensorType.motion;
  }

  bool isButton() {
    return this == SensorType.button;
  }

  static SensorType fromString(String type) {
    switch (type.toLowerCase()) {
      case "thermometer":
        return SensorType.thermometer;
      case "hygrometer":
        return SensorType.hygrometer;
      case "hygroThermometer":
        return SensorType.hygroThermometer;
      case "twilight":
        return SensorType.twilight;
      case "motion":
        return SensorType.motion;
      case "button":
        return SensorType.button;
      default:
        return SensorType.none;
    }
  }

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

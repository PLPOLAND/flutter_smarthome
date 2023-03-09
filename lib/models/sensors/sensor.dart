import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

abstract class Sensor with ChangeNotifier {
  int id;
  int roomId;
  int slaveId;
  int onSlaveId;
  String name;
  List<int>? adress;
  SensorType type;

  Sensor(this.id, this.roomId, this.slaveId, this.onSlaveId, this.name,
      this.type, this.adress);

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

  set sensorType(SensorType type) {
    this.type = type;
    notifyListeners();
  }

  set sensorAdress(List<int> adress) {
    if (adress.length > 8 || adress.isEmpty) {
      throw Exception("Invalid adress"); //TODO make custom exception
    }
    this.adress = adress;
    notifyListeners();
  }

  static IconData icon(SensorType type) {
    switch (type) {
      case SensorType.thermometer:
        return Icons.thermostat;
      case SensorType.hygrometer:
        return Icons.water_drop;
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

  @override
  String toString() {
    return ", id: $id, roomId: $roomId, slaveId: $slaveId, onSlaveId: $onSlaveId, name: $name, type: $type";
  }
}

// Types of sensors
enum SensorType {
  none,
  thermometer,
  hygrometer,
  twilight,
  motion,
  button,
}

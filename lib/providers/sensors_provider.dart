import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/sensors/hygrometer.dart';
import 'package:flutter_smarthome/models/sensors/motion.dart';
import 'package:flutter_smarthome/models/sensors/termometer.dart';
import 'package:flutter_smarthome/models/sensors/twilight.dart';

import '../models/sensors/sensor.dart';

class SensorsProvider with ChangeNotifier {
  final List<Sensor> _sensors = [
    Thermometer(name: "Termometr 1", temperature: 27, roomId: 1),
    Hygrometer(name: "Wilgotność 1", humidity: 0.55, roomId: 1),
    Twilight(name: "Zmierzch 1", value: 0.45, roomId: 1),
    Motion(name: "Ruch 1", isMotionDetected: true, roomId: 1),
  ];

  List<Sensor> get sensors => [..._sensors];

  List<Sensor> getSensorsByRoomId(int roomId) {
    return _sensors.where((sensor) => sensor.roomId == roomId).toList();
  }

  void addDevice(Sensor device) {
    _sensors.add(device);
    notifyListeners();
  }

  void removeDevice(Sensor device) {
    _sensors.remove(device);
    notifyListeners();
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/sensors/hygrometer.dart';
import 'package:flutter_smarthome/models/sensors/motion.dart';
import 'package:flutter_smarthome/models/sensors/thermometer.dart';
import 'package:flutter_smarthome/models/sensors/twilight.dart';

import '../repositories/dummy_data/dummy_data.dart';
import '../models/sensors/button.dart';
import '../models/sensors/sensor.dart';

class SensorsProvider with ChangeNotifier {
  final List<Sensor> _sensors = [
    Thermometer(id: 1, name: "Termometr 1", temperature: 27, roomId: 1),
    Hygrometer(id: 2, name: "Wilgotność 1", humidity: 0.55, roomId: 1),
    Twilight(id: 3, name: "Zmierzch 1", value: 0.45, roomId: 1, dayValue: 0.6),
    Motion(id: 4, name: "Ruch 1", isMotionDetected: true, roomId: 1),
  ];

  SensorsProvider() {
    fetchAndSetSensors();
  }

  Future<void> fetchAndSetSensors() async {
    // TODO implement the http request

    //DEMO
    var input = dummy_sensors;
    _sensors.clear();
    for (var sensor in input) {
      switch (sensor['typ']) {
        case 'THERMOMETR':
          _sensors.add(Thermometer.fromJson(sensor));
          break;
        case 'HYGROMETER':
          throw Exception("Not implemented yet");
          //TODO implement
          // _sensors.add(Hygrometer.fromJson(sensor));
          break;
        case 'TWILIGHT':
          throw Exception("Not implemented yet");
          //TODO implement
          // _sensors.add(Twilight.fromJson(sensor));
          break;
        case 'MOTION':
          throw Exception("Not implemented yet");
          //TODO implement
          // _sensors.add(Motion.fromJson(sensor));
          break;
        case 'BUTTON':
          // log("adding BUTTON");
          // var button = Button.fromJson(sensor);
          // log(button.toString());
          _sensors.add(Button.fromJson(sensor));
          break;
        default:
          print("Error: Unknown sensor type");
      }
    }
    // log(_sensors.toString());

    return Future.delayed(const Duration(seconds: 1));
  }

  List<Sensor> get sensors => [..._sensors];

  List<Sensor> getSensorsByRoomId(int roomId) {
    return _sensors.where((sensor) => sensor.roomId == roomId).toList();
  }

  Future<void> addSensor(Sensor device) async {
    _sensors.add(device);
    notifyListeners();
    Future.delayed(const Duration(seconds: 1));
  }

  Future<void> removeSensor(Sensor device) async {
    _sensors.remove(device);
    notifyListeners();
    Future.delayed(const Duration(seconds: 1));
  }

  getSensorById(int sensorId) {
    return _sensors.firstWhere((sensor) => sensor.id == sensorId);
  }

  updateDevice(Sensor newSensor) {
    final sensorIndex =
        _sensors.indexWhere((sensor) => sensor.id == newSensor.id);
    if (sensorIndex >= 0) {
      _sensors[sensorIndex] = newSensor;
      notifyListeners();
    } else {
      print("Error: Sensor not found");
    }
  }
}

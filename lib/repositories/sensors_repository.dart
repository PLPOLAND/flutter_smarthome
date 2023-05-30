import 'dart:developer';

import 'package:flutter_smarthome/models/sensors/thermometer.dart';

import '../repositories/dummy_data/dummy_data.dart';
import '../models/sensors/button.dart';
import '../models/sensors/sensor.dart';

class SensorsRepository {
  final List<Sensor> _sensors = [];

  Future<void> loadDemoData() async {
    // TODO implement the http request

    //DEMO
    var input = dummy_sensors;
    _sensors.clear();
    for (var sensor in input) {
      log(sensor.toString());
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

  Future<void> loadSensors() async {
    _sensors.clear();
    //TODO load from server
  }

  List<Sensor> get sensors => [..._sensors];

  List<Sensor> getSensorsByRoomId(int roomId) {
    return _sensors.where((sensor) => sensor.roomId == roomId).toList();
  }

  Future<void> addSensor(Sensor device) async {
    _sensors.add(device);
    Future.delayed(const Duration(seconds: 1));
  }

  Future<void> removeSensor(Sensor device) async {
    _sensors.remove(device);
    Future.delayed(const Duration(seconds: 1));
  }

  Sensor getSensorById(int sensorId) {
    return _sensors.firstWhere((sensor) => sensor.id == sensorId);
  }

  Future<void> updateSensor(Sensor newSensor) {
    final sensorIndex =
        _sensors.indexWhere((sensor) => sensor.id == newSensor.id);
    if (sensorIndex >= 0) {
      _sensors[sensorIndex] = newSensor;
    } else {
      print("Error: Sensor not found");
    }
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateListOfSensors() async {
    //TODO implement
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateStateOfSensors() async {
    //TODO implement
    return Future.delayed(const Duration(seconds: 1));
  }
}

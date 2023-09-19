import 'dart:developer';

import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';
import 'package:flutter_smarthome/models/sensors/hygro_termometer.dart';
import 'package:flutter_smarthome/models/sensors/thermometer.dart';
import 'package:flutter_smarthome/models/sensors/hygrometer.dart';

import '../repositories/dummy_data/dummy_data.dart';
import '../models/sensors/button.dart';
import '../models/sensors/sensor.dart';

class SensorsRepository {
  final List<Sensor> _sensors = [];

  RESTClient client = RESTClient();

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
        case 'THERMOMETR_HYGROMETR':
          _sensors.add(HygroThermometer.fromJson(sensor));
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
    _sensors.addAll(await client.getSensors());
  }

  List<Sensor> get sensors => [..._sensors];

  List<Sensor> getSensorsByRoomId(int roomId) {
    return _sensors.where((sensor) => sensor.roomId == roomId).toList();
  }

  Future<void> addSensor(Sensor device) async {
    Sensor newSensor = await client.addSensor(sensor: device);
    _sensors.add(newSensor);
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
    var newStates = await client.getSensorsState();
    for (var sensor in _sensors) {
      if (sensor is Button) {
        continue;
      }
      var newStateMap =
          newStates.where((element) => element['id'] == sensor.id);
      for (var state in newStateMap) {
        log(state.toString());
        switch (sensor.type) {
          case SensorType.button:
            //TODO implement
            break;
          case SensorType.thermometer:
            var thermometer = sensor as Thermometer;
            thermometer.temperature = state['state'][0] as double;
            break;
          case SensorType.hygrometer:
            var hygrometer = sensor as Hygrometer;
            hygrometer.humidity = (state['state'][1] as double).toInt();
            break;
          default:
            print("Error: Unknown sensor type");
        }
      }
    }
    return Future.delayed(const Duration(seconds: 1));
  }
}

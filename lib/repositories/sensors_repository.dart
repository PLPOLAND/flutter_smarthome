import 'dart:developer';

import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';
import 'package:flutter_smarthome/models/sensors/hygro_termometer.dart';
import 'package:flutter_smarthome/models/sensors/motion.dart';
import 'package:flutter_smarthome/models/sensors/thermometer.dart';
import 'package:flutter_smarthome/models/sensors/hygrometer.dart';
import 'package:flutter_smarthome/models/sensors/twilight.dart';

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

  Future<Sensor> addSensor(Sensor device) async {
    Sensor newSensor = await client.addSensor(sensor: device);
    _sensors.add(newSensor);
    return newSensor;
  }

  Future<void> removeSensor(Sensor sensor) async {
    if (await client.removeSensor(sensorID: sensor.id)) {
      _sensors.remove(sensor);
    } else {
      throw Exception("Error: Sensor not found");
    }
  }

  Sensor getSensorById(int sensorId) {
    return _sensors.firstWhere((sensor) => sensor.id == sensorId);
  }

  Future<Sensor> updateSensor(Sensor newSensor) async {
    final sensorIndex =
        _sensors.indexWhere((sensor) => sensor.id == newSensor.id);
    if (sensorIndex == -1) {
      return addSensor(newSensor);
    } else if (sensorIndex >= 0) {
      if (_sensors[sensorIndex].type != newSensor.type) {
        //if type changed, remove old device and add new one
        await removeSensor(_sensors[sensorIndex]);
        Sensor sensor = await addSensor(newSensor);
        return sensor;
      }
      if (_sensors[sensorIndex].name != newSensor.name) {
        await client.updateSensor(sensorID: newSensor.id, name: newSensor.name);
      }
      if (_sensors[sensorIndex].roomId != newSensor.roomId) {
        await client.updateSensor(
            sensorID: newSensor.id, roomId: newSensor.roomId);
      }
      if (_sensors[sensorIndex].slaveID != newSensor.slaveID) {
        await client.updateSensor(
            sensorID: newSensor.id, slaveId: newSensor.slaveID);
      }
      if (_sensors[sensorIndex].type == SensorType.button ||
          _sensors[sensorIndex].type == SensorType.twilight ||
          _sensors[sensorIndex].type == SensorType.motion) {
        if (_sensors[sensorIndex] is Button) {
          if ((_sensors[sensorIndex] as Button).onSlavePin !=
              (newSensor as Button).onSlavePin) {
            await client.updateSensor(
                sensorID: newSensor.id, pin: newSensor.onSlavePin);
          }
          if ((_sensors[sensorIndex] as Button).localFunctions !=
              (newSensor as Button).localFunctions) {
            await client.updateSensor(
                sensorID: newSensor.id,
                localFunctions: newSensor.localFunctions);
          }
        } else if (_sensors[sensorIndex] is Twilight) {
          if ((_sensors[sensorIndex] as Twilight).onSlavePin !=
              (newSensor as Twilight).onSlavePin) {
            await client.updateSensor(
                sensorID: newSensor.id, pin: newSensor.onSlavePin);
          }
        } else if (_sensors[sensorIndex] is Motion) {
          if ((_sensors[sensorIndex] as Motion).onSlavePin !=
              (newSensor as Motion).onSlavePin) {
            await client.updateSensor(
                sensorID: newSensor.id, pin: newSensor.onSlavePin);
          }
        }
      }
      _sensors[sensorIndex] = newSensor;
      return newSensor;
    } else {
      throw Exception("Error: Sensor not found");
    }
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

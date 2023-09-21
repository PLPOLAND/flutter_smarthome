import 'sensor.dart';

/// A Hygrometer is a Sensor that measures humidity.
/// @param id - id of the sensor, set by SmartHomeHost
/// @param roomId - id of the room where the sensor is located
/// @param slaveId - slave board address where the sensor is connected
/// @param onSlaveId - id of HygrometerSensor on slave board
/// @param name - name of the sensor
/// @param humidity - humidity measured by the sensor
/// @param adress - adress of the sensor
///
/////TODO change to extends Thermometer
class Hygrometer extends Sensor {
  Hygrometer(
      {int id = -1,
      required int roomId,
      int slaveId = -1,
      int onSlaveId = -1,
      required String name,
      List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
      int humidity = 0})
      : super.state(HygrometerCubitState(
            id: id,
            roomId: roomId,
            slaveId: slaveId,
            onSlaveId: onSlaveId,
            name: name,
            adress: adress,
            humidity: humidity));

  set humidity(int humidity) {
    if (humidity < 0 || humidity > 100) {
      throw Exception("Invalid higro"); //TODO make custom exception
    }
    HygrometerCubitState st = state as HygrometerCubitState;
    emit(st.copyWith(humidity: humidity));
  }

  int get humidity => (state as HygrometerCubitState).humidity;

  @override
  String toString() {
    return "Hygrometer: ${super.toString()}, humidity: $humidity";
  }

  static Hygrometer fromJson(Map<String, dynamic> sensor) {
    return Hygrometer(
      id: sensor['id'] as int,
      roomId: sensor['room'] as int,
      slaveId: sensor['slaveAdress'] as int,
      onSlaveId: sensor['onSlaveID'] as int,
      name: (sensor['name'] ?? sensor['nazwa']) as String,
      humidity: sensor['humidity'] as int,
    );
  }

  /// Returns humidity as a string with 0 decimal places (e.g. 0.5 -> 50)
  /// @return humidity as a string with 0 decimal places
  String humidityToString() {
    return humidity.toStringAsFixed(0);
  }
}

class HygrometerCubitState extends SensorCubitState {
  late final int _humidity;

  HygrometerCubitState(
      {int id = -1,
      required int roomId,
      int slaveId = -1,
      int onSlaveId = -1,
      required String name,
      List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
      int humidity = 0})
      : super(id, roomId, slaveId, onSlaveId, name, SensorType.hygrometer,
            adress) {
    if (humidity < 0 || humidity > 100) {
      throw Exception(
          "Invalid higro: {$humidity}"); //TODO make custom exception
    }
    _humidity = humidity;
  }

  int get humidity => _humidity;

  @override
  String toString() {
    return "Hygrometer: ${super.toString()}, humidity: $_humidity";
  }

  /// Returns humidity as a string with 0 decimal places (e.g. 0.5 -> 50)
  /// @return humidity as a string with 0 decimal places
  String humidityToString() {
    return humidity.toString();
  }

  @override
  HygrometerCubitState copyWith(
      {int? id,
      int? roomId,
      int? slaveId,
      int? onSlaveId,
      String? name,
      SensorType? type,
      List<int>? adress,
      int? humidity}) {
    return HygrometerCubitState(
        id: id ?? this.id,
        roomId: roomId ?? this.roomId,
        slaveId: slaveId ?? this.slaveId,
        onSlaveId: onSlaveId ?? this.onSlaveId,
        name: name ?? this.name,
        adress: adress ?? this.adress,
        humidity: humidity ?? this.humidity);
  }
}

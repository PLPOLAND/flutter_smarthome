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
class Hygrometer extends Sensor {
  Hygrometer(
      {int id = -1,
      required int roomId,
      int slaveId = -1,
      int onSlaveId = -1,
      required String name,
      List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
      double humidity = 0})
      : super(id, roomId, slaveId, onSlaveId, name, SensorType.hygrometer,
            adress) {
    this.humidity = humidity;
  }

  double _humidity = -127.0;

  set humidity(double humidity) {
    if (humidity < 0 || humidity > 1) {
      throw Exception("Invalid higro"); //TODO make custom exception
    }
    _humidity = humidity;
    notifyListeners();
  }

  double get humidity => _humidity;

  @override
  String toString() {
    return "Hygrometer: ${super.toString()}, humidity: $_humidity";
  }

  String humidityToString() {
    return (_humidity * 100).toStringAsFixed(0);
  }
}

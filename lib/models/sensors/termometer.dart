import 'sensor.dart';

class Thermometer extends Sensor {
  /// Creates a thermometer sensor
  /// @param id - id of the sensor, set by SmartHomeHost
  /// @param roomId - id of the room where the sensor is located
  /// @param slaveId - slave board address where the sensor is connected
  /// @param onSlaveId - id of ThermometerSensor on slave board
  /// @param name - name of the sensor
  /// @param temperature - temperature measured by the sensor  (in Celsius)
  /// @param adress - adress of the sensor, set by SmartHomeHost
  Thermometer(
      {int id = -1,
      required int roomId,
      int slaveId = -1,
      int onSlaveId = -1,
      required String name,
      List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
      double temperature = -127.0})
      : super(id, roomId, slaveId, onSlaveId, name, SensorType.thermometer,
            adress) {
    temperature = temperature;
  }

  double _temperature = -127.0;

  set temperature(double temperature) {
    _temperature = temperature;
    notifyListeners();
  }

  double get temperature => _temperature;

  @override
  String toString() {
    return "Thermometer: ${super.toString()}, temperature: $_temperature";
  }

  String temperatureToString() {
    return _temperature.toStringAsFixed(1);
  }
}

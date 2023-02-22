import 'sensor.dart';

class Thermometer extends Sensor {
  Thermometer(
      {int id = -1,
      int roomId = -1,
      int slaveId = -1,
      int onSlaveId = -1,
      String name = "No name",
      SensorType type = SensorType.thermometer,
      List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
      double temperature = -127.0})
      : super(id, roomId, slaveId, onSlaveId, name, type, adress) {
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

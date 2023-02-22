import 'sensor.dart';

class Hygrometer extends Sensor {
  Hygrometer(
      {int id = -1,
      int roomId = -1,
      int slaveId = -1,
      int onSlaveId = -1,
      String name = "No name",
      SensorType type = SensorType.hygrometer,
      List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
      double humidity = 0})
      : super(id, roomId, slaveId, onSlaveId, name, type, adress) {
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

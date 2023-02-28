import 'sensor.dart';

class Twilight extends Sensor {
  Twilight(
      {int id = -1,
      int roomId = -1,
      int slaveId = -1,
      int onSlaveId = -1,
      String name = "No name",
      SensorType type = SensorType.twilight,
      double value = 0,
      this.dayValue = 0.6})
      : super(id, roomId, slaveId, onSlaveId, name, type, null) {
    this.value = value;
  }
  final double dayValue;
  double _value = 0;

  set value(double value) {
    if (value < 0) {
      throw Exception("Invalid value"); //TODO make custom exception
    }
    _value = value;
    // print("value: $_value, valueToString: ${valueToString()}, arg: $value");
    notifyListeners();
  }

  bool get isDay => _value >= dayValue;

  double get value => _value;

  @override
  String toString() {
    return "Twilight: ${super.toString()}, value: $_value";
  }

  String valueToString() {
    return (_value * 100).toStringAsFixed(0);
  }
}

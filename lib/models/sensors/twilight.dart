import 'sensor.dart';

class Twilight extends Sensor {
  int onSlavePin;
  final double dayValue;
  double _value = 0;

  /// Creates a twilight sensor
  /// @param id - id of the sensor, set by SmartHomeHost
  /// @param roomId - id of the room where the sensor is located
  /// @param slaveId - slave board address where the sensor is connected
  /// @param onSlaveId - id of TwilightSensor on slave board
  /// @param onSlavePin - pin on slave board where the sensor is connected
  /// @param name - name of the sensor
  /// @param value - value of the sensor
  Twilight({
    int id = -1,
    required int roomId,
    int slaveId = -1,
    int onSlaveId = -1,
    this.onSlavePin = -1,
    required String name,
    double value = 0,
    required this.dayValue,
  })  : _value = value,
        super(id, roomId, slaveId, onSlaveId, name, SensorType.twilight, null);

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

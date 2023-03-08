import 'sensor.dart';

class Button extends Sensor {
  int onSlavePin;

  /// Creates a button sensor
  /// @param id - id of the sensor, set by SmartHomeHost
  /// @param roomId - id of the room where the sensor is located
  /// @param slaveId - slave board address where the sensor is connected
  /// @param onSlaveId - id of ButtonSensor on slave board
  /// @param onSlavePin - pin on slave board where the sensor is connected
  /// @param name - name of the sensor
  ///
  ///
  Button({
    int id = -1,
    required int roomId,
    int slaveId = -1,
    int onSlaveId = -1,
    this.onSlavePin = -1,
    required String name,
  }) : super(id, roomId, slaveId, onSlaveId, name, SensorType.button, null);

  @override
  String toString() {
    return "Button: ${super.toString()}, onSlavePin: $onSlavePin";
  }
}

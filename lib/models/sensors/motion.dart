import 'sensor.dart';

class Motion extends Sensor {
  int onSlavePin;
  bool _isMotionDetected = false;

  /// Creates a motion sensor
  /// @param id - id of the sensor, set by SmartHomeHost
  /// @param roomId - id of the room where the sensor is located
  /// @param slaveId - slave board address where the sensor is connected
  /// @param onSlaveId - id of MotionSensor on slave board
  /// @param onSlavePin - pin on slave board where the sensor is connected
  /// @param name - name of the sensor
  /// @param isMotionDetected - is motion detected by the sensor
  Motion({
    int id = -1,
    required int roomId,
    int slaveId = -1,
    int onSlaveId = -1,
    this.onSlavePin = -1,
    required String name,
    bool isMotionDetected = false,
  }) : super(id, roomId, slaveId, onSlaveId, name, SensorType.motion, null) {
    motionDetected = isMotionDetected;
  }

  set motionDetected(bool isMotionDetected) {
    _isMotionDetected = isMotionDetected;
    notifyListeners();
  }

  bool get isMotionDetected => _isMotionDetected;

  @override
  String toString() {
    return "Motion: ${super.toString()}, isMotionDetected: $_isMotionDetected";
  }
}

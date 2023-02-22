import 'sensor.dart';

class Motion extends Sensor {
  Motion(
      {int id = -1,
      int roomId = -1,
      int slaveId = -1,
      int onSlaveId = -1,
      String name = "No name",
      SensorType type = SensorType.motion,
      List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
      bool isMotionDetected = false})
      : super(id, roomId, slaveId, onSlaveId, name, type, adress) {
    motionDetected = isMotionDetected;
  }

  bool _isMotionDetected = false;

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

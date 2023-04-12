import '../devices/device.dart';
import 'sensor.dart';

class Button extends Sensor {
  int onSlavePin;
  late List<ButtonLocalClickFunction> localFunctions;

  /// Creates a button sensor
  /// @param id - id of the sensor, set by SmartHomeHost
  /// @param roomId - id of the room where the sensor is located
  /// @param slaveId - slave board address where the sensor is connected
  /// @param onSlaveId - id of ButtonSensor on slave board
  /// @param onSlavePin - pin on slave board where the sensor is connected
  /// @param name - name of the sensor
  ///
  Button({
    int id = -1,
    required int roomId,
    int slaveId = -1,
    int onSlaveId = -1,
    required this.onSlavePin,
    required String name,
    List<ButtonLocalClickFunction>? localFunctions,
  }) : super(id, roomId, slaveId, onSlaveId, name, SensorType.button, null) {
    this.localFunctions = localFunctions ?? [];
  }

  @override
  String toString() {
    return "Button: ${super.toString()}, onSlavePin: $onSlavePin";
  }

  static Button fromJson(Map<String, dynamic> json) {
    return Button(
      id: json['id'],
      roomId: json['room'],
      slaveId: json['slaveAdress'],
      onSlaveId: json['onSlaveID'],
      onSlavePin: json['pin'],
      name: json['name'],
      localFunctions: json['funkcjeKlikniec']
          .map<ButtonLocalClickFunction>(
              (e) => ButtonLocalClickFunction.fromJson(e))
          .toList(),
    );
  }
}

/// A class that represents a function that is executed when a button is clicked.
/// The device must be connected to the same slave.
class ButtonLocalClickFunction {
  int deviceID;
  int clicks;

  ButtonLocalClickFunction({required this.deviceID, required this.clicks});

  static ButtonLocalClickFunction fromJson(Map<String, dynamic> json) {
    return ButtonLocalClickFunction(
      deviceID: json['device']['id'],
      clicks: json['clicks'],
    );
  }
}

import '../devices/device.dart';
import 'sensor.dart';

class Button extends Sensor {
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
    required int onSlavePin,
    required String name,
    List<ButtonLocalClickFunction>? localFunctions,
  }) : super.state(ButtonCubitState(
            id: id,
            roomId: roomId,
            slaveId: slaveId,
            onSlaveId: onSlaveId,
            name: name,
            type: SensorType.button,
            onSlavePin: onSlavePin,
            localFunctions: localFunctions ?? []));

  set onSlavePin(int pin) {
    ButtonCubitState st = state as ButtonCubitState;
    emit(st.copyWith(onSlavePin: pin));
  }

  int get onSlavePin => (state as ButtonCubitState).onSlavePin;

  set localFunctions(List<ButtonLocalClickFunction> functions) {
    ButtonCubitState st = state as ButtonCubitState;
    emit(st.copyWith(localFunctions: functions));
  }

  List<ButtonLocalClickFunction> get localFunctions =>
      (state as ButtonCubitState).localFunctions;

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
      name: json['name'] ?? json['nazwa'],
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
  DeviceState? state;

  ButtonLocalClickFunction(
      {required this.deviceID, required this.clicks, this.state});

  static ButtonLocalClickFunction fromJson(Map<String, dynamic> json) {
    return ButtonLocalClickFunction(
      deviceID: json['device']['id'],
      clicks: json['clicks'],
      state:
          json['state'] != null ? DeviceState.fromString(json['state']) : null,
    );
  }
}

class ButtonCubitState extends SensorCubitState {
  final int _onSlavePin;
  final List<ButtonLocalClickFunction> _localFunctions;

  const ButtonCubitState({
    int id = -1,
    required int roomId,
    int slaveId = -1,
    int onSlaveId = -1,
    required String name,
    required SensorType type,
    required int onSlavePin,
    required List<ButtonLocalClickFunction> localFunctions,
  })  : _onSlavePin = onSlavePin,
        _localFunctions = localFunctions,
        super(id, roomId, slaveId, onSlaveId, name, type, null);

  int get onSlavePin => _onSlavePin;
  List<ButtonLocalClickFunction> get localFunctions => _localFunctions;

  @override
  List<Object?> get props => [
        ...super.props,
        onSlavePin,
        localFunctions,
      ];

  @override
  String toString() {
    return "Button: ${super.toString()}, onSlavePin: $onSlavePin";
  }

  @override
  ButtonCubitState copyWith({
    int? id,
    int? roomId,
    int? slaveId,
    int? onSlaveId,
    String? name,
    List<int>? adress,
    SensorType? type,
    int? onSlavePin,
    List<ButtonLocalClickFunction>? localFunctions,
  }) {
    return ButtonCubitState(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      slaveId: slaveId ?? this.slaveId,
      onSlaveId: onSlaveId ?? this.onSlaveId,
      name: name ?? this.name,
      type: type ?? this.type,
      onSlavePin: onSlavePin ?? this.onSlavePin,
      localFunctions: localFunctions ?? this.localFunctions,
    );
  }
}

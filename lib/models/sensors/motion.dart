import 'sensor.dart';

class Motion extends Sensor {
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
    int onSlavePin = -1,
    required String name,
    bool isMotionDetected = false,
  }) : super.state(MotionCubitState(
          id: id,
          roomId: roomId,
          slaveId: slaveId,
          onSlaveId: onSlaveId,
          name: name,
          isMotionDetected: isMotionDetected,
          onSlavePin: onSlavePin,
        ));

  set motionDetected(bool isMotionDetected) {
    MotionCubitState st = state as MotionCubitState;
    emit(st.copyWith(isMotionDetected: isMotionDetected));
  }

  bool get isMotionDetected => (state as MotionCubitState).isMotionDetected;

  set onSlavePin(int pin) {
    MotionCubitState st = state as MotionCubitState;
    emit(st.copyWith(onSlavePin: pin));
  }

  int get onSlavePin => (state as MotionCubitState).onSlavePin;

  @override
  String toString() {
    return "Motion: ${super.toString()}, isMotionDetected: $isMotionDetected, onSlavePin: $onSlavePin";
  }

  static Motion fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}

class MotionCubitState extends SensorCubitState {
  final bool _isMotionDetected;
  final int _onSlavePin;

  const MotionCubitState({
    int id = -1,
    required int roomId,
    int slaveId = -1,
    int onSlaveId = -1,
    onSlavePin = -1,
    required String name,
    bool isMotionDetected = false,
  })  : _onSlavePin = onSlavePin,
        _isMotionDetected = isMotionDetected,
        super(id, roomId, slaveId, onSlaveId, name, SensorType.motion, null);

  bool get isMotionDetected => _isMotionDetected;
  int get onSlavePin => _onSlavePin;

  @override
  List<Object?> get props => [
        ...super.props,
        _isMotionDetected,
        onSlavePin,
      ];

  @override
  String toString() {
    return "Motion: ${super.toString()}, isMotionDetected: $_isMotionDetected";
  }

  @override
  MotionCubitState copyWith({
    int? id,
    int? roomId,
    int? slaveId,
    int? onSlaveId,
    String? name,
    List<int>? adress,
    SensorType? type,
    bool? isMotionDetected,
    int? onSlavePin,
  }) {
    return MotionCubitState(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      slaveId: slaveId ?? this.slaveId,
      onSlaveId: onSlaveId ?? this.onSlaveId,
      name: name ?? this.name,
      isMotionDetected: isMotionDetected ?? this.isMotionDetected,
      onSlavePin: onSlavePin ?? this.onSlavePin,
    );
  }
}

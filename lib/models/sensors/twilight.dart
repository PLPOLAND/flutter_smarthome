import 'sensor.dart';

class Twilight extends Sensor {
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
    onSlavePin = -1,
    required String name,
    double value = 0,
    required dayValue,
  }) : super.state(TwilightCubitState(
            id: id,
            roomId: roomId,
            slaveId: slaveId,
            onSlavePin: onSlavePin,
            onSlaveId: onSlaveId,
            name: name,
            value: value,
            dayValue: dayValue));

  set value(double value) {
    if (value < 0) {
      throw Exception("Invalid value"); //TODO make custom exception
    }
    TwilightCubitState st = state as TwilightCubitState;
    emit(st.copyWith(value: value));
  }

  set onSlavePin(int pin) {
    TwilightCubitState st = state as TwilightCubitState;
    emit(st.copyWith(onSlavePin: pin));
  }

  set dayValue(double dayValue) {
    TwilightCubitState st = state as TwilightCubitState;
    emit(st.copyWith(dayValue: dayValue));
  }

  bool get isDay => (state as TwilightCubitState).isDay;

  double get value => (state as TwilightCubitState).value;

  int get onSlavePin => (state as TwilightCubitState).onSlavePin;

  double get dayValue => (state as TwilightCubitState).dayValue;

  @override
  String toString() {
    return "Twilight: ${super.toString()}, value: $value";
  }

  String valueToString() {
    return (value * 100).toStringAsFixed(0);
  }

  static fromJson(Map<String, dynamic> sensor) {
    throw UnimplementedError();
  }
}

class TwilightCubitState extends SensorCubitState {
  final double _value;
  final int _onSlavePin;
  final double _dayValue;

  const TwilightCubitState(
      {int id = -1,
      required int roomId,
      int slaveId = -1,
      int onSlaveId = -1,
      required onSlavePin,
      required String name,
      double value = 0,
      required dayValue})
      : _dayValue = dayValue,
        _onSlavePin = onSlavePin,
        _value = value,
        super(id, roomId, slaveId, onSlaveId, name, SensorType.twilight, null);

  bool get isDay => _value >= _dayValue;
  double get value => _value;
  int get onSlavePin => _onSlavePin;
  double get dayValue => _dayValue;

  @override
  String toString() {
    return "Twilight: ${super.toString()}, value: $_value, dayValue: $dayValue";
  }

  @override
  List<Object?> get props => super.props..add(_value);

  String valueToString() {
    return (_value * 100).toStringAsFixed(0);
  }

  @override
  TwilightCubitState copyWith({
    int? id,
    int? roomId,
    int? slaveId,
    int? onSlaveId,
    String? name,
    List<int>? adress,
    SensorType? type,
    double? value,
    int? onSlavePin,
    double? dayValue,
  }) {
    return TwilightCubitState(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      slaveId: slaveId ?? this.slaveId,
      onSlaveId: onSlaveId ?? this.onSlaveId,
      name: name ?? this.name,
      value: value ?? this.value,
      onSlavePin: onSlavePin ?? this.onSlavePin,
      dayValue: dayValue ?? this.dayValue,
    );
  }
}

import 'sensor.dart';

class Thermometer extends Sensor {
  /// Creates a thermometer sensor
  /// @param id - id of the sensor, set by SmartHomeHost
  /// @param roomId - id of the room where the sensor is located
  /// @param slaveId - slave board address where the sensor is connected
  /// @param onSlaveId - id of ThermometerSensor on slave board
  /// @param name - name of the sensor
  /// @param temperature - temperature measured by the sensor  (in Celsius)
  /// @param adress - adress of the sensor, set by SmartHomeHost
  Thermometer(
      {int id = -1,
      required int roomId,
      int slaveId = -1,
      int onSlaveId = -1,
      required String name,
      List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
      double temperature = -127.0})
      : super.state(ThermometerCubitState(
            id: id,
            roomId: roomId,
            slaveId: slaveId,
            onSlaveId: onSlaveId,
            name: name,
            adress: adress,
            temperature: temperature));

  set temperature(double temperature) {
    ThermometerCubitState st = state as ThermometerCubitState;
    emit(st.copyWith(temperature: temperature));
  }

  double get temperature => (state as ThermometerCubitState).temperature;

  @override
  String toString() {
    return "Thermometer: ${super.toString()}, temperature: ${(state as ThermometerCubitState)._temperature}";
  }

  String temperatureToString() {
    return (state as ThermometerCubitState).temperature.toStringAsFixed(1);
  }

  static Sensor fromJson(Map<String, Object> sensor) {
    return Thermometer(
      id: sensor['id'] as int,
      roomId: sensor['room'] as int,
      slaveId: sensor['slaveAdress'] as int,
      onSlaveId: sensor['onSlaveID'] as int,
      name: sensor['name'] as String,
      adress: (sensor['addres'] as List).cast<int>(),
      temperature: sensor['temperatura'] as double,
    );
  }
}

class ThermometerCubitState extends SensorCubitState {
  const ThermometerCubitState(
      {int id = -1,
      required int roomId,
      int slaveId = -1,
      int onSlaveId = -1,
      required String name,
      List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
      double temperature = -127.0})
      : _temperature = temperature,
        super(
          id,
          roomId,
          slaveId,
          onSlaveId,
          name,
          SensorType.thermometer,
          adress,
        );

  final double _temperature;
  double get temperature => _temperature;

  @override
  List<Object?> get props => super.props..add(_temperature);

  @override
  ThermometerCubitState copyWith({
    int? id,
    int? roomId,
    int? slaveId,
    int? onSlaveId,
    String? name,
    SensorType? type,
    List<int>? adress,
    double? temperature,
  }) {
    return ThermometerCubitState(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      slaveId: slaveId ?? this.slaveId,
      onSlaveId: onSlaveId ?? this.onSlaveId,
      name: name ?? this.name,
      adress: adress ?? this.adress,
      temperature: temperature ?? this.temperature,
    );
  }
}

import 'sensor.dart';
import 'hygrometer.dart';
import 'thermometer.dart';

class HygroThermometer extends Sensor {
  HygroThermometer({
    int id = -1,
    required int roomId,
    int slaveId = -1,
    int onSlaveId = -1,
    required String name,
    List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
    double temperature = -127.0,
    int humidity = 0,
  }) : super.state(HygroThermometerCubitState(
          id: id,
          roomId: roomId,
          slaveId: slaveId,
          onSlaveId: onSlaveId,
          name: name,
          adress: adress,
          temperature: temperature,
          humidity: humidity,
        ));

  set temperature(double temperature) {
    HygroThermometerCubitState st = state as HygroThermometerCubitState;
    emit(st.copyWith(temperature: temperature));
  }

  set humidity(int humidity) {
    if (humidity < 0 || humidity > 100) {
      throw Exception("Invalid higro"); //TODO make custom exception
    }
    HygroThermometerCubitState st = state as HygroThermometerCubitState;
    emit(st.copyWith(humidity: humidity));
  }

  double get temperature => (state as HygroThermometerCubitState).temperature;
  int get humidity => (state as HygroThermometerCubitState).humidity;

  @override
  String toString() {
    return 'HygroThermometer{id: $id, roomId: $roomId, slaveId: $slaveID, onSlaveId: $onSlaveID, name: $name, adress: $adress, temperature: $temperature, humidity: $humidity}';
  }

  String temperatureToString() {
    return (state as HygroThermometerCubitState).temperature.toStringAsFixed(1);
  }

  static Sensor fromJson(Map<String, dynamic> sensor) {
    return HygroThermometer(
      id: sensor['id'] as int,
      roomId: sensor['room'] as int,
      slaveId: sensor['slaveAdress'] as int,
      onSlaveId: sensor['onSlaveID'] as int,
      name: (sensor['name'] ?? sensor['nazwa']) as String,
      // adress: (sensor['addres'] as List).cast<int>(),
      temperature: sensor['temperatura'] as double,
      humidity: sensor['humidity'] as int,
    );
  }
}

class HygroThermometerCubitState extends SensorCubitState {
  final double _temperature;
  final int _humidity;

  HygroThermometerCubitState({
    int id = -1,
    required int roomId,
    int slaveId = -1,
    int onSlaveId = -1,
    required String name,
    List<int> adress = const [0, 0, 0, 0, 0, 0, 0, 0],
    double temperature = -127.0,
    int humidity = 0,
  })  : _humidity = humidity,
        _temperature = temperature,
        super(
          id,
          roomId,
          slaveId,
          onSlaveId,
          name,
          SensorType.hygroThermometer,
          adress,
        );

  double get temperature => _temperature;
  int get humidity => _humidity;

  @override
  List<Object?> get props => super.props
    ..add(_temperature)
    ..add(_humidity);

  @override
  HygroThermometerCubitState copyWith({
    int? id,
    int? roomId,
    int? slaveId,
    int? onSlaveId,
    String? name,
    SensorType? type,
    List<int>? adress,
    double? temperature,
    int? humidity,
  }) {
    return HygroThermometerCubitState(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      slaveId: slaveId ?? this.slaveId,
      onSlaveId: onSlaveId ?? this.onSlaveId,
      name: name ?? this.name,
      adress: adress ?? this.adress,
      temperature: temperature ?? this.temperature,
      humidity: humidity ?? this.humidity,
    );
  }
}

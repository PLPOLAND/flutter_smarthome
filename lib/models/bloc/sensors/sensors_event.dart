part of 'sensors_bloc.dart';

class SensorsEvent extends Equatable {
  const SensorsEvent();

  @override
  List<Object> get props => [];
}

class InitState extends SensorsEvent {}

///Load sensors from server, and start updating them time to time
class LoadSensors extends SensorsEvent {}

///Load demo data
class LoadDemoSensors extends SensorsEvent {}

///Update list of sensors
class UpdateSensors extends SensorsEvent {}

///Update state of sensors
class UpdateStateOfSensors extends SensorsEvent {}

///Stop updating sensors
class StopUpdatingSensors extends SensorsEvent {}

class ErrorEvent extends SensorsEvent {
  final String message;

  const ErrorEvent(this.message);
  ErrorEvent.exception(Exception e) : message = e.toString();

  @override
  List<Object> get props => [message];
}

class AddSensor extends SensorsEvent {
  final Sensor sensor;

  const AddSensor(this.sensor);

  @override
  List<Object> get props => [sensor];
}

class RemoveSensor extends SensorsEvent {
  final Sensor sensor;

  const RemoveSensor(this.sensor);

  @override
  List<Object> get props => [sensor];
}

class UpdateSensor extends SensorsEvent {
  final Sensor sensor;

  const UpdateSensor(this.sensor);

  @override
  List<Object> get props => [sensor];
}

//TODO add more?
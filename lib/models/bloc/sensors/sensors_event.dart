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

//TODO add more?
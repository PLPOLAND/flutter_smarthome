part of 'devices_bloc.dart';

class DevicesEvent extends Equatable {
  const DevicesEvent();

  @override
  List<Object> get props => [];
}

class InitState extends DevicesEvent {}

///Load devices from server, and start updating them time to time
class LoadDevices extends DevicesEvent {}

///Load demo data
class LoadDemo extends DevicesEvent {}

///Update list of devices
class UpdateDevices extends DevicesEvent {}

///Update state of devices
class UpdateStateOfDevices extends DevicesEvent {}

///Stop updating devices
class StopUpdatingDevicesList extends DevicesEvent {}

class Error extends DevicesEvent {
  final String message;

  const Error(this.message);

  @override
  List<Object> get props => [message];
}

class AddDevice extends DevicesEvent {
  final Device device;

  const AddDevice(this.device);

  @override
  List<Object> get props => [device];
}

class RemoveDevice extends DevicesEvent {
  final int id;

  const RemoveDevice(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateDevice extends DevicesEvent {
  final Device device;

  const UpdateDevice(this.device);

  @override
  List<Object> get props => [device];
}
//TODO add more?
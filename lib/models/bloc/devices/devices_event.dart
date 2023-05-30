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

//TODO add more?
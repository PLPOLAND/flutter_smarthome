part of 'devices_bloc.dart';

class DevicesEvent extends Equatable {
  const DevicesEvent();

  @override
  List<Object> get props => [];
}

class InitState extends DevicesEvent {}

class LoadDevices extends DevicesEvent {}

class LoadDemo extends DevicesEvent {}

class UpdateDevices extends DevicesEvent {}

class UpdateStateOfDevices extends DevicesEvent {}

//TODO add more?
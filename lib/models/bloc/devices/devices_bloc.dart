import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smarthome/repositories/device_repository.dart';

import '../../../repositories/dummy_data/dummy_data.dart';
import '../../devices/blind.dart';
import '../../devices/device.dart';
import '../../devices/fan.dart';
import '../../devices/light.dart';
import '../../devices/outlet.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  ///duration between updates of the list of devices
  final _deviceListUpdateInterval = const Duration(minutes: 5);

  ///duration between updates of the state of devices
  final _deviceStateUpdateInterval = const Duration(seconds: 1);

  DevicesRepository _devicesRepository;

  DevicesBloc(this._devicesRepository) : super(const DevicesState.initial()) {
    on<LoadDevices>((event, emit) async {
      emit(state.copyWith(status: DevicesStatus.loading));
      await _devicesRepository.loadDevices();
      //Update list of devices every 5 minutes
      Future.delayed(_deviceListUpdateInterval).then((value) {
        add(UpdateDevices());
      });
      //Update state of devices every 1 second
      Future.delayed(_deviceStateUpdateInterval).then((value) {
        add(UpdateStateOfDevices());
      });
      emit(state.copyWith(
        status: DevicesStatus.loaded,
        devices: _devicesRepository.devices,
      ));
    });
    on<LoadDemo>((event, emit) async {
      emit(state.copyWith(status: DevicesStatus.loading));
      await _devicesRepository.loadDemoData();
      emit(state.copyWith(
        status: DevicesStatus.demo,
        devices: _devicesRepository.devices,
      ));
    });
    on<UpdateDevices>((event, emit) async {
      emit(state.copyWith(status: DevicesStatus.updating));
      await _devicesRepository.updateListOfDevices();
      //rerun this event after 5 minutes
      Future.delayed(_deviceListUpdateInterval).then((value) {
        add(UpdateDevices());
      });
      emit(state.copyWith(status: DevicesStatus.loaded));
    });
    on<UpdateStateOfDevices>((event, emit) async {
      emit(state.copyWith(status: DevicesStatus.updating));
      await _devicesRepository.updateStateOfDevices();
      //rerun this event after 5 minutes
      Future.delayed(_deviceStateUpdateInterval).then((value) {
        add(UpdateDevices());
      });
      emit(state.copyWith(status: DevicesStatus.loaded));
    });
  }

  @override
  void onChange(Change<DevicesState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
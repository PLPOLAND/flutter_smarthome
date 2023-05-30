import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smarthome/repositories/device_repository.dart';

import '../../devices/device.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  ///duration between updates of the list of devices
  final _deviceListUpdateInterval = const Duration(minutes: 5);

  ///duration between updates of the state of devices
  final _deviceStateUpdateInterval = const Duration(seconds: 1);

  final DevicesRepository _devicesRepository;

  DevicesBloc(this._devicesRepository) : super(DevicesState.initial()) {
    on<LoadDevices>((event, emit) async {
      emit(state.copyWith(status: DevicesStatus.loading, stopUpdating: false));
      await _devicesRepository.loadDevices();
      add(UpdateDevices());
      add(UpdateStateOfDevices());
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
      log('Updating list of devices');
      emit(state.copyWith(status: DevicesStatus.updating));
      await _devicesRepository.updateListOfDevices();
      //rerun this event after time
      Future.delayed(_deviceListUpdateInterval).then((value) {
        if (!state.stopUpdating) {
          add(UpdateDevices());
        }
      });
      emit(state.copyWith(status: DevicesStatus.loaded));
    });
    on<UpdateStateOfDevices>((event, emit) async {
      log('Updating state of devices');
      emit(state.copyWith(status: DevicesStatus.updating));
      await _devicesRepository.updateStateOfDevices();
      //rerun this event after time
      Future.delayed(_deviceStateUpdateInterval).then((value) {
        if (!state.stopUpdating) {
          add(UpdateStateOfDevices());
        }
      });
      emit(state.copyWith(status: DevicesStatus.loaded));
    });
    on<StopUpdatingDevicesList>((event, emit) async {
      log('Stop updating devices');
      emit(state.copyWith(stopUpdating: true));
    });
  }

  @override
  void onChange(Change<DevicesState> change) {
    log(change.toString());
    super.onChange(change);
  }
}

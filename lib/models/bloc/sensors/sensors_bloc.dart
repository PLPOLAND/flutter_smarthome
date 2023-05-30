import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smarthome/models/sensors/sensor.dart';

import '../../../repositories/sensors_repository.dart';

part 'sensors_event.dart';
part 'sensors_state.dart';

class SensorsBloc extends Bloc<SensorsEvent, SensorsState> {
  ///duration between updates of the list of devices
  final _deviceListUpdateInterval = const Duration(minutes: 5);

  ///duration between updates of the state of devices
  final _deviceStateUpdateInterval = const Duration(seconds: 5);

  final SensorsRepository _sensorsRepository;

  SensorsBloc(this._sensorsRepository) : super(const SensorsState.initial()) {
    on<LoadSensors>((event, emit) async {
      emit(state.copyWith(status: SensorsStatus.loading, stopUpdating: false));
      await _sensorsRepository.loadSensors();
      add(UpdateSensors());
      add(UpdateStateOfSensors());
      emit(state.copyWith(
        status: SensorsStatus.loaded,
        sensors: _sensorsRepository.sensors,
      ));
    });
    on<LoadDemoSensors>((event, emit) async {
      emit(state.copyWith(status: SensorsStatus.loading));
      await _sensorsRepository.loadDemoData();
      log('Demo data loaded');
      log(_sensorsRepository.sensors.toString());
      emit(state.copyWith(
        status: SensorsStatus.demo,
        sensors: _sensorsRepository.sensors,
      ));
    });
    on<UpdateSensors>((event, emit) async {
      log('Updating list of sensors');
      emit(state.copyWith(status: SensorsStatus.updating));
      await _sensorsRepository.updateListOfSensors();
      //rerun this event after time
      Future.delayed(_deviceListUpdateInterval).then((value) {
        if (!state.stopUpdating) {
          add(UpdateSensors());
        }
      });
      emit(state.copyWith(status: SensorsStatus.loaded));
    });
    on<UpdateStateOfSensors>((event, emit) async {
      log('Updating state of sensors');
      emit(state.copyWith(status: SensorsStatus.updating));
      await _sensorsRepository.updateStateOfSensors();
      //rerun this event after time
      Future.delayed(_deviceStateUpdateInterval).then((value) {
        if (!state.stopUpdating) {
          add(UpdateStateOfSensors());
        }
      });
      emit(state.copyWith(status: SensorsStatus.loaded));
    });
    on<StopUpdatingSensors>((event, emit) async {
      log('Stop updating sensors');
      emit(state.copyWith(stopUpdating: true));
    });
  }

  @override
  void onChange(Change<SensorsState> change) {
    log(change.toString());
    super.onChange(change);
  }
}

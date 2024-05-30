import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/automations/automation.dart';
import 'package:flutter_smarthome/models/sensors/sensor.dart';
import 'package:flutter_smarthome/repositories/automations_repository.dart';

import '../../../repositories/sensors_repository.dart';

part 'automations_event.dart';
part 'automations_state.dart';

class AutomationsBloc extends Bloc<AutomationsEvent, AutomationsState> {
  ///duration between updates of the list of devices
  final _automationsListUpdateInterval = const Duration(minutes: 5);

  ///duration between updates of the state of devices
  final _automationsStateUpdateInterval = const Duration(seconds: 5);

  final AutomationsRepository _automationsRepository;

  AutomationsBloc(this._automationsRepository)
      : super(const AutomationsState.initial()) {
    on<LoadAutomations>((event, emit) async {
      log("Loading Automations");
      emit(state.copyWith(
          status: AutomationStatus.loading, stopUpdating: false));
      await _automationsRepository.loadAutomations();
      add(UpdateAutomations());
      add(UpdateStateOfAutomations());
      emit(state.copyWith(
        status: AutomationStatus.loaded,
        automation: _automationsRepository.automations,
      ));
    });
    on<LoadDemoAutomations>((event, emit) async {
      emit(state.copyWith(status: AutomationStatus.loading));
      await _automationsRepository.loadDemoData();
      log('Demo data loaded');
      log(_automationsRepository.automations.toString());
      emit(state.copyWith(
        status: AutomationStatus.demo,
        automation: _automationsRepository.automations,
      ));
    });
    on<UpdateAutomations>((event, emit) async {
      log('Updating list of sensors');
      // emit(state.copyWith(status: AutomationStatus.updating));
      // // await _sensorsRepository.updateListOfSensors();
      // //rerun this event after time
      // Future.delayed(_automationsListUpdateInterval).then((value) {
      //   if (!state.stopUpdating) {
      //     add(UpdateAutomations());
      //   }
      // });
      // emit(state.copyWith(status: AutomationStatus.loaded));
    });
    on<UpdateStateOfAutomations>((event, emit) async {
      // log('Updating state of sensors');
      // emit(state.copyWith(status: AutomationStatus.updating));
      // // await _sensorsRepository.updateStateOfSensors();
      // //rerun this event after time
      // Future.delayed(_automationsStateUpdateInterval).then((value) {
      //   if (!state.stopUpdating) {
      //     add(UpdateStateOfAutomations());
      //   }
      // });
      // emit(state.copyWith(status: AutomationStatus.loaded));
    });
    on<StopUpdatingAutomations>((event, emit) async {
      log('Stop updating sensors');
      emit(state.copyWith(stopUpdating: true));
    });
    on<AddAutomation>((event, emit) async {
      log('Adding sensor');
      // emit(state.copyWith(status: AutomationStatus.adding));
      // try {
      //   await _sensorsRepository.addSensor(event.automation);
      // } on Exception catch (e) {
      //   log('Error adding sensor: $e');
      //   add(ErrorEvent.exception(e));
      //   return;
      // }
      // emit(state.copyWith(
      //   status: AutomationStatus.loaded,
      //   sensors: _sensorsRepository.sensors,
      // ));
    });
    on<UpdateAutomation>((event, emit) async {
      log('Updating sensor');
      // emit(state.copyWith(status: AutomationStatus.updatingSensor));
      // try {
      //   await _sensorsRepository.updateSensor(event.automation);
      // } on Exception catch (e) {
      //   log('Error updating sensor: $e');
      //   add(ErrorEvent.exception(e));
      // }
      // emit(state.copyWith(
      //   status: AutomationStatus.loaded,
      //   sensors: _sensorsRepository.sensors,
      // ));
    });
    on<RemoveAutomation>((event, emit) async {
      log('Removing sensor');
      // emit(state.copyWith(status: AutomationStatus.removing));
      // try {
      //   await _sensorsRepository.removeSensor(event.sensor);
      // } on Exception catch (e) {
      //   log('Error removing sensor: $e');
      //   add(ErrorEvent.exception(e));
      // }
      // emit(state.copyWith(
      //   status: AutomationStatus.loaded,
      //   sensors: _sensorsRepository.sensors,
      // ));
    });
    on<ErrorEvent>((event, emit) async {
      log('Error: ${event.message}');
      var tmpstate = state;
      emit(state.copyWith(
          status: AutomationStatus.error, errorMsg: event.message));
      emit(tmpstate);
    });
  }

  @override
  void onChange(Change<AutomationsState> change) {
    log('-----------------AUTOMATIONS----State----Changed----------------------------');
    log(change.toString());
    super.onChange(change);
  }
}

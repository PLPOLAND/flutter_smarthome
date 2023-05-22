import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../devices/device.dart';

part 'devices_event.dart';
part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  DevicesBloc() : super(const DevicesState.initial()) {
    on<LoadDevices>((event, emit) {
      emit(const DevicesState.loading());
      //TODO load devices
      emit(const DevicesState.loaded(devices: [], favoriteDevices: []));
    });
    //TODO add more
  }
}

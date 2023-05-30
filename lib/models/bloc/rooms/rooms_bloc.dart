import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/rooms_repository.dart';
import '../../room.dart';

part 'rooms_event.dart';
part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  ///duration between updates of the list of rooms
  final _roomListUpdateInterval = const Duration(minutes: 5);

  final RoomsRepository _roomsRepository;

  RoomsBloc(this._roomsRepository) : super(const RoomsState.initial()) {
    on<LoadRooms>((event, emit) async {
      emit(state.copyWith(status: RoomsStatus.loading, stopUpdating: false));
      await _roomsRepository.loadRooms();
      add(UpdateRooms());
      emit(state.copyWith(
        status: RoomsStatus.loaded,
        rooms: _roomsRepository.rooms,
      ));
    });
    on<LoadDemoRooms>((event, emit) async {
      emit(state.copyWith(status: RoomsStatus.loading));
      await _roomsRepository.loadDemoData();
      log('Rooms demo data loaded');
      log(_roomsRepository.rooms.toString());
      emit(state.copyWith(
        status: RoomsStatus.demo,
        rooms: _roomsRepository.rooms,
      ));
    });
    on<UpdateRooms>((event, emit) async {
      log('Updating list of rooms');
      emit(state.copyWith(status: RoomsStatus.updating));
      await _roomsRepository.updateListOfRooms();
      //rerun this event after time
      Future.delayed(_roomListUpdateInterval).then((value) {
        if (!state.stopUpdating) {
          add(UpdateRooms());
        }
      });
      emit(state.copyWith(status: RoomsStatus.loaded));
    });
    on<StopUpdatingRoomsList>((event, emit) async {
      log('Stop updating rooms');
      emit(state.copyWith(stopUpdating: true));
    });
  }

  @override
  void onChange(Change<RoomsState> change) {
    super.onChange(change);
    log('RoomsBloc: $change');
  }
}

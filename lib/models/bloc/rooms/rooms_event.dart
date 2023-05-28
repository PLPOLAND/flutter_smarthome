part of 'rooms_bloc.dart';

class RoomsEvent extends Equatable {
  const RoomsEvent();

  @override
  List<Object> get props => [];
}

class InitState extends RoomsEvent {}

///Load rooms from server, and start updating them time to time
class LoadRooms extends RoomsEvent {}

///Load demo data
class LoadDemoRooms extends RoomsEvent {}

///Update list of rooms
class UpdateRooms extends RoomsEvent {}

///Stop updating rooms

class StopUpdatingRoomsList extends RoomsEvent {}

//TODO add more?
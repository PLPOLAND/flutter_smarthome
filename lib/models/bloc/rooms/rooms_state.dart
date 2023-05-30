part of 'rooms_bloc.dart';

enum RoomsStatus {
  initial,
  demo,
  loading,
  updating,
  loaded,
  error,
}

extension RoomsStatusExtension on RoomsStatus {
  bool get isInitial => this == RoomsStatus.initial;

  bool get isDemo => this == RoomsStatus.demo;

  bool get isLoading => this == RoomsStatus.loading;

  bool get isUpdating => this == RoomsStatus.updating;

  bool get isLoaded => this == RoomsStatus.loaded;

  bool get isError => this == RoomsStatus.error;
}

class RoomsState extends Equatable {
  final RoomsStatus status;
  final List<Room> rooms;
  final bool stopUpdating;

  const RoomsState._({
    this.status = RoomsStatus.initial,
    this.rooms = const [],
    this.stopUpdating = false,
  });

  const RoomsState.initial() : this._();

  const RoomsState.demo({
    required List<Room> rooms,
  }) : this._(rooms: rooms, status: RoomsStatus.demo);

  const RoomsState.loading() : this._(status: RoomsStatus.loading);

  const RoomsState.loaded({
    required List<Room> rooms,
  }) : this._(
          status: RoomsStatus.loaded,
          rooms: rooms,
        );

  const RoomsState.error() : this._(status: RoomsStatus.error);

  const RoomsState.updating() : this._(status: RoomsStatus.updating);

  @override
  List<Object> get props => [status, rooms, stopUpdating];

  @override
  String toString() =>
      'RoomsState { status: $status, rooms: ${rooms.length}, stopUpdating: $stopUpdating }';

  RoomsState copyWith({
    RoomsStatus? status,
    List<Room>? rooms,
    bool? stopUpdating,
  }) {
    return RoomsState._(
      status: status ?? this.status,
      rooms: rooms ?? this.rooms,
      stopUpdating: stopUpdating ?? this.stopUpdating,
    );
  }
}

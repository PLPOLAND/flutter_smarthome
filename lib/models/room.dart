import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Room extends Cubit<RoomCubitState> {
  Room({required int id, required String name, bool isFavorite = false})
      : super(RoomCubitState(id, name, isFavorite));

  String get name => state._name;
  int get id => state._id;
  bool get isFavorite => state._isFavorite;

  void setFavorite(bool isFavorite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var favouriteRooms = prefs.get("favouriteRooms") as String?;
    if (favouriteRooms != null) {
      var favouriteRoomsList = favouriteRooms.split(",");
      if (isFavorite) {
        favouriteRoomsList.add(id.toString());
      } else {
        favouriteRoomsList.remove(id.toString());
      }
      prefs.setString("favouriteRooms", favouriteRoomsList.join(","));
    } else {
      prefs.setString("favouriteRooms", id.toString());
    }
    emit(state.copyWith(isFavorite: isFavorite));
  }

  void toggleFavorite() async {
    log('toggleFavorite');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var favouriteRooms = prefs.get("favouriteRooms") as String?;
    if (favouriteRooms != null) {
      var favouriteRoomsList = favouriteRooms.split(",");
      if (state.isFavorite) {
        favouriteRoomsList.remove(id.toString());
      } else {
        favouriteRoomsList.add(id.toString());
      }
      prefs.setString("favouriteRooms", favouriteRoomsList.join(","));
    } else {
      prefs.setString("favouriteRooms", id.toString());
    }
    emit(state.copyWith(isFavorite: !state.isFavorite));
  }

  void setName(String newName) {
    emit(state.copyWith(name: newName));
  }

  void setId(int newId) {
    emit(state.copyWith(id: newId));
  }

  @override
  String toString() {
    return 'Room{id: $id, name: $name, isFavorite: $isFavorite}';
  }

  @override
  void onChange(Change<RoomCubitState> change) {
    super.onChange(change);
    log('RoomCubit: $change');
  }

  static Room fromJson(Map<String, dynamic> room) {
    log('fromJson: $room');
    return Room(
      id: room['id'] as int,
      name: room['name'] as String,
      isFavorite: room['isFavorite'] as bool? ?? false,
    );
  }
}

class RoomCubitState extends Equatable {
  final int _id;
  final String _name;
  final bool _isFavorite;

  const RoomCubitState(
    int id,
    String name,
    bool isFavorite,
  )   : _id = id,
        _name = name,
        _isFavorite = isFavorite;

  int get id => _id;
  String get name => _name;
  bool get isFavorite => _isFavorite;

  @override
  String toString() {
    return 'RoomCubitState{id: $id, name: $name, isFavorite: $isFavorite}';
  }

  @override
  List<Object?> get props => [id, name, isFavorite];

  RoomCubitState copyWith({
    int? id,
    String? name,
    bool? isFavorite,
  }) {
    return RoomCubitState(
      id ?? this.id,
      name ?? this.name,
      isFavorite ?? this.isFavorite,
    );
  }
}

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Room extends Cubit<RoomCubitState> {
  Room({required int id, required String name, bool isFavorite = false})
      : super(RoomCubitState(id, name, isFavorite));

  String get name => state._name;
  int get id => state._id;
  bool get isFavorite => state._isFavorite;

  void toggleFavorite() {
    log('toggleFavorite');
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

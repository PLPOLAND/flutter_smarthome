import 'package:flutter/material.dart';

import '../models/room.dart';

class RoomsProvider with ChangeNotifier {
  final List<Room> _rooms = [
    Room("Sypialnia", id: 1),
    Room("Kuchnia", id: 2),
    Room("Łazienka", id: 3),
    Room("Salon", id: 4),
  ];

  List<Room> get rooms => [..._rooms];
  Room getRoomById(int id) => _rooms.firstWhere((room) => room.id == id);

  Future<void> addRoom(Room room) async {
    _rooms.add(room);
    notifyListeners();
    return Future.delayed(const Duration(
        seconds: 1)); // todo remove this when http request is implemented
  }

  void removeRoom(Room room) {
    _rooms.remove(room);
    notifyListeners();
  }

  void removeRoomById(int id) {
    _rooms.removeWhere((room) => room.id == id);
    notifyListeners();
  }

  updateRoom(Room room) {
    final index = _rooms.indexWhere((element) => element.id == room.id);
    _rooms[index] = room;
    notifyListeners();
  }
}

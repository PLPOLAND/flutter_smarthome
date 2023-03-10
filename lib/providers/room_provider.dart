import 'package:flutter/material.dart';

import '../models/room.dart';

class RoomsProvider with ChangeNotifier {
  final List<Room> _rooms = [
    Room("", id: 0),
    Room("Garderoba", id: 1),
    Room("Marcin", id: 2),
    Room("Marek", id: 3),
    Room("Gościnny", id: 4),
    Room("Łazienka Mała", id: 5),
    Room("Łazienka Duża", id: 6),
    Room("Kotłownia", id: 7),
    Room("Korytarz", id: 8),
    Room("Rodzice", id: 9),
    Room("Salon", id: 10),
    Room("Kuchnia", id: 11),
    Room("Taras", id: 12),
    Room("Wiatrołap", id: 13),
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

import 'package:flutter/material.dart';

import '../models/room.dart';

class RoomsProvider with ChangeNotifier {
  final List<Room> _rooms = [
    Room(name: "Sypialnia", id: 1),
    Room(name: "Kuchnia", id: 2),
    Room(name: "Łazienka", id: 3),
    Room(name: "Salon", id: 4),
  ];

  List<Room> get rooms => [..._rooms];

  void addRoom(Room room) {
    _rooms.add(room);
    notifyListeners();
  }

  void removeRoom(Room room) {
    _rooms.remove(room);
    notifyListeners();
  }
}

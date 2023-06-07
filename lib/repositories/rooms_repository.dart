import "../helpers/rest_client/rest_client.dart";
import "../models/room.dart";

class RoomsRepository {
  final List<Room> _rooms = [];

  List<Room> get rooms => [..._rooms];

  final RESTClient client = RESTClient();

  Future<void> loadRooms() async {
    _rooms.clear();
    _rooms.addAll(await client.getRooms());
    //TODO load from server
  }

  Future<void> loadDemoData() async {
    //DEMO
    _rooms.addAll([
      Room(name: "", id: 0),
      Room(name: "Garderoba", id: 1),
      Room(name: "Marcin", id: 2),
      Room(name: "Marek", id: 3),
      Room(name: "Gościnny", id: 4),
      Room(name: "Łazienka Mała", id: 5),
      Room(name: "Łazienka Duża", id: 6),
      Room(name: "Kotłownia", id: 7),
      Room(name: "Korytarz", id: 8),
      Room(name: "Rodzice", id: 9),
      Room(name: "Salon", id: 10),
      Room(name: "Kuchnia", id: 11),
      Room(name: "Taras", id: 12),
      Room(name: "Wiatrołap", id: 13),
    ]);

    Future.delayed(const Duration(seconds: 1));
  }

  Room getRoomById(int id) => _rooms.firstWhere((room) => room.id == id);

  Future<void> addRoom(Room room) async {
    _rooms.add(room);
    return Future.delayed(const Duration(
        seconds: 1)); // todo remove this when http request is implemented
  }

  Future<void> removeRoom(Room room) {
    _rooms.remove(room);
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<void> removeRoomById(int id) {
    _rooms.removeWhere((room) => room.id == id);
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateRoom(Room room) {
    final index = _rooms.indexWhere((element) => element.id == room.id);
    _rooms[index] = room;
    return Future.delayed(const Duration(seconds: 1));
  }

  Future<void> updateListOfRooms() async {
    //TODO load from server
  }
}

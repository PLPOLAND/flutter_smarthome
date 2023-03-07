import 'package:flutter/foundation.dart';

class Room with ChangeNotifier {
  final int id;
  String _name;
  bool _isFavorite;

  Room(this._name, {this.id = -1, isFavorite = false})
      : _isFavorite = isFavorite;

  String get name => _name;

  bool get isFavorite => _isFavorite;

  void toggleFavorite() {
    print('toggleFavorite');
    _isFavorite = !_isFavorite;
    print('isFavorite: $_isFavorite');
    notifyListeners();
  }

  void setName(String newName) {
    _name = newName;
    notifyListeners();
  }
}

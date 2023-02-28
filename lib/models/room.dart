import 'package:flutter/foundation.dart';

class Room with ChangeNotifier {
  final int id;
  final String name;

  Room({this.id = -1, this.name = "No name"});
}

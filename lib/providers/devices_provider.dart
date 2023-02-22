import 'package:flutter/material.dart';

import '../models/devices/blind.dart';
import '../models/devices/device.dart';
import '../models/devices/fan.dart';
import '../models/devices/light.dart';
import '../models/devices/outlet.dart';

class DevicesProvider with ChangeNotifier {
  final List<Device> _devices = [
    Light(name: "Light 1", roomId: 1),
    Blind(name: "Blind 1", roomId: 1),
    Outlet(name: "Outlet 1", roomId: 1),
    Fan(name: "Fan 1", roomId: 1),
  ];

  List<Device> get devices => [..._devices];
  List<Device> getDevicesByRoomId(int roomId) {
    return _devices.where((element) => element.roomId == roomId).toList();
  }

  void addDevice(Device device) {
    _devices.add(device);
    notifyListeners();
  }

  void removeDevice(Device device) {
    _devices.remove(device);
    notifyListeners();
  }
}

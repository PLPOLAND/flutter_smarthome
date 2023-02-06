import 'package:flutter/material.dart';
import 'package:flutter_smarthome/models/light.dart';

import '../models/device.dart';

class DevicesProvider with ChangeNotifier {
  final List<Device> _devices = [
    Light(),
  ];

  List<Device> get devices => [..._devices];

  void addDevice(Device device) {
    _devices.add(device);
    notifyListeners();
  }

  void removeDevice(Device device) {
    _devices.remove(device);
    notifyListeners();
  }
}

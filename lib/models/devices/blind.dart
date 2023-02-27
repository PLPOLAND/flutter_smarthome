import 'package:flutter/foundation.dart';
import 'device.dart';

class Blind extends Device {
  Blind({
    int id = -1,
    int roomId = -1,
    int slaveId = -1,
    int onSlaveId = -1,
    String name = "No Name",
    DeviceState state = DeviceState.down,
  }) : super(id, roomId, slaveId, onSlaveId, name, DeviceType.blind, state);
  @override
  void changeState() {
    print("Blind: $name, state: $state");
    if (state == DeviceState.up) {
      state = DeviceState.down;
    } else if (state == DeviceState.down) {
      state = DeviceState.up;
    }
    notifyListeners();
  }

  @override
  void setState(DeviceState state) {
    if (state == DeviceState.up || state == DeviceState.down) {
      this.state = state;
    } else {
      throw Exception("Invalid state");
    }
    notifyListeners();
  }

  @override
  String toString() {
    String s = "Blind: $name, state: $state";
    return s + super.toString();
  }
}
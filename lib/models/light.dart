import 'package:flutter/foundation.dart';
import 'package:flutter_smarthome/models/device.dart';

class Light extends Device {
  Light({
    int id = -1,
    int roomId = -1,
    int slaveId = -1,
    int onSlaveId = -1,
    String name = "No Name",
    DeviceState state = DeviceState.off,
  }) : super(id, roomId, slaveId, onSlaveId, name, DeviceType.light, state);
  @override
  void changeState() {
    print("Light: $name, state: $state");
    if (state == DeviceState.on) {
      state = DeviceState.off;
    } else if (state == DeviceState.off) {
      state = DeviceState.on;
    }
    notifyListeners();
  }

  @override
  void setState(DeviceState state) {
    if (state == DeviceState.on || state == DeviceState.off) {
      this.state = state;
    } else {
      throw Exception("Invalid state");
    }
    notifyListeners();
  }
}

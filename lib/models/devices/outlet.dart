import 'package:flutter/foundation.dart';
import 'device.dart';

class Outlet extends Device {
  Outlet({
    int id = -1,
    int roomId = -1,
    int slaveId = -1,
    int onSlaveId = -1,
    int onSlavePin = -1,
    String name = "No Name",
    DeviceState state = DeviceState.off,
  }) : super(id, roomId, slaveId, onSlaveId, name, DeviceType.outlet, state,
            onSlavePin);
  @override
  Future<void> changeState() async {
    print("Outlet: $name, state: $state");
    if (state == DeviceState.on) {
      setState(DeviceState.off);
    } else if (state == DeviceState.off) {
      super.setState(DeviceState.on);
    }
    notifyListeners();
    return Future.delayed(const Duration(
        seconds:
            1)); // TODO: change this line after implementing the http request
  }

  @override
  void setState(DeviceState state) {
    if (state == DeviceState.on || state == DeviceState.off) {
      super.setState(state);
    } else {
      throw Exception("Invalid state"); //TODO: change to custom exception
    }
    notifyListeners();
  }

  @override
  String toString() {
    String s = "Outlet: $name, state: $state";
    return s + super.toString();
  }
}

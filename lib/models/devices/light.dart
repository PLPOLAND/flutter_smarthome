import 'package:flutter/foundation.dart';
import 'device.dart';

class Light extends Device {
  Light({
    int id = -1,
    int roomId = -1,
    int slaveId = -1,
    int onSlaveId = -1,
    int onSlavePin = -1,
    String name = "No Name",
    DeviceState state = DeviceState.off,
  }) : super(id, roomId, slaveId, onSlaveId, name, DeviceType.light, state,
            onSlavePin);
  @override
  Future<void> changeState() async {
    if (state == DeviceState.on) {
      super.setState(DeviceState.off);
    } else if (state == DeviceState.off) {
      super.setState(DeviceState.on);
    }
    notifyListeners();
    print("Light: $name, state: $state");
    return Future.delayed(Duration(
        seconds:
            1)); // TODO: change this line after implementing the http request
  }

  @override
  void setState(DeviceState state) {
    if (state == DeviceState.on || state == DeviceState.off) {
      super.setState(state);
    } else {
      throw Exception("Invalid state");
    }
    print("Light: $name, state: $state");
    notifyListeners();
  }

  @override
  String toString() {
    String s = "Light: $name, state: $state";
    return s + super.toString();
  }

  static Device fromJson(Map<String, Object> device) {
    return Light(
      id: device['id'] as int,
      roomId: device['room'] as int,
      slaveId: device['slaveID'] as int,
      onSlaveId: device['onSlaveID'] as int,
      onSlavePin: device['pin'] as int,
      name: device['name'] as String,
      state: device['state'] == "ON" ? DeviceState.on : DeviceState.off,
    );
  }
}

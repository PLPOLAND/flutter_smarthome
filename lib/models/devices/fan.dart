import 'dart:developer';

import 'device.dart';

class Fan extends Device {
  Fan({
    int id = -1,
    int roomId = -1,
    int slaveId = -1,
    int onSlaveId = -1,
    int onSlavePin = -1,
    String name = "No Name",
    DeviceState state = DeviceState.off,
    bool isFav = false,
  }) : super(
          id,
          roomId,
          slaveId,
          onSlaveId,
          name,
          DeviceType.fan,
          state,
          onSlavePin,
          isFav,
        );
  @override
  Future<void> changeState() async {
    if (state.deviceState == DeviceState.on) {
      super.setState(DeviceState.off);
    } else if (state.deviceState == DeviceState.off) {
      super.setState(DeviceState.on);
    }
    log("Fan: $name, state: $state");
    return Future.delayed(const Duration(
        seconds:
            1)); // TODO: change this line after implementing the http request
  }

  @override
  void setState(DeviceState newState) {
    if (newState == DeviceState.on || newState == DeviceState.off) {
      super.setState(newState);
    } else {
      throw Exception("Invalid state"); //TODO: change to custom exception
    }
  }

  @override
  String toString() {
    String s = "Fan: $name, state: $state";
    return s + super.toString();
  }

  static Device fromJson(Map<String, dynamic> device) {
    return Fan(
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

import 'dart:developer';

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
    if (state.deviceState == DeviceState.on) {
      super.setState(DeviceState.off);
      emit(state);
    } else if (state.deviceState == DeviceState.off) {
      super.setState(DeviceState.on);
      emit(state);
    }
    log("Light: $name, state: ${state.deviceState}");
    return Future.delayed(const Duration(
        seconds:
            1)); // TODO: change this line after implementing the http request
  }

  @override
  void setState(DeviceState newState) {
    if (newState == DeviceState.on || newState == DeviceState.off) {
      super.setState(newState);
      emit(state);
    } else {
      throw Exception("Invalid state");
    }
    log("Light: $name, state: ${state.deviceState}");
  }

  @override
  String toString() {
    String s = "Light: $name, state: ${state.deviceState}";
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

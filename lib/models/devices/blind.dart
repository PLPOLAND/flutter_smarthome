import 'device.dart';

class Blind extends Device {
  Blind({
    int id = -1,
    int roomId = -1,
    int slaveId = -1,
    int onSlaveId = -1,
    int onSlavePin = -1,
    String name = "No Name",
    DeviceState state = DeviceState.down,
  }) : super(id, roomId, slaveId, onSlaveId, name, DeviceType.blind, state,
            onSlavePin);
  @override
  Future<void> changeState() async {
    print("Blind: $name, state: $state");
    if (state == DeviceState.up) {
      super.setState(DeviceState.down);
    } else if (state == DeviceState.down) {
      super.setState(DeviceState.up);
    }
    notifyListeners();
    return Future.delayed(const Duration(
        seconds:
            1)); // TODO: change this line after implementing the http request
  }

  @override
  void setState(DeviceState state) {
    if (state == DeviceState.up ||
        state == DeviceState.down ||
        state == DeviceState.middle) {
      super.setState(state);
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

  static Device fromJson(Map<String, Object> device) {
    return Blind(
      id: device['id'] as int,
      roomId: device['room'] as int,
      slaveId: device['slaveID'] as int,
      onSlaveId: device['slaveID'] as int,
      // onSlavePin: device['pin'] as int,
      name: device['name'] as String,
      state: device['state'] == "UP"
          ? DeviceState.up
          : device['state'] == "DOWN"
              ? DeviceState.down
              : DeviceState.middle,
    );
  }
}

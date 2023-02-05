import 'package:flutter_smarthome/models/device_type.dart';

class Device {
  final int id;
  int roomId;
  int slaveId;
  int onSlaveId;
  String name;
  DeviceType type;

  Device(
      {this.id = -1,
      this.roomId = -1,
      this.slaveId = -1,
      this.onSlaveId = -1,
      this.name = "No Name",
      this.type = DeviceType.none});
}

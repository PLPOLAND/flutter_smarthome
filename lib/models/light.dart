import 'package:flutter_smarthome/models/device.dart';

import 'device_type.dart';

class Light extends Device {
  Light(
      {int id = -1,
      int roomId = -1,
      int slaveId = -1,
      int onSlaveId = -1,
      String name = "No Name",
      DeviceType type = DeviceType.light})
      : super(
            id: id,
            roomId: roomId,
            slaveId: slaveId,
            onSlaveId: onSlaveId,
            name: name,
            type: type);

  factory Light.fromJson(Map<String, dynamic> json) {
    return Light(
      id: json['id'],
      roomId: json['roomId'],
      slaveId: json['slaveId'],
      onSlaveId: json['onSlaveId'],
      name: json['name'],
      type: DeviceType.values[json['type']],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'roomId': roomId,
        'slaveId': slaveId,
        'onSlaveId': onSlaveId,
        'name': name,
        'type': type.index,
      };
}

import 'package:flutter_smarthome/models/devices/blind.dart';
import 'package:flutter_smarthome/models/devices/device.dart';
import 'package:flutter_smarthome/models/devices/fan.dart';
import 'package:flutter_smarthome/models/devices/light.dart';
import 'package:flutter_smarthome/models/devices/outlet.dart';

///Class representing action that gonna be executed when automation is triggered
class FunctionAction {
  final Device device;
  final DeviceState state;
  final bool allowReverse;

  FunctionAction({
    required this.device,
    required this.state,
    required this.allowReverse,
  });

  @override
  String toString() {
    return 'FunctionAction{deviceID: ${device.id}, state: $state, allowReverse: $allowReverse}';
  }

  static FunctionAction fromJson(Map<String, dynamic> json) {
    late Device device;
    switch (json['device']['typ']) {
      case 'LIGHT':
        device = Light.fromJson(json['device']);
        break;
      case 'WENTYLATOR':
        device = Fan.fromJson(json['device']);
        break;
      case 'OUTLET':
        device = Outlet.fromJson(json['device']);
        break;
      case 'BLIND':
        device = Blind.fromJson(json['device']);
        break;
      default:
        throw Exception('Unknown device type');
    }
    return FunctionAction(
      device: device,
      state: DeviceState.fromString(json['activeDeviceState']),
      allowReverse: json['allowReverse'],
    );
  }

  FunctionAction copyWith({
    Device? device,
    DeviceState? state,
    bool? allowReverse,
  }) {
    return FunctionAction(
      device: device ?? this.device,
      state: state ?? this.state,
      allowReverse: allowReverse ?? this.allowReverse,
    );
  }
}

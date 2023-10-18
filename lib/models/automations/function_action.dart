import 'package:flutter_smarthome/models/devices/device.dart';

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

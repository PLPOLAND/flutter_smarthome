import 'dart:developer';

import 'device.dart';

class Blind extends Device {
  Blind({
    int id = -1,
    int roomId = -1,
    int slaveId = -1,
    int onSlaveId = -1,
    int onSlavePinUp = -1,
    int onSlavePinDown = -1,
    String name = "No Name",
    DeviceState state = DeviceState.down,
  }) : super.state(BlindCubitState(
          id: id,
          roomId: roomId,
          slaveId: slaveId,
          onSlaveId: onSlaveId,
          name: name,
          type: DeviceType.blind,
          state: state,
          onSlavePin: onSlavePinUp,
          onSlavePinDown: onSlavePinDown,
        ));
  @override
  Future<void> changeState() async {
    log("Blind: $name, state: $state");
    if (state.deviceState == DeviceState.up) {
      super.setState(DeviceState.down);
    } else if (state.deviceState == DeviceState.down) {
      super.setState(DeviceState.up);
    } else if (state.deviceState == DeviceState.run) {
      super.setState(DeviceState.middle);
    }
  }

  @override
  void setState(DeviceState newState) {
    if (newState == DeviceState.up ||
        newState == DeviceState.down ||
        newState == DeviceState.middle) {
      var oldState = state.deviceState;
      super.setState(newState);
      if (newState != DeviceState.middle && oldState == DeviceState.middle) {
        super.setStateLocaly(DeviceState.run);
      }
    } else {
      throw Exception("Invalid state ($newState) for Blind");
    }
  }

  @override
  String toString() {
    String s = "Blind: $name, state: $state";
    return s + super.toString();
  }

  static Device fromJson(Map<String, dynamic> device) {
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

class BlindCubitState extends DeviceCubitState {
  final int _onSlavePinDown;

  int get onSlavePinDown => _onSlavePinDown;

  const BlindCubitState({
    required int id,
    required int roomId,
    required int slaveId,
    required int onSlaveId,
    required String name,
    required DeviceType type,
    required DeviceState state,
    required int onSlavePin,
    required onSlavePinDown,
  })  : _onSlavePinDown = onSlavePinDown,
        super(
          id,
          roomId,
          slaveId,
          onSlaveId,
          name,
          type,
          state,
          onSlavePin,
        );

  @override
  List<Object?> get props => [
        ...super.props,
        _onSlavePinDown,
      ];

  @override
  DeviceCubitState copyWith({
    int? id,
    int? roomId,
    int? slaveId,
    int? onSlaveId,
    String? name,
    DeviceType? type,
    DeviceState? state,
    int? onSlavePin,
    int? onSlavePinDown,
  }) {
    return BlindCubitState(
      id: id ?? this.id,
      roomId: roomId ?? this.roomId,
      slaveId: slaveId ?? slaveID,
      onSlaveId: onSlaveId ?? onSlaveID,
      name: name ?? this.name,
      type: type ?? this.type,
      state: state ?? deviceState,
      onSlavePin: onSlavePin ?? this.onSlavePin,
      onSlavePinDown: onSlavePinDown ?? _onSlavePinDown,
    );
  }
}

part of 'devices_bloc.dart';

enum DevicesStatus {
  initial,
  demo,
  loading,
  updating,
  loaded,
  error,
}

extension DevicesStatusExtension on DevicesStatus {
  bool get isInitial => this == DevicesStatus.initial;

  bool get isDemo => this == DevicesStatus.demo;

  bool get isLoading => this == DevicesStatus.loading;

  bool get isUpdating => this == DevicesStatus.updating;

  bool get isLoaded => this == DevicesStatus.loaded;

  bool get isError => this == DevicesStatus.error;
}

class DevicesState extends Equatable {
  final DevicesStatus status;
  final List<Device> devices;
  final bool stopUpdating;

  const DevicesState._({
    this.status = DevicesStatus.initial,
    this.devices = const [],
    this.stopUpdating = false,
  });

  const DevicesState.initial() : this._();

  const DevicesState.demo({
    required List<Device> devices,
  }) : this._(devices: devices, status: DevicesStatus.demo);

  const DevicesState.loading() : this._(status: DevicesStatus.loading);

  const DevicesState.loaded({
    required List<Device> devices,
  }) : this._(
          status: DevicesStatus.loaded,
          devices: devices,
        );

  const DevicesState.error() : this._(status: DevicesStatus.error);

  const DevicesState.updating() : this._(status: DevicesStatus.updating);

  @override
  List<Object> get props => [status, devices, stopUpdating];

  @override
  String toString() =>
      'DevicesState { status: $status, devices: ${devices.length}, stopUpdating: $stopUpdating }';

  DevicesState copyWith({
    DevicesStatus? status,
    List<Device>? devices,
    List<Device>? favoriteDevices,
    bool? stopUpdating,
  }) {
    return DevicesState._(
      status: status ?? this.status,
      devices: devices ?? this.devices,
      stopUpdating: stopUpdating ?? this.stopUpdating,
    );
  }
}

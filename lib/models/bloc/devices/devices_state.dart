part of 'devices_bloc.dart';

enum DevicesStatus { initial, loading, loaded, error, updating }

extension DevicesStatusExtension on DevicesStatus {
  bool get isUnknown => this == DevicesStatus.initial;
  bool get isLoading => this == DevicesStatus.loading;
  bool get isLoaded => this == DevicesStatus.loaded;
  bool get isError => this == DevicesStatus.error;
  bool get isUpdating => this == DevicesStatus.updating;
}

class DevicesState extends Equatable {
  final DevicesStatus status;
  final List<Device> devices;
  final List<Device> favoriteDevices;

  const DevicesState._({
    this.status = DevicesStatus.initial,
    this.devices = const [],
    this.favoriteDevices = const [],
  });

  const DevicesState.initial() : this._();

  const DevicesState.loading() : this._(status: DevicesStatus.loading);

  const DevicesState.loaded({
    required List<Device> devices,
    required List<Device> favoriteDevices,
  }) : this._(
          status: DevicesStatus.loaded,
          devices: devices,
          favoriteDevices: favoriteDevices,
        );

  const DevicesState.error() : this._(status: DevicesStatus.error);

  const DevicesState.updating() : this._(status: DevicesStatus.updating);

  @override
  List<Object> get props => [status, devices, favoriteDevices];

  @override
  String toString() =>
      'DevicesState { status: $status, devices: $devices, favoriteDevices: $favoriteDevices }';

  DevicesState copyWith({
    DevicesStatus? status,
    List<Device>? devices,
    List<Device>? favoriteDevices,
  }) {
    return DevicesState._(
      status: status ?? this.status,
      devices: devices ?? this.devices,
      favoriteDevices: favoriteDevices ?? this.favoriteDevices,
    );
  }
}

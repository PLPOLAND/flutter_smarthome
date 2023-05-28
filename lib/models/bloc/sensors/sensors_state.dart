part of 'sensors_bloc.dart';

enum SensorsStatus {
  initial,
  demo,
  loading,
  updating,
  loaded,
  error,
}

extension SensorsStatusExtension on SensorsStatus {
  bool get isInitial => this == SensorsStatus.initial;

  bool get isDemo => this == SensorsStatus.demo;

  bool get isLoading => this == SensorsStatus.loading;

  bool get isUpdating => this == SensorsStatus.updating;

  bool get isLoaded => this == SensorsStatus.loaded;

  bool get isError => this == SensorsStatus.error;
}

class SensorsState extends Equatable {
  final SensorsStatus status;
  final List<Sensor> sensors;
  bool stopUpdating;

  SensorsState._({
    this.status = SensorsStatus.initial,
    this.sensors = const [],
    this.stopUpdating = false,
  });

  SensorsState.initial() : this._();

  SensorsState.demo({
    required List<Sensor> sensors,
  }) : this._(sensors: sensors, status: SensorsStatus.demo);

  SensorsState.loading() : this._(status: SensorsStatus.loading);

  SensorsState.loaded({
    required List<Sensor> sensors,
  }) : this._(
          status: SensorsStatus.loaded,
          sensors: sensors,
        );

  SensorsState.error() : this._(status: SensorsStatus.error);

  SensorsState.updating() : this._(status: SensorsStatus.updating);

  @override
  List<Object> get props => [status, sensors, stopUpdating];

  @override
  String toString() =>
      'DevicesState { status: $status, devices: $sensors, stopUpdating: $stopUpdating }';

  SensorsState copyWith({
    SensorsStatus? status,
    List<Sensor>? sensors,
    bool? stopUpdating,
  }) {
    return SensorsState._(
      status: status ?? this.status,
      sensors: sensors ?? this.sensors,
      stopUpdating: stopUpdating ?? this.stopUpdating,
    );
  }
}

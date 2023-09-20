part of 'sensors_bloc.dart';

enum SensorsStatus {
  initial,
  demo,
  loading,
  updating,
  loaded,
  error,
  adding,
  removing,
  updatingSensor,
}

extension SensorsStatusExtension on SensorsStatus {
  bool get isInitial => this == SensorsStatus.initial;

  bool get isDemo => this == SensorsStatus.demo;

  bool get isLoading => this == SensorsStatus.loading;

  bool get isUpdating => this == SensorsStatus.updating;

  bool get isLoaded => this == SensorsStatus.loaded;

  bool get isError => this == SensorsStatus.error;

  bool get isAdding => this == SensorsStatus.adding;

  bool get isRemoving => this == SensorsStatus.removing;

  bool get isUpdatingSensor => this == SensorsStatus.updatingSensor;
}

class SensorsState extends Equatable {
  final SensorsStatus status;
  final List<Sensor> sensors;
  final bool stopUpdating;
  final String errorMsg;

  const SensorsState._({
    this.status = SensorsStatus.initial,
    this.sensors = const [],
    this.stopUpdating = false,
    this.errorMsg = '',
  });

  const SensorsState.initial() : this._();

  const SensorsState.demo({
    required List<Sensor> sensors,
  }) : this._(sensors: sensors, status: SensorsStatus.demo);

  const SensorsState.loading() : this._(status: SensorsStatus.loading);

  const SensorsState.loaded({
    required List<Sensor> sensors,
  }) : this._(
          status: SensorsStatus.loaded,
          sensors: sensors,
        );

  const SensorsState.error() : this._(status: SensorsStatus.error);

  const SensorsState.updating() : this._(status: SensorsStatus.updating);

  @override
  List<Object> get props => [status, sensors, stopUpdating];

  @override
  String toString() =>
      'SensorsState { status: $status, sensors: ${sensors.length}, stopUpdating: $stopUpdating, errorMsg: $errorMsg }';

  SensorsState copyWith({
    SensorsStatus? status,
    List<Sensor>? sensors,
    bool? stopUpdating,
    String? errorMsg,
  }) {
    return SensorsState._(
      status: status ?? this.status,
      sensors: sensors ?? this.sensors,
      stopUpdating: stopUpdating ?? this.stopUpdating,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

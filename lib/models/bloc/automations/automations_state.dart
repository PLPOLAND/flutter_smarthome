part of 'automations_bloc.dart';

enum AutomationStatus {
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

extension SensorsStatusExtension on AutomationStatus {
  bool get isInitial => this == AutomationStatus.initial;

  bool get isDemo => this == AutomationStatus.demo;

  bool get isLoading => this == AutomationStatus.loading;

  bool get isUpdating => this == AutomationStatus.updating;

  bool get isLoaded => this == AutomationStatus.loaded;

  bool get isError => this == AutomationStatus.error;

  bool get isAdding => this == AutomationStatus.adding;

  bool get isRemoving => this == AutomationStatus.removing;

  bool get isUpdatingSensor => this == AutomationStatus.updatingSensor;
}

class AutomationsState extends Equatable {
  final AutomationStatus status;
  final Map<String, Automation> automation;
  final bool stopUpdating;
  final String errorMsg;

  const AutomationsState._({
    this.status = AutomationStatus.initial,
    this.automation = const {},
    this.stopUpdating = false,
    this.errorMsg = '',
  });

  const AutomationsState.initial() : this._();

  const AutomationsState.demo({
    required Map<String, Automation> automations,
  }) : this._(automation: automations, status: AutomationStatus.demo);

  const AutomationsState.loading() : this._(status: AutomationStatus.loading);

  const AutomationsState.loaded({
    required Map<String, Automation> automations,
  }) : this._(
          status: AutomationStatus.loaded,
          automation: automations,
        );

  const AutomationsState.error() : this._(status: AutomationStatus.error);

  const AutomationsState.updating() : this._(status: AutomationStatus.updating);

  @override
  List<Object> get props => [status, automation, stopUpdating];

  @override
  String toString() =>
      'AutomationsState { status: $status, automations: ${automation.length}, stopUpdating: $stopUpdating, errorMsg: $errorMsg }';

  AutomationsState copyWith({
    AutomationStatus? status,
    Map<String, Automation>? automation,
    bool? stopUpdating,
    String? errorMsg,
  }) {
    return AutomationsState._(
      status: status ?? this.status,
      automation: automation ?? this.automation,
      stopUpdating: stopUpdating ?? this.stopUpdating,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

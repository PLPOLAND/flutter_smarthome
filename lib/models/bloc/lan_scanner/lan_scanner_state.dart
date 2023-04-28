part of 'lan_scanner_bloc.dart';

/// status of the scanner
enum ScannnerStatus {
  idle,
  scanning,
  found,
  done,
}

extension ScannnerStateExtension on ScannnerStatus {
  bool get isIdle => this == ScannnerStatus.idle;
  bool get isScanning => this == ScannnerStatus.scanning;
  bool get isFound => this == ScannnerStatus.found;
  bool get isDone => this == ScannnerStatus.done;
}

/// LanScannerState is responsible for handling state in LanScannerBloc
class LanScannerState {
  ScannnerStatus status; // current status of the scanner
  List<String> servers; // list of servers

  LanScannerState({
    this.status = ScannnerStatus.idle,
    this.servers = const <String>[],
  });

  LanScannerState copyWith({
    ScannnerStatus? status,
    List<String>? servers,
  }) {
    return LanScannerState(
      status: status ?? this.status,
      servers: servers ?? this.servers,
    );
  }

  @override
  String toString() =>
      'LanScannerStatus { status: $status, servers: $servers }';
}

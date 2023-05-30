part of 'lan_scanner_bloc.dart';

/// LanScannerEvent is responsible for handling events in LanScannerBloc
class LanScannerEvent extends Equatable {
  const LanScannerEvent();

  @override
  List<Object> get props => [];
}

/// LanScannerStart event to start scanning
class LanScannerStart extends LanScannerEvent {}

/// LanScannerStop event to stop scanning
class LanScannerStop extends LanScannerEvent {}

/// LanScannerAddServer event to add server to list
class LanScannerAddServer extends LanScannerEvent {
  final String server;

  const LanScannerAddServer(this.server);

  @override
  List<Object> get props => [server];
}

/// LanScannerFinished event to finish scanning
class LanScannerFinished extends LanScannerEvent {}

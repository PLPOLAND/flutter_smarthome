import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_smarthome/helpers/rest_client/rest_client.dart';

part 'lan_scanner_event.dart';
part 'lan_scanner_state.dart';

/// LanScannerBloc is responsible for scanning local network for servers and adding them to the list
/// It uses RESTClient to scan for servers
class LanScannerBloc extends Bloc<LanScannerEvent, LanScannerState> {
  late final StreamSubscription<String> _serverScannerSubscription;
  LanScannerBloc() : super(LanScannerState()) {
    /// LanScannerStart event starts scanning for servers
    on<LanScannerStart>((event, emit) {
      if (state.status != ScannnerStatus.scanning) {
        emit(state.copyWith(status: ScannnerStatus.scanning));
        _serverScannerSubscription =
            RESTClient().scanForServer().listen((event) {
          add(LanScannerAddServer(event)); // add server to the list
        })
              ..onDone(() {
                add(LanScannerFinished()); // when scanning is finished, add LanScannerFinished event
              });
      }
    });

    /// LanScannerStop event stops scanning for servers
    on<LanScannerStop>((event, emit) {
      emit(
          state.copyWith(status: ScannnerStatus.done)); // change status to done
      _serverScannerSubscription.cancel(); // cancel server scanner subscription
    });

    /// LanScannerAddServer event adds server to the list
    on<LanScannerAddServer>((event, emit) {
      emit(state.copyWith(
          servers: [...state.servers, event.server],
          status: ScannnerStatus.found));
      emit(state.copyWith(status: ScannnerStatus.scanning));
    });

    /// LanScannerFinished event changes status to done and cancels server scanner subscription
    on<LanScannerFinished>((event, emit) {
      emit(state.copyWith(status: ScannnerStatus.done));
      _serverScannerSubscription.cancel();
    });
  }

  /// onChange method is called when state is changed and prints the change
  @override
  void onChange(Change<LanScannerState> change) {
    super.onChange(change);
    print(change);
  }

  /// close method is called when bloc is closed and cancels server scanner subscription
  @override
  Future<void> close() async {
    log('LanScannerBloc close');
    _serverScannerSubscription.cancel();
    return super.close();
  }
}

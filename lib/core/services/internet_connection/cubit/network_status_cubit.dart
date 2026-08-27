import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:meta/meta.dart';

part 'network_status_state.dart';

class NetworkStatusCubit extends Cubit<NetworkStatusState> {
  StreamSubscription<InternetStatus>? _subscription;

  NetworkStatusCubit() : super(NetworkStatusInitial()) {
    _listenToNetwork();
  }

  void _listenToNetwork() {
    _subscription = InternetConnection().onStatusChange.listen((status) {
      if (isClosed) return;
      switch (status) {
        case InternetStatus.connected:
          emit(NetworkStatusConnected());
          break;
        case InternetStatus.disconnected:
          emit(NetworkStatusDisConnected());
          break;
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

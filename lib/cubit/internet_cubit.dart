import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum InternetState {
  initial,
  lost,
  gained,
}

class InternetCubit extends Cubit<InternetState> {
  Connectivity connectivity = Connectivity();

  StreamSubscription? connectivitySubscription;

  InternetCubit() : super(InternetState.initial) {
    connectivitySubscription =
        connectivity.onConnectivityChanged.listen((result) {
          if (result == ConnectivityResult.mobile ||
              result == ConnectivityResult.wifi) {
            emit(InternetState.gained);
          } else {
            emit(InternetState.lost);
          }
        });
  }

  @override
  Future<void> close() {
    connectivitySubscription?.cancel();
    return super.close();
  }
}

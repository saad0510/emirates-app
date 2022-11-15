import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

abstract class BaseChangeNotifier<T> extends ChangeNotifier {
  T _state;
  final bool debugMode;

  BaseChangeNotifier(this._state, {this.debugMode = false}) {
    if (debugMode) {
      addListener(
        () => log("${_state.runtimeType}", name: "Provider"),
      );
    }
    init();
  }

  @protected
  @mustCallSuper
  Future<void> init() async {}

  @protected
  set state(T newState) {
    if (_state == newState) return;

    _state = newState;
    notifyListeners();
  }

  T get state => _state;
}

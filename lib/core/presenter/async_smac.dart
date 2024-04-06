import 'package:flutter/foundation.dart';

import '../domain/smac_error.dart';
import '../domain/smac_unexpected_error.dart';
import '../utils/smac_behavior_enum.dart';
import 'smac.dart';

/// A SMaC that has default functions for async business.
///
/// There are four main behaviors that this controller can have:
/// * `waiting`: before any behavior is triggered.
/// * `loading`: while the widget run some tasks or is waiting for data.
/// * `success`: when all the required tasks reach success.
/// * `errored`: when the tasks reach some error.
final class AsyncSmac extends Smac {
  SmacBehavior _behavior = SmacBehavior.waiting;
  SmacError? _error;

  bool get isWaiting => _behavior == SmacBehavior.waiting;
  bool get isLoading => _behavior == SmacBehavior.loading;
  bool get isSuccessful => _behavior == SmacBehavior.success;
  bool get isErrored => _behavior == SmacBehavior.errored;
  SmacBehavior get behavior => _behavior;
  SmacError? get error => _error;

  /// Sets the behavior value to `loading` and clear any stored error.
  void triggerLoading() {
    _error = null;
    _behavior = SmacBehavior.loading;
    notifyListeners();
  }

  /// Sets the behavior value to `success` and clear any stored error.
  void triggerSuccess() {
    _error = null;
    _behavior = SmacBehavior.success;
    notifyListeners();
  }

  /// Sets the behavior value to `errored` saves an [SmacError] value in the
  /// controller.
  void throwError(SmacError error) {
    _error = error;
    _behavior = SmacBehavior.errored;
    notifyListeners();
  }

  /// Waits for an async function and makes a simple state management for it,
  /// depending on the function status.
  ///
  /// The `rethrowError` value can be changed if you want or not rethrow any
  /// expected [SmacError].
  Future<void> waitFor(
    AsyncCallback future, {
    bool rethrowError = true,
  }) async {
    try {
      triggerLoading();
      await future();
      triggerSuccess();
    } on SmacError catch (error) {
      throwError(error);
      if (rethrowError) rethrow;
    } catch (error) {
      throwError(SmacUnexpectedError(error));
      rethrow;
    }
  }
}

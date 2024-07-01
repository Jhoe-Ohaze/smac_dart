import 'package:flutter/foundation.dart';

import '../domain/smac_error.dart';
import '../domain/smac_behavior_enum.dart';
import 'smac.dart';

/// A SMaC that has four default behaviors for async business.
///
/// There are four main behaviors that this controller can have:
/// * `waiting`: Unitialized, waiting any behavior to be triggered.
/// * `loading`: while the widget run some tasks or is waiting for data.
/// * `success`: when all the required tasks reach success.
/// * `errored`: when the tasks reach some error.
final class QuadSmac extends Smac {
  SmacBehaviorEnum _behavior = SmacBehaviorEnum.waiting;
  SmacError? _error;

  bool get isWaiting => _behavior == SmacBehaviorEnum.waiting;
  bool get isLoading => _behavior == SmacBehaviorEnum.loading;
  bool get isSuccessful => _behavior == SmacBehaviorEnum.success;
  bool get isErrored => _behavior == SmacBehaviorEnum.errored;
  SmacError? get error => _error;

  /// Sets the behavior value to `loading` and clear any stored error.
  @mustCallSuper
  void triggerLoading() {
    _error = null;
    _behavior = SmacBehaviorEnum.loading;
    notifyListeners();
  }

  /// Sets the behavior value to `success` and clear any stored error.
  @mustCallSuper
  void triggerSuccess() {
    _error = null;
    _behavior = SmacBehaviorEnum.success;
    notifyListeners();
  }

  /// Sets the behavior value to `errored` saves an [SmacError] value in the
  /// controller.
  @mustCallSuper
  void throwError(SmacError error) {
    _error = error;
    _behavior = SmacBehaviorEnum.errored;
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

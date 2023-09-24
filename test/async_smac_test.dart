import 'package:flutter_test/flutter_test.dart';
import 'package:smac_dart/smac.dart';

import 'mocks/smac_test_exception.dart';

void main() {
  final controller = AsyncSmacController();
  final exception = SmacTestException();

  test('checks if the initial behavior is "waiting"', () {
    expect(controller.isWaiting, true);
    expect(controller.isLoading, false);
    expect(controller.isSuccessful, false);
    expect(controller.isErrored, false);
    expect(controller.error, isNull);
  });

  test('triggers the "loading" behavior', () {
    controller.triggerLoading();

    expect(controller.isWaiting, false);
    expect(controller.isLoading, true);
    expect(controller.isSuccessful, false);
    expect(controller.isErrored, false);
    expect(controller.error, isNull);
  });

  test('triggers the "success" behavior', () {
    controller.triggerSuccess();

    expect(controller.isWaiting, false);
    expect(controller.isLoading, false);
    expect(controller.isSuccessful, true);
    expect(controller.isErrored, false);
    expect(controller.error, isNull);
  });

  test('throws and stores an exception', () {
    controller.throwError(exception);

    expect(controller.isWaiting, false);
    expect(controller.isLoading, false);
    expect(controller.isSuccessful, false);
    expect(controller.isErrored, true);
    expect(controller.error, equals(exception));
  });

  test('waits for a future function acompplish successfully', () async {
    await controller.waitFor(() async {
      expect(controller.isLoading, true);
      await Future.delayed(const Duration(seconds: 1));
    });
    expectLater(controller.isSuccessful, true);
  });

  test('waits for a future function fails', () async {
    await controller.waitFor(
      () async {
        expect(controller.isLoading, true);
        await Future.delayed(const Duration(seconds: 1));
        throw exception;
      },
      rethrowError: false,
    );

    expect(controller.isErrored, true);
    expect(controller.error, equals(exception));
  });
}

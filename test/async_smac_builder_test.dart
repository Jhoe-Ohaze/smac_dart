import 'package:flutter_test/flutter_test.dart';
import 'package:smac_dart/smac.dart';

import 'mocks/async_smac_builder_mock.dart';
import 'mocks/keys.dart';
import 'mocks/smac_test_exception.dart';

void main() {
  final asyncSmac = AsyncSmacController();
  final exception = SmacTestException();

  testWidgets('Checks smac builder widget behavior', (tester) async {
    await tester.pumpWidget(
      AsyncSmacBuilderMock(
        smacController: asyncSmac,
      ),
    );

    final waitingFinder = find.byKey(smacTestWaitingKey);
    expect(waitingFinder.evaluate().isNotEmpty, true);

    asyncSmac.triggerLoading();
    await tester.pumpAndSettle();
    final loadingFinder = find.byKey(smacTestLoadingKey);
    expect(loadingFinder.evaluate().isNotEmpty, true);

    asyncSmac.triggerSuccess();
    await tester.pumpAndSettle();
    final successFinder = find.byKey(smacTestSuccessKey);
    expect(
      successFinder.evaluate().isNotEmpty,
      true,
      reason: 'Did not find the success widget',
    );

    asyncSmac.throwError(exception);
    await tester.pumpAndSettle();
    final errorFinder = find.byKey(smacTestErrorKey);
    expect(
      errorFinder.evaluate().isNotEmpty,
      true,
      reason: 'Did not find the error widget',
    );
  });
}

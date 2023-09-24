import 'package:flutter/material.dart';
import 'package:smac_dart/core/presenter/async_smac_builder.dart';
import 'package:smac_dart/core/presenter/async_smac.dart';
import 'keys.dart';

class AsyncSmacBuilderMock extends StatelessWidget {
  final AsyncSmacController smacController;

  const AsyncSmacBuilderMock({
    required this.smacController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smac Builder Widget Mock',
      home: Scaffold(
        body: AsyncSmacBuilder(
          controller: smacController,
          waitingBuilder: (context) => const SizedBox(key: smacTestWaitingKey),
          loadingBuilder: (context) => const SizedBox(key: smacTestLoadingKey),
          exceptionBuilder: (context, exception) {
            return const SizedBox(key: smacTestErrorKey);
          },
          successBuilder: (context) {
            return const Placeholder(key: smacTestSuccessKey);
          },
        ),
      ),
    );
  }
}

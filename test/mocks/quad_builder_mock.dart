import 'package:flutter/material.dart';
import 'package:smac_dart/src/presenter/quad_builder.dart';
import 'package:smac_dart/src/presenter/quad_smac.dart';
import 'keys.dart';

class QuadBuilderMock extends StatelessWidget {
  final QuadSmac smacController;

  const QuadBuilderMock({
    required this.smacController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smac Builder Widget Mock',
      home: Scaffold(
        body: QuadBuilder(
          asyncSmac: smacController,
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

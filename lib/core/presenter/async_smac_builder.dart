import 'package:flutter/material.dart';

import '../domain/smac_exception.dart';
import '../utils/get_smac_mixin.dart';
import '../utils/smac_behavior_enum.dart';
import 'async_smac.dart';

/// A Widget that is synced with [AsyncSmacController] behavior.
///
/// When the controller changes its state behavior, this widget will change the
/// builder that is currently being displayed.
class AsyncSmacBuilder<T> extends StatefulWidget {
  final AsyncSmacController<T> controller;
  final WidgetBuilder waitingBuilder;
  final WidgetBuilder loadingBuilder;
  final WidgetBuilder successBuilder;
  final Widget Function(BuildContext, SmacException) exceptionBuilder;

  const AsyncSmacBuilder({
    required this.controller,
    this.successBuilder = _defaultSuccess,
    this.waitingBuilder = _defaultWaiting,
    this.loadingBuilder = _defaultLoading,
    this.exceptionBuilder = _defaultException,
    super.key,
  });

  @override
  State<AsyncSmacBuilder> createState() => _AsyncSmacBuilderState();
}

class _AsyncSmacBuilderState extends State<AsyncSmacBuilder>
    with GetSmacMixin<AsyncSmacBuilder, AsyncSmacController> {
  @override
  AsyncSmacController createSmac() => widget.controller;

  @override
  Widget build(BuildContext context) {
    switch (smac.behavior) {
      case SmacBehavior.waiting:
        return widget.waitingBuilder(context);
      case SmacBehavior.loading:
        return widget.loadingBuilder(context);
      case SmacBehavior.success:
        return widget.successBuilder(context);
      case SmacBehavior.errored:
        return widget.exceptionBuilder(context, smac.error!);
    }
  }
}

Widget _defaultWaiting(BuildContext context) {
  return const SizedBox();
}

Widget _defaultLoading(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _defaultException(BuildContext context, SmacException error) {
  return Center(
    child: Column(
      children: [
        const Icon(
          Icons.error_outline,
          size: 40.0,
          color: Colors.red,
        ),
        const SizedBox(height: 5.0),
        Text(
          error.message,
          style: const TextStyle(color: Colors.red),
        )
      ],
    ),
  );
}

Widget _defaultSuccess(BuildContext context) {
  return Center(
    child: Icon(
      Icons.check_circle_outline_rounded,
      size: 40.0,
      color: Colors.green.shade800,
    ),
  );
}

import 'package:flutter/material.dart';

import '../../smac.dart';
import '../domain/smac_error.dart';

/// A Widget that is synced with [QuadSmac] behavior.
///
/// When the controller changes its state behavior, this widget will change the
/// builder that is currently being displayed.
class QuadBuilder extends StatefulWidget {
  final QuadSmac asyncSmac;
  final WidgetBuilder waitingBuilder;
  final WidgetBuilder loadingBuilder;
  final WidgetBuilder successBuilder;
  final Widget Function(BuildContext, SmacError) exceptionBuilder;

  const QuadBuilder({
    required this.asyncSmac,
    this.successBuilder = _defaultSuccess,
    this.waitingBuilder = _defaultWaiting,
    this.loadingBuilder = _defaultLoading,
    this.exceptionBuilder = _defaultException,
    super.key,
  });

  @override
  State<QuadBuilder> createState() => _QuadBuilderState();
}

class _QuadBuilderState extends State<QuadBuilder>
    with GetSmacMixin<QuadBuilder, QuadSmac> {
  @override
  QuadSmac createSmac() => widget.asyncSmac;

  @override
  Widget build(BuildContext context) {
    if (smac.isWaiting) {
      return widget.waitingBuilder(context);
    } else if (smac.isLoading) {
      return widget.loadingBuilder(context);
    } else if (smac.isSuccessful) {
      return widget.successBuilder(context);
    } else {
      return widget.exceptionBuilder(context, smac.error!);
    }
  }
}

Widget _defaultWaiting(BuildContext context) {
  return const Center(
    child: Text('Unitialized'),
  );
}

Widget _defaultLoading(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(),
  );
}

Widget _defaultException(BuildContext context, SmacError error) {
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
        ),
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

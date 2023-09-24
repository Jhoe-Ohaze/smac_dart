import 'package:flutter/material.dart';

import '../presenter/smac.dart';

mixin GetSmacMixin<T extends StatefulWidget, U extends Smac> on State<T> {
  /// The instance of the current [SMaC].
  ///
  /// This instance is created before calling the widget [initState], and is
  /// disposed before calling the widget [dispose].
  late final U smac;

  /// Creates and sets the [SMaC] that will be linked to the
  /// stateful widget.
  ///
  /// ``` dart
  /// @override
  /// ANewSmac createSmac => ANewSmac();
  /// ```
  U createSmac();

  void _updateWidget() => setState(() {});

  @override
  void initState() {
    smac = createSmac();
    smac.init();
    smac.addListener(_updateWidget);

    super.initState();
  }

  @override
  void dispose() {
    smac.removeListener(_updateWidget);
    smac.dispose();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

/// A class that can be used as base for classes that store anything
/// related to state management.
///
/// The childrens of this class will work in conjunction with [GetSmacMixin]
/// to separate all the logic from the [State] class.
///
/// It is highly recomended to atach only one SMaC per state.
abstract class Smac<T extends State> extends ChangeNotifier {
  BuildContext? _context;

  /// The current context of the binded widget.
  ///
  /// Returns `null` if there is no widget binded.
  BuildContext? get context => _context;

  @override
  void dispose() {
    _context = null;
    super.dispose();
  }
}

mixin GetSmacMixin<T extends StatefulWidget, U extends Smac> on State<T> {
  /// The instance of the current SMaC.
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

  void _bindContext(BuildContext context) {
    if (smac._context == null) {
      smac._context = context;
    } else {
      debugPrint('This instance of $runtimeType is already binded to a Widget!');
    }
  }

  @override
  void initState() {
    smac = createSmac();
    _bindContext(context);
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

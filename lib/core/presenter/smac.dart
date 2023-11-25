import 'package:flutter/material.dart';

class Smac extends ChangeNotifier {
  /// Called when this [SMaC] that is binded to a [Widget] is inserted on
  /// the tree.
  ///
  /// It runs on the binded [Widget] `initState()`, and get its [BuildContext] in the tree.
  void init(BuildContext context) {}
}

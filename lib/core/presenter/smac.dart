import 'package:flutter/material.dart';

class Smac extends ChangeNotifier {
  Smac() {
    onInitClass();
  }

  /// Called when this class is instantiated.
  void onInitClass() {}

  /// Called when this SMaC that is binded to a widget is inserted on the tree.
  ///
  /// It runs on the binded widget `initState()`, and get its build context in the tree.
  void onInitState(BuildContext context) {}
}

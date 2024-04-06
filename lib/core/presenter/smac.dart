import 'package:flutter/material.dart';

/// A class that can be used as base for classes that store anything
/// related to state management.
/// 
/// The childrens of this class will work in conjunction with [GetSmacMixin]
/// to separate all the logic from the [State] class.
/// 
/// It is highly recomended to atach only one SMaC per state. 
abstract class Smac extends ChangeNotifier {}

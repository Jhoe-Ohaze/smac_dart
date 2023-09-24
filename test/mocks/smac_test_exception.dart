import 'package:smac_dart/core/domain/smac_exception.dart';

class SmacTestException implements SmacException {
  @override
  String get message => 'Test error thrown';
}

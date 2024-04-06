import 'package:smac_dart/core/domain/smac_error.dart';

class SmacTestException extends SmacError {
  const SmacTestException() : super(message: 'Test error thrown');
}

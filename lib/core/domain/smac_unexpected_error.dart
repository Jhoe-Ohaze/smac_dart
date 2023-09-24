import 'package:smac_dart/core/domain/smac_exception.dart';

class SmacUnexpectedError implements SmacException {
  @override
  String get message => 'An unexpected error has occurred!';
}

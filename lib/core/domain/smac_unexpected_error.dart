import 'package:smac_dart/core/domain/smac_error.dart';

class SmacUnexpectedError extends SmacError {
  const SmacUnexpectedError(
    Object? sourceError,
  ) : super(
          message: 'An unexpected error has occurred!',
          sourceError: sourceError,
        );
}

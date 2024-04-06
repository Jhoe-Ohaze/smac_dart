class SmacError implements Exception {
  final String message;
  final Object? _sourceError;

  const SmacError({
    required this.message,
    Object? sourceError,
  }) : _sourceError = sourceError;

  StackTrace? get stackTrace {
    if (_sourceError is Error) {
      return (_sourceError as Error).stackTrace;
    } else {
      return null;
    }
  }

  @override
  String toString() => '$runtimeType: $message';
}

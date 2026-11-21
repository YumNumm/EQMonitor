typedef NonEssentialStartupStepErrorHandler = void Function(
  String name,
  Object error,
  StackTrace stackTrace,
);

class const NonEssentialStartupStep({
  required final NonEssentialStartupStepErrorHandler onError,
}) {
  Future<T?> run<T>({
    required String name,
    required Future<T> Function() action,
  }) async {
    try {
      return await action();
    } on Object catch (error, stackTrace) {
      onError(name, error, stackTrace);
      return null;
    }
  }
}

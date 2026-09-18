enum PasskeyOperation { register, signIn }

final class PasskeyOperationGate {
  PasskeyOperation? _activeOperation;

  bool tryBegin({required PasskeyOperation operation}) {
    if (_activeOperation != null) {
      return false;
    }
    _activeOperation = operation;
    return true;
  }

  void complete({required PasskeyOperation operation}) {
    if (_activeOperation == operation) {
      _activeOperation = null;
    }
  }
}

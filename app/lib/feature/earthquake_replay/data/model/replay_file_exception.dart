enum ReplayFileFailure(final String message) {
  unsupportedSource('このファイルは開けません。デバイスに保存したリプレイファイルを選択してください。'),
  unreadable('ファイルを読み込めませんでした。ファイルをデバイスに保存してから、もう一度お試しください。'),
  invalidFormat('リプレイファイル（.eqrp）として読み込めませんでした。ファイルが破損していないか確認してください。'),
}

class const ReplayFileException(final ReplayFileFailure failure)
    implements Exception {
  @override
  String toString() => failure.message;
}

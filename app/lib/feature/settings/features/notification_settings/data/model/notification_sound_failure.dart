enum NotificationSoundFailure {
  unsupportedFormat,
  invalidAudio,
  sourceUnavailable,
  storageFailure,
  busy,
  durationTooLong,
  invalidName,
  inUse,
}

extension NotificationSoundFailureMessage on NotificationSoundFailure {
  String get message => switch (this) {
    .unsupportedFormat => 'この音声形式には対応していません。別の音声ファイルを選択してください。',
    .invalidAudio => '音声を読み込めません。破損していない音声ファイルを選択してください。',
    .sourceUnavailable => 'ファイルが見つかりません。ファイルをダウンロードするか、もう一度追加してください。',
    .storageFailure => '通知音を読み込み・保存できませんでした。端末の空き容量を確認して再試行してください。',
    .busy => '通知音を処理中です。完了するまでお待ちください。',
    .durationTooLong => '通知音に使える長さは30秒未満です。先頭29.9秒を使用するか確認してください。',
    .invalidName => '通知音の名前を1〜100文字で入力してください。',
    .inUse => '通知設定で使用中です。別の通知音に変更してから削除してください。',
  };
}

class const NotificationSoundException(final NotificationSoundFailure failure)
    implements Exception {
  @override
  String toString() => failure.message;
}

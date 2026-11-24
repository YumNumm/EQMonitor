enum EarthquakeArchiveFailure(final String message) {
  signedOut('ログインが必要です。デバッグメニューの「アカウント」からログインしてください。'),
  forbidden('admin 権限のあるアカウントでログインしてください。'),
  notFound('アーカイブが見つかりませんでした。'),
  unavailable('保存先からファイルを取得できませんでした。時間をおいて、もう一度お試しください。'),
  network('通信できませんでした。接続を確認してください。'),
  invalidFile('取得したファイルをリプレイファイル（.eqrp）として読み込めませんでした。'),
  unknown('アーカイブを取得できませんでした。'),
}

class const EarthquakeArchiveException(final EarthquakeArchiveFailure failure)
    implements Exception {
  @override
  String toString() => failure.message;
}

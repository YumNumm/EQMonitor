enum EarthquakeArchiveFailure(final String message) {
  unauthorized('この端末の認証に失敗しました。アプリを再起動してから、もう一度お試しください。'),
  forbidden('この端末は admin として登録されていません。'),
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

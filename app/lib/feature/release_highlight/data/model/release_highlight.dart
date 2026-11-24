/// アップデート後のホームで案内する新機能。
///
/// 案内したいリリースごとに値を追加する。値が無いリリースでは何も表示しない。
enum ReleaseHighlight({
  /// このバージョン以降へ更新した端末に案内する。
  required final String version,
  required final String title,
  required final String description,
  required final bool isProFeature,
  required final bool isBeta,
}) {
  shakeDetectionNotification(
    version: '3.1.0',
    title: '揺れ検知の通知',
    description: '強震モニタで揺れを検知した時に通知します。地震以外の揺れで通知される場合があります',
    isProFeature: false,
    isBeta: true,
  ),
}

enum ReleaseHighlightAction(final String label) {
  aboutPro('Pro について'),
  notificationSettings('通知を設定'),
}

typedef VisibleReleaseHighlight = ({
  ReleaseHighlight highlight,
  ReleaseHighlightAction primaryAction,
});

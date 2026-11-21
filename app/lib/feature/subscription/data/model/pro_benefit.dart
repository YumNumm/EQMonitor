/// EQMonitor Pro で利用できる機能
enum ProBenefit({
  required final String title,
  required final String description,
}) {
  notificationRegions(
    title: '通知地域を追加',
    description: '通知を受け取る地域を無料プランより多く登録できます',
  ),
  eewHistory(
    title: '緊急地震速報の履歴',
    description: '過去に発表された緊急地震速報の一覧と詳細を確認できます',
  ),
  nearbyEarthquakes(
    title: 'この震源の近傍で発生した地震',
    description: '地震の詳細ページから、付近で発生した地震の履歴を確認できます',
  ),
}

# TestFlight 1933のAnalyticsクラッシュを実機で検証

- Incident: AAA49517-3F99-4375-985A-DB55A33016A0。
- `APMMeasurement networkRemoteConfigFetchCompletionHandler:data:error:` で未認識selector例外。
- 同一スタックのFirebase既知問題と必須 `-ObjC` の欠落を確認し、全構成にフラグを追加した。
- ビルド1933の実際のSDKバージョン・selector名は未確認。クラッシュ解消は未検証。
- [ ] 新しいTestFlightで再インストール・アップデート双方を行い、起動後のAnalytics設定取得を越えて動作することを確認する。
- [ ] 再発時は省略されていない例外名と対象IPAのFirebase/GoogleAppMeasurementバージョンを照合する。
- [ ] 同じビルドで都道府県選択の外周（北海道・鹿児島県・東京都の離島含む）と市区町村選択を実機確認する。

調査根拠: `docs/knowledge/20260927_firebase_analytics_objc_linker.md`。

# 揺れ検知・強震モニタの残課題

数値は元の優先度。

## 160: 揺れ検知の公開テスト再有効化

- 対象: `.github/workflows/deploy-app.yaml`、`app/lib/core/model/environment.dart`、`app/lib/feature/shake_detection/`。
- iOS external / Android external の `IS_SHAKE_DETECTION_ENABLED=false` を解除し、ホームgrid/card、Live Monitor、timeshift自動復帰、`/settings/notification/shake` を確認する。
- このflagはclient表示/購読だけを止める。無効ビルドで既登録のserver pushも止める必要があるなら、server抑止または登録設定削除の仕様を決めて配信テストを追加する。
- 完了条件: 配布trackごとの表示/REST/WebSocket/pushの挙動が仕様と一致する。削除済みの揺れ検知履歴が必要なら、RESTを持つ履歴として別途設計する。

## 080: 強震モニタ data 層

対象: `app/lib/feature/kyoshin_monitor/data/`。

- 高: Android実機で、保存済みの取得元が `kmoni` の状態から更新し、時刻・観測点の表示を確認する。
  `network_security_config.xml` で `www.kmoni.bosai.go.jp` のHTTP通信を許可しているが、
  Cronetでの取得と報告端末での復旧は未検証。`lmoni` への切替と再起動後の表示も確認する。
- 高: `KyoshinMonitorNotifier._fetchAndAnalyzeImage` を注入可能な専用クラスへ分離し、毎秒 `AsyncLoading` に戻す点滅を解消する。補正量の正本をSettings/Adjustmentで二重化せず、永続化をRepositoryへ集約する。
- 高: `timer_stream` の scheduling 時にNTPを引く処理と、補正済みclockから対象時刻を発行する処理の意味を確認する。二重補正の不具合とは断定せず、端末時計＋30秒と小数秒offsetで秒境界・発行時刻の契約をテストする。
- 中: `KyoshinMonitorTimerNotifier` のTimer/StreamControllerと `unawaited` バースト、`delayAdjustType` の4値/2挙動を整理する。`lastUpdatedAt` をappClockへ揃え、未使用色mapファイル3件の参照を確認して削除する。
- 中: lmoniを既定にした状態で長周期階級・周期別画像の実機表示を確認する。最低震度フィルターに影響されないこと、地表固定、種類切替後の更新を確認する。EEW発表中のP/S波画像は未検証。
- 低: 遅延設定UIをhomeから `kyoshin_monitor/ui` へ移す。Mutation/flowは副作用・画面遷移の実際の必要に合わせて導入する。
- 完了条件: 画像取得/解析、遅延判定、時計補正、破棄時のtimer終了をテストでき、毎秒表示を消さずに更新できる。

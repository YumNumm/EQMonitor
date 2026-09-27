# 強震モニタ・時刻・日時表示

2026-09-21統合。時刻と観測値を固定値で補わず、表示timezoneと取得対象時刻を区別する。

## 強震モニタdata層

- 配置は`app/lib/feature/kyoshin_monitor/{ui,data}`、dataはmodel/logic/repository/data_source/notifier/provider。
- ui→notifier/provider、notifier→repository/provider/logic、repository→DataSource/Prefs/Isolate。
  NotifierからDataSourceを直接呼ばない。
- providerは計算の合成だけでI/O・状態保持なし、logicはmodelだけに依存しRef・可変fieldなし。
  modelから他層へ依存しない。画面遷移が必要になるまでdata/flowを作らない。
- 処理はTimeSync→ImageDelay→TargetTime→画像取得→Adjustment（404学習）。
- サンプル保持はKyoshinMonitorTimeSyncSamplesNotifier、公開遅延はkyoshinMonitorImageDelayProvider。
  layer/source/delayProfileはKyoshinMonitorImageRequestが持つ。曖昧なeffectiveXxxを増やさない。
- 補正量のruntime正本はAdjustment Notifier。現状はSettings.api.offsetAdjustmentsへ永続化を書き戻す。
  この二重保持の整理は[リアルタイムモニタ残件](../todo/160_realtime_monitor_followups.md)で追跡する。

## 時計の確認済み事実と残件

- `app/lib/core/provider/clock/app_clock.dart`のnowはclock.nowにNTP offsetを加え、
  realtime/time-shift/replayで共通の基準を返す。
- `app/lib/feature/kyoshin_monitor/data/provider/kyoshin_monitor_timer_stream.dart`は
  発行時にappClockから公開遅延を引く。schedule側ではappClockからNTP offsetを引いており、
  秒境界の意味を別途確認する必要がある。静的確認だけで二重補正による不具合と断定しない。
- `app/lib/feature/kyoshin_monitor/data/notifier/kyoshin_monitor_notifier.dart`には
  privateの_fetchAndAnalyzeImage、取得ごとのAsyncLoading代入、lastUpdatedAtのDateTime.nowが残る。
  UIのちらつきや遅延判定への影響は計測・回帰確認し、共通clockとtimestampの意味を揃える。
- 端末時計が30秒進むケースを維持し、fractional NTP offset、公開遅延、pause/replayも確認する。

## LMoni配信経路

- 通常画像は`/img_svr/data/map_img/RealTimeImg/{type}_{layer}/...`。
- 長周期画像は`/monitor/data/data/map_img/RealTimeImg/{type}_s/...`。
  地中画像はないため保存設定が地中でも_sを使い、_bを組み立てない。
- 日時は公開済みのJSTを使う。取得失敗を別layerや固定値へ置換せず、エラーとして調査する。
- 公式画面の通信・JavaScriptを配信形式確認の基準にする。参考ライブラリの古いhostをコピーしない。
  [LMoni](https://www.lmoni.bosai.go.jp/monitor/)、
  [利用上の注意](https://www.kyoshin.bosai.go.jp/ja/about_lmoni/)を参照する。

## 画像解析の高速化は計測から

- 2026-08-14の計測対象は352×400 GIF、観測点1749点。全pixelではなく指定座標を解析する。
  当時の経路は常駐workerでGIF decode→HSV/多項式scale→GeoJSON生成。
- GPU化してもGIF decode・GeoJSON生成・結果readbackが残る。background isolateのdart:ui制約もある。
- Flutter GPUは実験候補。旧資料の3.44/3.47の可否は現在のtoolchain保証にせず、pinされたSDK APIを確認する。
- parseMicros、geoJsonBuildMicros、画像取得、MapLibre source更新をprofile実機で測る。
  RGB変換cache、ui.Codec、GPU候補を分けて比較する。
- GPU候補はTexture.fromImageの利用可否を確認し、観測点だけnearest sampling、結果だけreadbackする。
  CPU基準経路との全palette/RGB境界値一致、iOS/Android Vulkan/OpenGLのP50/P95/P99を確認する。
- double/float差、地図GPU負荷、raster、温度、消費電力まで比較し、速さと一致を満たすまで
  本番の唯一経路にしない。GPU失敗を固定観測値へフォールバックしない。

## JST表示とK-NET

- 画面・診断の日時はDateTime.formatWithTz(DateTimeFormat)。ISO編集表示はtokyoDateTimeへ変換する。
  enum側でDateFormatをcacheするため、各画面でformatterを作らない。
- 起動時はcore.initializeTimeZonesを先に完了する。Flutter testはapp/test/flutter_test_config.dartで初期化する。
- API送信・永続化・識別子・検索条件の日付は表示処理ではないため既存契約を維持する。
- K-NET/KiK-netのYYYYMMDDHHmmssディレクトリはAsia/Tokyoとして解析し、
  KnetDirectoryParser.parseRecordsはTZDateTimeを返す。図・動画・ZIP URLにも同じ日時成分を使う。
  UTC化して成分を変えると実ディレクトリと一致しなくなる。利用前にtimezone DBを初期化する。

## 検証

```sh
# app/から
mise exec -- flutter test test/feature/kyoshin_monitor test/core/util/date_time_format_test.dart --dart-define=CI=true
mise exec -- dart analyze lib/feature/kyoshin_monitor/data
# packages/knet_api_client/から
mise exec -- dart test
mise exec -- dart analyze
```

本統合は上記コードの静的確認のみ。新たな画像取得・GPU benchmark・clock試験は実行していない。

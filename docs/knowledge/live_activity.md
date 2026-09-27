# Live Activityの受信・表示・検証

2026-09-21統合。表示規則は2026-09-07のデザイン更新を基準とし、旧Dynamic Island配置や
最大震度の灰色塗りつぶし規則を置き換える。Flutter側の震度外観まで変更する規則ではない。

## 入力と配信

- 本番表示の入力はbackendがAPNsへ渡す`content-state`。アプリのカードから表示をコピーしない。
- Codableの1フィールドの失敗でActivity全体が出なくなるため、未使用・欠損し得る項目を
  安易に必須化しない。`docs/live-activity-specification.md`と受信モデルを照合する。
- 未知の揺れ検知enum等でcompact/minimalを空にせず、値を偽らない代替表示を用意する。
- 日時は`app/ios/Shared/LiveActivityDate.swift`の`LiveActivityDate.parse`で解析する。
  ISO8601既定formatterだけでは小数秒やDB由来表現を受理できない。
- 固定時刻は`JSTDateFormat`でJST表示する。`Text(date, style: .time)`の端末timezoneに依存しない。
- Broadcast購読を伴うpush-to-startは`input-push-channel: <channel ID>`を指定する。
  update/endやchannel管理は`apns-channel-id`。startに後者を使うと更新・終了を受け取れない。
- startとupdate/endのchannel・APNs環境を照合する。旧記録の「production固定経路」は
  backendの過去調査であり、現在の配信状態は本統合で確認していない。

## 発表値・現在地・取消

- 判断は`app/ios/Shared/EewDisplay.swift`へ集約する。現在地予想震度は予報なら4以上、
  警報なら提供された値を表示し、欠けた値を補わない。
- 現在地警報帯は`location.isWarning`を使う。電文全体の警報フラグだけで出さない。
- 現在地が警報対象なら`現在地で強い揺れ`。対象外で表示可能な震度が2未満なら
  `現在地で弱い揺れ`（背景`#CDEEFF`・黒文字）、2以上なら`現在地で揺れ`。
  震度欠落を弱い揺れとみなさない。
- Compact/Minimalの現在地震度は塗りつぶしあり、全国最大震度は塗りつぶしなし＋`MAX`。
  未発表でも`MAX -`の枠を維持する。
- 取消では残存する震源・M・深さ・震度・到達予想を抑止する。種別は`緊急地震速報`、
  見出しは取消を伝え、`(取消)`や「予想は無効です」の説明を加えない。
- Expanded取消は不可視・アクセシビリティ対象外の最大震度枠で配置を維持し、左上記号を出さない。
- PLUM・レベル法・1点検知はM/深さを隠し、検知方法を明示する。
- 深発注意文は非取消・非低精度・最大震度未発表・`depth > 150`の全条件。
  Lock Screenに出し、狭いDynamic Islandには載せない。
- Expandedで現在地震度を出さない場合は、非取消で解析できる発生/検知時刻を見出し下へ出す。
  元の`timeLabel`とJST表示を使い、受信時刻などを補わない。
- 全国最大LPGMを現在地の`forecastLpgmIntensity`で代用しない。
  配信契約の残件は[Apple拡張](../todo/930_apple_extensions.md)。

## タイマーと現在の外観

- 取消・現在地震度非表示・現在地PLUMではカウントダウンを出さない。
- `ArrivalCountdown.remaining`は1回の現在時刻から範囲を作り、到達後は`arrival...arrival`。
  下限が上限を超える範囲を作らない。
- Live Activityのbodyは秒読みだけで再評価されない。到達後も`主要動到達まで 00:00`を維持し、
  到達時の文言切替に`staleDate`を使わない。EEWのstaleは開始/更新から30分後の別契約。
- タイマーと幅確保用のhidden placeholderは同じフォントを使用する。
- 濃色ヘッダーは白、補助文字は白70%。現在の黒背景EEW本文も白を明示し、
  Light AppearanceのLock Screenには黒背景を明示する。旧「本文は常に.primary」を流用しない。
- ヘッダーのしましまは`StripePattern`、取消の灰色を維持する。
- Expandedはleading/trailing/bottomを分け、OS標準外周余白を維持する。
  単一leading＋`belowIfTooWide`やカメラ高さ固定・負paddingで補正しない。
- `ViewThatFits(in: .vertical)`の候補測定にのみ`fixedSize`を使い、高さ不足時は
  震度44pt・見出し1行へ切替える（通常56pt・2行）。下部左右・下に8ptを確保する。
- 警報名・取消報数・低精度ラベルなど混在文はシステムフォント。数値はGoogle Sans Code。
  M/深さの縦積みspacingは0、Expanded最大震度38pt・震源数値21ptを基準とする。
- MAXは数字の右上へ置き左右4ptを確保する。単数字だけ縦積みにして行高を変えない。
  カメラ脇の混在文の外側にも4ptを確保し、切り取りをCanvasで確認する。
- 注意帯・現在地震度背景・低精度ラベルは`ContainerRelativeShape()`を使い、
  独自containerShapeでIsland全体の形状を上書きしない。

## ローカルデバッグとPreview

- ローカル開始は`net.yumnumm.eqmonitor/live_activity_debug` MethodChannelからActivityKitを呼ぶ。
  APNs配信の確認とは別。コード確認時のnative startは`eew`だけを受理しているため、
  旧文書の「揺れ検知もローカル開始可能」を現行の保証にしない。
- JSONキーはSwift CodableのcamelCase、震度は`IntensityValue`のrawValueへ合わせる。
  RunnerとWidgetの重複Attributes定義は型名・フィールドを同期する。描画紐付けは実機確認する。
- `EQMonitorPreview`スキームで`EQMonitorPreviewWidgetBundle.swift`の`EEW デザイン確認`を開く。
  Lock Screen / Expanded / Compact / Minimalで同じ状態一覧を使う。
- 警報対象/対象外、予報4/3、現在地なし、到達なし、警報だが震度なし、取消、深発、PLUM、
  対象外震度1/2を確認する。カウントダウンは生成時点から31秒。Canvasを再生成して確認する。
- 200%で警報名末尾、帯・バッジの四隅、到達予想下端を確認する。
  Figma基準はLock Screen `1628:1745`、Expanded `1628:1694`。
- `Shared/`追加はXcode Sources所属、`Widget/`追加はPreview側membershipを確認する。
  Previewターゲット構成は [軽量 Preview](apple_previews.md) を参照。

## 検証範囲

コード確認済み: `EewDisplay.swift`の現在地・取消・深発判定、
`app/ios/Runner/LiveActivityDebugMethodChannel.swift`のEEWローカル開始。
本統合ではビルド・Canvas・実機配信を再実行していない。

```sh
# repository rootから。Simulator IDは利用可能なものを指定する
xcodebuild build -project app/ios/Runner.xcodeproj -scheme EQMonitorPreview \
  -destination 'generic/platform=iOS Simulator' CODE_SIGNING_ALLOWED=NO
xcodebuild test -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests \
  -destination 'platform=iOS Simulator,id=<SIMULATOR_ID>' CODE_SIGNING_ALLOWED=NO
```

モデルテスト成功はSwiftUIの収まり・APNs更新・終了の証明ではない。
Widget の最低 OS は本番 target と Preview で揃え、新 API は availability で限定する。AppIntentExtension の設定とは分けて確認する。
旧テスト件数、SDK番号、当時のAPIルート欠落は現在の合格/不合格判定に転用しない。

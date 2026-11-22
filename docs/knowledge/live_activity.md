# Live Activityの受信・表示・検証

2026-09-21統合。表示規則は2026-09-07のデザイン更新を基準とし、旧Dynamic Island配置や
最大震度の灰色塗りつぶし規則を置き換える。Flutter側の震度外観まで変更する規則ではない。

## 入力と配信

- Live Activity は `EewLiveActivityAttributes` を受け取る EEW 専用表示を使用する。通常の地震情報はホーム画面の `EarthquakeWidget` で表示する。
- `EQMLiveActivityUtil.isLiveActivitySupported()`はiOS 16.1以上でMac・Vision上の実行を除外する。
  `isiOSAppOnVision`のavailabilityはVision判定だけに適用し、通常のiPhoneをiOS 26.1未満で
  非対応にしない。push-to-startの対応判定は引き続きiOS 18.0以上。
- 本番表示の入力はbackendがAPNsへ渡す`content-state`。アプリのカードから表示をコピーしない。
- Codableの1フィールドの失敗でActivity全体が出なくなるため、未使用・欠損し得る項目を
  安易に必須化しない。`docs/live-activity-specification.md`と受信モデルを照合する。
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
- 現在地が警報対象なら`強い揺れに警戒!`。対象外で表示可能な震度が2未満なら
  `現在地で弱い揺れ`（背景`#CDEEFF`・黒文字）、2以上なら`現在地で揺れ`。
  震度欠落を弱い揺れとみなさない。
- Compact/Minimalの現在地震度は塗りつぶしあり、全国最大震度は塗りつぶしなし＋`MAX`。
  未発表でも`MAX -`の枠を維持する。
- 取消では残存する震源・M・深さ・震度・到達予想を抑止する。種別は`緊急地震速報`、
  見出しは取消を伝え、`(取消)`や「予想は無効です」の説明を加えない。
- Expanded取消は不可視・アクセシビリティ対象外の最大震度枠で配置を維持し、左上記号を出さない。
- PLUM・レベル法・1点検知はM/深さを隠し、検知方法を明示する。
- 深発注意文は非取消・非低精度・最大震度未発表・`depth > 150`の全条件。
  Lock Screenでは震源要素の右へ2行で置く。行を足すと上限160ptを超え、他の文字が縮む。
  現在地欄を出す場合は現在地欄を優先し、狭いDynamic Islandには載せない。
- Expandedで現在地震度を出さない場合は、非取消で解析できる発生/検知時刻を見出し下へ出す。
  元の`timeLabel`とJST表示を使い、受信時刻などを補わない。
- 全国最大LPGMを現在地の`forecastLpgmIntensity`で代用しない。
  配信契約の残件は[Apple拡張](../todo/930_apple_extensions.md)。

## タイマーと現在の外観

- 受信Headlineの改行文字は表示前に除去する（LF・CRLFなど）。受信値を保持し、取消報の主文への差し替えは優先する。

- 取消・現在地震度非表示・現在地PLUMではカウントダウンを出さない。現在地PLUMは代わりに`すぐに到達`を出す。
- `ArrivalCountdown.remaining`は1回の現在時刻から範囲を作り、到達後は`arrival...arrival`。
  下限が上限を超える範囲を作らない。
- Live Activityのbodyは秒読みだけで再評価されない。到達後も`主要動到達まで 00:00`（0.1秒単位の表示では`0秒`）を維持し、
  到達時の文言切替に`staleDate`を使わない。EEWのstaleは開始/更新から30分後の別契約。
- タイマーと幅確保用のhidden placeholderは同じフォントを使用する。0.1秒表示は下の「点滅と到達カウントダウン」を参照。
- タイマー文字のアニメーションはAppleの案内どおり`contentTransition(.numericText(countsDown:))`で要求している。
  ただしiOS 27 SimulatorのDynamic Island（Compact）を録画すると、毎秒の切り替わりは1フレームで、
  数字は動かない。`Text(_:style: .timer)`、システムフォント、`transaction`や`animation(_:value:)`の
  追加でも同じ。実機での挙動は未確認。同じ条件で`ProgressView(timerInterval:)`は連続して動く。
- EEWのLock Screenの発生・検知日時は、幅に応じて1行、ラベルと日時の2行、ラベル・日付・時刻の3行に切り替える。時刻の途中で分割・省略しない。
- 現在地の地域名は表示時に全角数字のみ半角化する。EEWのLock Screenでは現在地欄の幅を優先し、地域名は最大2行で表示する。
- EEWのLock Screenの現在地欄は、予想震度と到達予想がそろうとき地名を出さず、`現在地`／`揺れ到達まで`の2行と
  26ptのカウントダウンにする。どちらかが欠けるときは従来どおり`現在地`と地名を出す。
- 濃色ヘッダーは白、補助文字は白70%。現在の黒背景EEW本文も白を明示し、
  Light AppearanceのLock Screenには黒背景を明示する。旧「本文は常に.primary」を流用しない。
- ヘッダーのしましまは`StripePattern`、取消の灰色を維持する。
- Expandedのleading/trailing/bottomは左右の余白を`EewExpandedMetrics.horizontalInset`で揃える。
  領域ごとに別の値を使うと、最大震度・M/深さと下段の文字の端がずれる。M/深さの縦積みは右揃え。
- Expandedの発生/検知日時はLock Screenと同じGoogle Sans Codeにする。
- Expandedはleading/trailing/bottomを分け、OS標準外周余白を維持する。
  単一leading＋`belowIfTooWide`やカメラ高さ固定・負paddingで補正しない。
- `ViewThatFits(in: .vertical)`の候補測定にのみ`fixedSize`を使い、高さ不足時は
  震度44pt・見出し1行へ切替える（通常56pt・2行）。下部左右・下に8ptを確保する。
- `lineLimit(1)`＋`minimumScaleFactor`のTextは高さ方向にも縮む。Lock Screenの内容が160ptを
  超えるとヘッダーやM/深さが最小倍率まで縮小されるため、`fixedSize(horizontal: false, vertical: true)`で
  高さを固定する。
- Mの数値は小数点の前後だけを詰める（`size * -0.14`）。数値全体へのtrackingは縮小時に数字が重なる。
- Compact/Minimalの`MAX`は左右に余白を取る。太字が字送り幅いっぱいに描画され左端で欠ける。
- Compactの現在地震度バッジも左へ4pt寄せる。余白なしだとIslandの丸い端で左の角が欠ける
  （オフスクリーン描画では再現せず、Simulatorの実Islandで確認）。
- 警報名・取消報数・低精度ラベルなど混在文はシステムフォント。数値はGoogle Sans Code。
  M/深さの縦積みspacingは0、Expanded最大震度38pt・震源数値21ptを基準とする。
- MAXは数字の右上へ置き左右4ptを確保する。単数字だけ縦積みにして行高を変えない。
  カメラ脇の混在文の外側にも4ptを確保し、切り取りをCanvasで確認する。
- 注意帯・低精度ラベルは`ContainerRelativeShape()`を使い、
  独自containerShapeでIsland全体の形状を上書きしない。
- Expandedの現在地震度バッジは他の表示と同じ角丸（半径は大きさの0.2倍）にする。`ContainerRelativeShape()`だと
  Islandの形に沿ってほぼ円になる。角丸でもIslandの角で欠けない（Simulatorの実Islandで確認）。

## Apple Watch・CarPlay（`.small`）

- iOS 18以降は`supplementalActivityFamilies([.small])`を付け、`activityFamily`が`.small`のとき
  `EewSmallActivityView`を出す。未対応のままだとSmart StackにはCompactのleading/trailingが出る。
- 最低OSが18未満のため、`if #available`の分岐で構成を返し分ける（不透明型の分岐はSE-0360で可）。
  `WidgetBundle`のbuilderは`else`を扱えないので、Widgetを2つに分けて出し分ける方法は使えない。
- 表示は現在地を主役にする。現在地の情報があれば予想震度と到達まで、無ければ全国の最大震度と
  見出し・M/深さ。取消は記号と主文のみ。
- `Widget/`へ追加したファイルはPreview側の`membershipExceptions`にも追加する。
- 現在地が警報対象のときの見た目は下の「現在地が警報対象のときの強調」に従う。
- 寸法はWatchが152x69.5〜198x81.5pt、CarPlayが170x78・240x78・240x100pt。
  幅170pt未満（40mm・41mm）では余白・震度・記号を詰める。詰めないと長い見出しが1行で切れる。
  要素を足すときは152pt幅で確認する。

## 表示される場所の一覧

| 場所 | 使われる表示 | 確認方法 |
|---|---|---|
| Lock Screen（iPhone/iPad）・Islandのない端末のバナー | `EewLockScreenView` | オフスクリーン描画（幅371/425/500pt） |
| スタンバイ | 最初はMinimal、タップでLock Screen表示を2倍に拡大 | 2倍描画で代用。実機未確認 |
| 常時表示（輝度低下）・スタンバイの夜間モード | Lock Screen表示をシステムが減光・赤着色 | 実機でのみ確認可 |
| Dynamic Island / Macのメニューバー | Compact・Minimal・Expanded | Simulatorの実Island |
| 幅が狭いDynamic Island（iOS 27〜） | Compactを直径28ptの円に収める | オフスクリーン描画。実機未確認 |
| Apple Watch Smart Stack・CarPlay | `.small`（`EewSmallActivityView`） | オフスクリーン描画。実機未確認 |

- スタンバイは独自の背景色を画面全体へ広げる。黒を指定しているので端まで黒になる。
  専用レイアウトが必要なら`isActivityFullscreen`で分岐する（現状は分岐なし）。
- 幅が狭いDynamic Islandは`isDynamicIslandLimitedInWidth`（iOS 27〜）で判定する。横向き、
  複数のLive Activityが並ぶ端末で起きる。`DynamicIslandWidthReader`で受け、震度バッジを21pt、
  カウントダウンを11pt・分1桁幅、状態ピルの余白を3ptへ詰める。

## 現在地が警報対象のときの強調

- Lock Screen・Dynamic Island・スモール表示で共通（`EewAlertStyle`、`EewAlertBlinkHighlight`）。
- 条件は`locationNotice == .warning`だけ。警報でも現在地が対象外なら色を付けない
  （現在地に警報が出たとの誤解を避ける）。
- 地色を暗い赤にする（Lock Screen・スモール表示。Viewの塗りと`activityBackgroundTint`を同じ色に
  そろえる）。Dynamic Islandの地色は常に黒で変えられない。
- `強い揺れに警戒!`の背景を濃い赤で0.5秒おきに点滅させる（iOS 17は1秒おき）。文字は常に白、枠線は付けない。
  Lock Screenは発生時刻の下、Expandedは下部の帯、スモール表示は主文。
- 到達カウントダウンは点滅させない。

## 外観と文字サイズ

- 各表示の根元に`liveActivityFixedTypeSize()`を付け、Dynamic Typeに追従させない。
  `Font.custom(_:size:)`は既定で追従し、最大設定ではLock Screenが843ptになり中身が切り取られる
  （xxxLargeでも189pt）。上限160ptに余裕がないため、標準の大きさに固定する。
- 地色は外観に依らず黒か暗い赤。文字や記号に外観で変わる色（`eqTextSecondary`など）を使うと
  ライトモードで暗く沈む。Live Activity内は固定色にする。
- Lock Screenは`activityBackgroundTint`に不透明色を渡しているため、壁紙の明るさの影響を受けない想定
  （実機のロック画面では未確認）。

## アプリ内のテスト表示

- 通知テスト画面のテスト表示は開始・更新から1分で自動終了し、終了ボタンに残り時間を出す
  （`TestLiveActivityNotifier`）。Dartのタイマーはアプリの停止中は動かないため、ロック中に1分を
  過ぎた表示はアプリが前面へ戻ったときに終了する。期限が分からない表示（再起動前のもの）も終了する。
- Compact/Minimalの「試」は出さない。テストの区別はLock Screen・Expanded・スモール表示の`【テスト】`で行う。
- テスト・デバッグ用の警報プリセットは`location.isWarning`を`true`で送る。無いと現在地は警報対象外の
  扱いになり、警戒文と赤い地色が出ない。

## Lock Screenの高さ（上限160pt）

- 内訳は上下余白24pt＋ヘッダー62pt＋間隔＋本文。現在地欄は68ptあり、間隔6ptでちょうど160pt。
  `ImageRenderer`に`fixedSize(horizontal: false, vertical: true)`を付けて実高さを測る。
  `frame(maxHeight: 160)`での目視だけでは数ptの超過を見落とす。
- ヘッダーの最大震度は高さ40ptの枠に固定する。1桁の震度はMAXを上へ積むぶん約9pt高く、
  固定しないとヘッダーが伸びて全体が160ptを超える。
- M・深さは空きがあるとき28pt（32ptは実機で大きすぎた）。警戒文を挟むとき（3行）と深発注意文と並ぶときは既定の大きさ。
  警戒文を挟む左列は間隔2ptで68ptに収める。

## 点滅と到達カウントダウン

- 仕組み（システムが描く時刻の文字と専用フォント）は [動く表示の作り方](live_activity_timer_font.md) にまとめている。
- 点滅（`BlinkBlock`）は iOS 18以降が0.5秒おき、iOS 17が1秒おき。
- 到達カウントダウン（`ArrivalCountdownText`）は iOS 18以降が `8.5秒`（1分以上は `1:15.3`、到達後は `0秒`）。
  iOS 17、常時表示（輝度低下）、幅が狭い Dynamic Island は `M:SS`。
- Lock Screen の現在地欄のカウントダウンは右寄せにする。桁数が変わっても小数点と `秒` の位置が動かない。

## 現在地がPLUM法のとき

- 到達時刻は発表されないため、カウントダウンの代わりに`すぐに到達`を出す（`EewDisplay.showsImminentArrival`、
  `EewImminentArrivalText`）。条件は現在地の予想震度を表示していて、現在地がPLUM法であること。
  現在地の`isPlum`が無くても、報全体が`isPlum`なら現在地もPLUM法として扱う（デバッグ用プリセットは
  報全体の`isPlum`だけを送る）。
- Lock Screenは`現在地`の下、Expandedは震度バッジの左、スモール表示は主文の下。Compactは幅が無いので
  `すぐに`／`到達`の2行。幅が狭いDynamic Islandは従来どおり状態ピル。

## ローカルデバッグとPreview

- ローカル開始は`net.yumnumm.eqmonitor/live_activity_debug` MethodChannelからActivityKitを呼ぶ。
  APNs配信の確認とは別。コード確認時のnative startは`eew`だけを受理しているため、
  旧文書の「揺れ検知もローカル開始可能」を現行の保証にしない。
- JSONキーはSwift CodableのcamelCase、震度は`IntensityValue`のrawValueへ合わせる。
  RunnerとWidgetの重複Attributes定義は型名・フィールドを同期する。描画紐付けは実機確認する。
  Runner側に無いキーはデコードで捨てられ、Widgetへ渡らない。`location.isWarning` が欠けると
  現在地の警報表示（赤い地色と点滅）にならず、通常の予想震度表示になる。
- `EQMonitorPreview`スキームで`EQMonitorPreviewWidgetBundle.swift`の`EEW デザイン確認`を開く。
  Lock Screen / Expanded / Compact / Minimalで同じ状態一覧を使う。
- 警報対象/対象外、予報4/3、現在地なし、到達なし、警報だが震度なし、取消、深発、PLUM、
  対象外震度1/2を確認する。カウントダウンは生成時点から31秒。Canvasを再生成して確認する。
- 200%で警報名末尾、帯・バッジの四隅、到達予想下端を確認する。
  Figma基準はLock Screen `1628:1745`、Expanded `1628:1694`。
- `Shared/`追加はXcode Sources所属、`Widget/`追加はPreview側membershipを確認する。
  Previewターゲット構成は [軽量 Preview](apple_previews.md) を参照。

- Lock Screen表示だけを画像にするには、`Shared/`と`Widget/LiveActivity/`のSwiftを`xcrun -sdk iphonesimulator swiftc`で
  1つの実行ファイルにまとめ、`xcrun simctl spawn <起動済みSimulator> <実行ファイル>`で動かして`ImageRenderer`の結果をPNGに書き出す。
  Xcodeのビルドは要らない。`IntensityValue.swift`は`EQMonitorAPI`に依存する変換を除いた写しを使い、`EewSmallActivityView.swift`は外す。
  フォントは`CTFontManagerRegisterFontsForURL`へ`app/assets/fonts`と`Widget/LiveActivity/Common`のTTFを直接渡す。
  点滅は描画時刻で塗りの有無が変わる。最初の描画は遅いため数回空描きしてから、秒の前半に合わせて撮る。
  `ContainerRelativeShape`は外枠が無く四角になる。

- Simulatorで実際のExpandedを撮るには、Activityをバックグラウンドから`AlertConfiguration`付きで
  更新する。Dynamic Islandが数秒展開するので`simctl io screenshot`で撮れる（CompactはHomeへ戻れば写る）。
  Lock Screenは`simctl`からロックする手段がなく、この方法では撮れない。

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

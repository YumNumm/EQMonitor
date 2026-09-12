# Task 1 report: Swift unified Live Activity contract foundation

Status: DONE_WITH_CONCERNS

## 実装

- backend `00f2caf9ffef0861f0b9a52cca675593d9c60409` の Valibot schema を Swift の型へ対応付けた。
- `EarthquakeLiveActivityAttributes` は非空の opaque ID のみを保持し、未知キーを拒否する。
- schema v2 の full snapshot、typed timestamp、primary enum、shake/EEW/earthquake、tagged magnitude、震度 enum を実装した。
- required nullable は欠落を拒否し、encode 時も `null` を明示する。EEW location 内の optional は欠落を許可し、明示 `null` を拒否する。
- primary が指す block、有限数、非負 serial、`isPlum: true`、strict attributes/magnitude を検証する。
- backend canonical JSON を byte-identical に共有 fixture へ固定した。matrix は29件で、valid 14件、invalid 15件、7 block combinations、12 primary assignments を含む。
- `IntensityValue` / `LpgmIntensityValue` と `ShakeDetectionLevel` の wire 定義を共有ターゲットから参照できるよう分離した。既存表示ロジックの動作は変更していない。
- Runner、WidgetExtension、EQMonitorPreviewWidget、WidgetModelsTests の target membership と fixture resources を追加した。

## 所有ファイル

- `app/ios/Shared/LiveActivity/EarthquakeLiveActivityAttributes.swift`
- `app/ios/Shared/LiveActivity/LiveActivityTimestamp.swift`
- `app/ios/Shared/LiveActivity/UnifiedLiveActivityContentState.swift`
- `app/ios/Shared/LiveActivity/UnifiedLiveActivityMagnitude.swift`
- `app/ios/Shared/LiveActivity/UnifiedShakeDetection.swift`
- `app/ios/Shared/LiveActivity/UnifiedEew.swift`
- `app/ios/Shared/LiveActivity/UnifiedEarthquake.swift`
- `app/ios/Shared/IntensityValue.swift`
- `app/ios/Shared/IntensityValuePresentation.swift`
- `app/ios/Widget/LiveActivity/ShakeDetection/ShakeDetectionLiveActivityAttributes.swift`
- `app/ios/WidgetModelsTests/UnifiedLiveActivityContractTests.swift`
- `app/test/fixtures/live_activity/unified/{README.md,canonical.json,matrix.json}`
- `app/ios/Runner.xcodeproj/project.pbxproj`

## 検証

- RED: 型実装前の `WidgetModelsTests` compile failure を `/tmp/task1-red.log` に取得した。
- RED/GREEN: timestamp の末尾 junk と存在しない日付を追加し、2件失敗を `/tmp/task1-timestamp-red.log`、修正後成功を `/tmp/task1-timestamp-green.log` に取得した。
- RED/GREEN: required nullable の encode 欠落を `/tmp/task1-null-full-red.log` で確認し、明示 `null` 実装後に成功した。
- 最終: `mise exec -- xcodebuild test -project app/ios/Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=iOS Simulator,id=0B787467-006E-416D-9907-449087A45988' -only-testing:WidgetModelsTests/UnifiedLiveActivityContractTests CODE_SIGNING_ALLOWED=NO` は5 tests成功。valid 14件すべての Attributes / ContentState decode-encode-decode を含む。ログは `/tmp/task1-matrix-roundtrip-green.log`。
- canonical fixture は backend sample と `cmp` 一致し、双方の SHA-256 は `48beb3216702dd742419037423b2b208bed5c8bf881a252b8fccd65bcc4bcf5c`。
- `git diff --check` 成功、`plutil -lint app/ios/Runner.xcodeproj/project.pbxproj` 成功。

## コミット

- `c82cfd1af` test: 統合Live Activity契約fixtureを固定
- `c7efcc141` feat: Live Activity共通属性と値型を追加
- `1f73c354a` feat: 統合Live Activity状態モデルを追加
- `2daded82b` refactor: Live Activity列挙型を共有化
- `bceb7ab96` build: 統合Live Activityモデルを各ターゲットへ接続

## 未確認・制約

- WidgetExtension の広い simulator build は、この worktree で Flutter module を解決できず既存 plugin compile が停止した。後続 UI 統合後に root が広い build を行う。
- `ISO8601DateFormatter` は encode 時に UTC のミリ秒精度へ正規化する。backend canonical sample と matrix は最大3桁だが、将来6桁 fraction が届く場合はサブミリ秒精度を保持しない。
- APNs delivery、ActivityKit の開始・更新・終了、UI、実機はこの Task の検証範囲外。
- Xcode が更新した `Package.resolved` は Task1へ含めていない。誤生成された `app/ios/Runner.xcodeproj/-Xcc/` は削除した。

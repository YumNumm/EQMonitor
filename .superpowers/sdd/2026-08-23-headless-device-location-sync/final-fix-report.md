# Final fix report

## 結果

final whole-branch reviewの4件をすべて修正した。既存のprivacy、consumer別acknowledge、HTTP 400だけを
terminalとするretry契約は維持している。pushは実施していない。

## 変更概要

1. last-success dedupeをDevice Location API endpointとdevice registration generationのscopeへ
   紐付けた。backend URL切替と404再登録後は、同じ地域でも新scopeへ送信する。generationは非機密UUID
   とし、device tokenは従来どおりSecureStorageだけへ保存する。SharedPreferencesにtokenやhashは保存しない。
2. 通常Engineとheadless Engineが共有するnative永続leaseをPigeonへ追加した。期限内の競合送信を拒否し、
   crash後は期限切れで回復する。応答時にlease所有権とnative pending最新版のupdate IDを再確認し、古い応答
   はlast-successへcommitしない。反転応答回帰テストを追加した。
3. 起動時、notification slotの作成・削除・一括置換、揺れ検知現在地entryの追加・削除を共通reconcileへ
   統一した。どちらかのconsumerがあればstart、両方が既知で消失していればstop、片方の取得失敗時は誤停止を
   避けてOS状態を維持する。
4. Androidの`blt_prefs.xml`をlegacy backup、cloud backup、device transferから除外した。iOSはraw pending
   のfile/directoryへbackup除外属性を付け、初回作成・atomic replace・失敗時rollbackのすべてでfile protection
   とbackup除外属性を維持する。
5. 運用知見を`docs/knowledge/20260824_device_location_sync_concurrency_privacy.md`へ記録した。

## TDDで確認した主な失敗

- scope型とregistration generationが未実装の状態でDartテストがcompile failure。
- 2 Engine反転応答テストで、競合送信と古いlast-success更新を再現。
- Android/iOSの永続leaseテストでnative store未実装のcompile failure。
- 監視reconcileテストでAPI未実装のcompile failure、および削除/一括置換経路でstop未呼び出しを再現。
- Android backup契約テストでmanifest属性欠落、iOS XCTestで作成・replace・rollback後のbackup除外欠落を再現。

## コミット

以下は実装修正のコミット。本レポート自身はbranch HEADの`docs: 最終修正結果を記録`に含めた。

- `b9828e73a` fix: 位置同期成功値をbackend scopeへ紐付け
- `1d30fe44b` fix: device再登録で位置同期世代を更新
- `76b17bbd5` refactor: 通常とheadlessで位置同期scopeを共有
- `06d18a85f` fix: 位置同期の反転応答をleaseで抑止
- `d620bf6ae` feat: 位置同期leaseのnative契約を生成
- `170a42e92` feat: Android位置同期leaseを永続化
- `6a0e611d2` feat: iOS位置同期leaseを永続化
- `e28d6cc67` feat: 通常とheadlessでnative leaseを共有
- `e1c7ba1c9` fix: 起動時に位置監視状態をreconcile
- `0f969e158` fix: consumer変更後に位置監視をreconcile
- `91d65d86b` fix: Android raw位置情報をbackup対象外に設定
- `cd6d9d6b8` fix: iOS raw位置情報のbackup除外属性を維持
- `f7b917894` docs: 位置同期の競合とprivacy境界を記録
- `2f3be08ca` style: 位置同期leaseのconstructor表記を統一
- `582d96991` test: headless同期builderへleaseを注入可能にする

## 検証

### 生成・静的解析

- Pigeon 26.3.4をanalyzer 12.1.0の分離環境から実行し、Dart/Swift/Kotlinを再生成した。
  workspaceのanalyzer 13.3.0で直接実行すると既知のversion衝突で失敗するため、knowledge記載の分離手順を使用。
- `mise exec -- dart analyze ...`（変更対象のlocation、device auth/generation、notification notifier、
  plugin lib/pigeons、関連test）: `No issues found!`
- 再生成後の生成物: 未コミット差分なし。

### Flutter

- 関連11 test fileを同時実行: `116 tests passed`。
  scope/reprovision、token非保存、反転応答、ack/retry、監視reconcile、backup policy、headless地域解決を含む。

### Android

- `mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest :app:assembleDebug --console=plain`
  : `BUILD SUCCESSFUL`、789 tasks、plugin全unit testとdebug APK build成功。
- merged manifestに`dataExtractionRules`/`fullBackupContent`、packaged resourcesにcloud/device transferを含む
  `blt_prefs.xml`除外が残ることを確認。
- KGP/AGPのdeprecation warningと外部plugin warningは出るが、今回変更のfailureはない。

### iOS

- `mise exec -- xcodebuild test -project Runner.xcodeproj -scheme WidgetModelsTests -destination 'platform=macOS' -quiet`
  : exit 0。native pending、lease期限切れ回復、owner release、atomic replace/rollback属性を含む全test成功。
- `mise exec -- flutter build ios --simulator --debug --no-codesign`
  : `Built build/ios/iphonesimulator/Runner.app`。
- Xcode 27 betaのlaunch session warningは出るが、test/buildは成功。

### repository

- `git diff --check`: 成功。
- worktree: clean。
- branch: `codex/headless-device-location-sync`。

## 未解決事項

自動検証上の未解決事項はない。ただし、OSがprocessを終了した後のSignificant Location Change / WorkManager
起動と実運用network条件はSimulator/unit testだけでは証明できないため、既存計画どおり実機E2Eの保証境界として残る。
この最終修正波ではpushしていない。

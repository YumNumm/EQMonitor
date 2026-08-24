# Device Location同期のscope・競合・backup境界

通常Flutter Engineとheadless Flutter Engineは同じpendingを処理し得るため、API送信と
last-success更新をprocess内lockだけで保護してはいけない。以下を一組の契約として維持する。

## last-successのscope

送信済み地域の重複排除は、地域コードだけでなく次のscopeへ紐付ける。

- Device Location APIのendpoint
- device registrationのgeneration

token変更前に非機密なUUID generationを更新する。tokenそのもの、Authorization header、tokenの
hashはSharedPreferencesへ保存しない。backend URL切替や404後の再登録では、同一地域でも新scopeへ
必ず1回送信する。

## 複数Engine間のlease

nativeの永続ストアでupdate ID付きleaseをatomicに取得する。送信完了後は、次の両方を確認できた
場合だけlast-successを更新する。

1. lease IDとupdate IDの所有権が期限内である。
2. native pendingの`deviceLocation`最新版が同じupdate IDである。

送信中に新しいpendingへ置き換わった古い応答は成功値へcommitしない。crash時はleaseを即時削除
できないため、期限切れ後に別Engineが回復取得できるようにする。通常終了ではownerだけがrelease
する。競合で取得できないheadless taskはpendingをacknowledgeせずretryする。

## OS監視のreconcile

現在地notification slotと揺れ検知現在地entryを監視consumerとする。起動時、および両設定の作成・
削除・一括置換後に必ず両方を読み、どちらかが存在すればstart、両方が既知で存在しなければstopする。
片方の取得に失敗して不明な場合は、誤停止を避けて現在のOS監視状態を維持する。

## raw pendingのbackup除外

raw座標を含むpendingは再配布可能な設定ではない。

- Android: `blt_prefs.xml`を`fullBackupContent`と`dataExtractionRules`のcloud backup・device transfer
  のすべてから除外する。
- iOS: pendingファイルと親directoryへ`isExcludedFromBackup`を設定する。`Data.write(.atomic)`は
  inodeを置換するため、初回作成だけでなくreplace後とrollback復元後にも属性を再設定する。
- iOSの`completeFileProtectionUntilFirstUserAuthentication`も同じ3経路で維持する。

## 回帰確認

```bash
cd app
mise exec -- flutter test \
  test/feature/location/device_location_sync_service_test.dart \
  test/feature/location/background_location_update_notifier_test.dart \
  test/feature/location/background_location_backup_policy_test.dart

cd android
mise exec -- ./gradlew :background_location_tracker:testDebugUnitTest --console=plain

cd ../ios
mise exec -- xcodebuild test -project Runner.xcodeproj \
  -scheme WidgetModelsTests -destination 'platform=macOS' \
  -only-testing:WidgetModelsTests/BackgroundLocationPendingLocationStoreTests
```

Pigeon生成がworkspaceのanalyzer overrideと衝突する場合は、
`20260823_pigeon_analyzer_isolation.md`の分離実行手順を使う。

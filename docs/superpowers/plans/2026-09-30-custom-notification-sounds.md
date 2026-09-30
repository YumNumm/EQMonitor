# ファイルから追加する通知音の実装計画

> **実行する agent 向け:** `superpowers:executing-plans` を使い、チェックボックス単位で進める。ユーザーが並列 agent による実装を選んだ場合は `superpowers:subagent-driven-development` を使う。

**Goal:** Files から選んだ音声を通知用の形式でアプリ領域へ保存し、既存の通知音設定から選択できるようにする。

**Architecture:** Swift で音声の検証・変換・永続化・試聴を実装する。Flutter は DataSource / Repository を通じて一覧と操作を扱い、通知設定は既存 API の文字列フィールドを使う。OS が保存済み音を再生する。

**Tech Stack:** Flutter、生成 Riverpod provider、Riverpod 3 Mutation、Freezed、file_picker 13.1.0、Swift、AVFoundation / AVFAudio、App Group、APNs。

**Spec:** [通知音の設計案](../specs/2026-09-30-custom-notification-sounds-design.md)。初回 iOS 対応、最長29.9秒、長い音の先頭切り出しを採用する。実装は追加済みで、Apple SDK build・実機受け入れは未完了。

## 共通条件

- 実装用 worktree も `origin/develop` を基準にする。計画用は `.worktrees/custom-notification-sounds-plan`、branch は `docs/custom-notification-sounds-plan`。
- 初回対象は EEW 予報・地震情報の既定音と震度別 override。既存 Pro 条件を使う。
- 出力は WAV / Linear PCM / signed 16-bit little-endian / 44,100 Hz / mono / 最長29.9秒。
- 保存先は `group.net.yumnumm.eqmonitor` の `Library/Sounds/eqm_custom_<32桁UUID>.wav`。
- 音声は端末内で処理し、サーバーへはファイル名だけを送る。
- Widget / Notifier で SDK やファイルへ直接アクセスしない。Action のコンストラクタへ `ref` / `context` を渡さない。
- Flutter / Dart コマンドは `mise exec --`。生成 Dart を手編集しない。
- 関連する既存テスト、静的解析、native build、実機通知で検証する。

## 特に確認する条件

- Files のクラウド保存音声が取得できない、または選択をキャンセルした場合に設定が変わらないこと。Task 3・4で確認。
- 29.9秒・30秒の入力と変換後の端数で、30秒以上の出力を作らないこと。Task 2で確認。
- 変換途中の終了、容量不足、カタログ書き込み失敗で正常な音が残ること。Task 2・5で確認。
- 使用中の音・snapshot 内の音・API 読込失敗時にファイルを消さないこと。Task 5で確認。
- アプリ終了・画面ロック・再起動後の通知と passive の無音。Task 6で確認。

## Task 1: ファイル名を使う実通知経路の確認

**参照:** backend の `api/api/src/features/device/model/requests.ts`、`service/notification-resolver/src/handlers/{eew,earthquake}/`、`packages/notification-message/src/platform/apns.ts`、`service/notification-sender/internal/sender/apns.go`。backend の指示を読んでから作業する。

- [x] API の `default_sound` と override `sound` が `eqm_custom_<32桁UUID>.wav` を保持し、resolver と sender が同じ名前を APNs まで渡すことを確認する。
- [ ] App Group の `Library/Sounds/` に既知の仕様の WAV を保存し、テスト用端末への APNs alert で、バックグラウンド・アプリ終了・ロック中の再生を確認する。開発環境と対象端末だけで行う。
- [ ] passive で sound が省略されること、critical の扱いと権限を確認する。EEW 警報の固定音や Live Activity の音へ影響しないことを確認する。
- [x] 既存経路だけで成立するなら backend の schema・DB・Notification Service Extension を変更しない。音名が途中で変わる場合は、その箇所だけを追加の backend task として記載してから進める。

**成果物:** 音名・保存場所と実際の再生がつながる根拠。試聴成功や APNs HTTP 200 だけでは完了としない。

## Task 2: native の変換・保存・試聴

**新規:** `app/ios/Runner/NotificationSoundMethodChannel.swift`、`NotificationSoundImporter.swift`、`NotificationSoundStore.swift`、`NotificationSoundPreviewPlayer.swift`。

**変更:** `app/ios/Runner/AppDelegate.swift`、`app/ios/Runner.xcodeproj/project.pbxproj` の Runner source 所属。

**境界:** MethodChannel `net.yumnumm.eqmonitor/notification_sounds`。`inspect`、`prepare`、`commit`、`discard`、`list`、`rename`、`delete`、`preview`、`stopPreview` を提供する。データは Task 3 の型に対応する JSON 文字列で返し、Dart の DataSource で型へ変換する。

- [x] `inspect(sourcePath:)` で音声の実デコード可否と duration を取得する。native エラーコードは `unsupportedFormat`、`invalidAudio`、`sourceUnavailable`、`storageFailure`、`busy` に揃える。
- [x] `prepare(sourcePath:trimToMaxDuration:)` で最終仕様の一時 WAV を作る。AVAudioFile と AVAudioConverter を使い、全入力を一括で保持しない。同じ仕様の入力もデコードして出力を検証する。
- [x] `commit(preparedId:displayName:)` で生成名へ保存し、カタログを atomic replace する。`preparedId` から path を native で解決し、任意の出力 path を Dart から指定させない。
- [x] `discard` と中断後の cleanup、list / rename / delete を実装する。file protection を設定し、表示名変更でファイル名が変わらないようにする。
- [x] 一時 WAV と保存済み WAV を同じ player で試聴する。次の試聴・画面離脱・アプリのバックグラウンド遷移では停止し、audio session を解放する。
- [ ] MP3 / AAC-M4A / WAV / AIFF / CAF、mono / stereo、異なる sample rate、29.9秒 / 30秒 / 長い音、破損・DRM・容量不足を native build と実機で確認する。未検証形式は対応済みと記載しない。

**成果物:** 取り込んだ最終音声と、再起動しても読めるカタログ。カタログ保存失敗時は追加成功を返さない。

## Task 3: Flutter の追加音モデルと Repository

**新規（以下は `app/lib/feature/settings/features/notification_settings/` 配下）:**

- `data/model/custom_notification_sound.dart`: `CustomNotificationSound(id, displayName, fileName, durationMs, createdAt)`、`NotificationSoundInspection(sourceDisplayName, durationMs)`、`PreparedNotificationSound(id, durationMs)`。ID・名前は `String`、長さは `int`、日時は `DateTime` とする。
- `data/model/notification_sound_selection.dart`: `NotificationSoundSelection.builtin(NotificationSound)`、`.custom(CustomNotificationSound)`、`.unavailable(String apiValue)`。
- `data/model/notification_sound_failure.dart`: native エラーに対応する failure enum と domain exception。
- `data/data_source/notification_sound_data_source.dart`: file_picker と MethodChannel の入出力を型へ変換する。
- `data/repository/notification_sound_repository.dart`: 取り込みとカタログ操作を公開する。
- `data/notifier/custom_notification_sounds_notifier.dart`: 一覧と操作の Mutation を持つ。
- `data/provider/notification_sound_options.dart`: 標準音と追加音の選択肢だけを返す。

**Interfaces:** `Future<NotificationSoundInspection?> pickAndInspect()`、`Future<PreparedNotificationSound> prepare({required bool trimToMaxDuration})`、`Future<CustomNotificationSound> commit({required String preparedId, required String displayName})`、`Future<void> discard({required String preparedId})`、`Future<List<CustomNotificationSound>> list()`、`rename({required String id, required String displayName})`、`delete({required String id})`、`previewPrepared({required String preparedId})`、`previewSaved({required String id})`、`stopPreview()`。最後の5操作も `Future<void>` とする。

- [x] `FilePicker.pickFile(type: FileType.audio)` を使う。13.1.0 の static API に合わせ、旧版の `FilePicker.platform` や `withData` 引数を持ち込まない。選択 source は Repository の一時状態だけに保持する。
- [x] 通知音名の解決は既存 enum の値、追加カタログの fileName、未登録名の順で行う。選択型に `String apiValue` と `String displayName` の getter を定義する。未知の文字列を保持する `unavailable` を使い、画面表示だけで API 設定を書き換えない。
- [x] 追加・rename・delete・preview に Mutation を使う。一時音声の cancel / error / dispose cleanup を Repository と Action へ分ける。import は同時に1件にする。
- [x] Freezed / Riverpod を app で再生成し、対象 Dart の format と解析を行う。

**成果物:** UI が SDK や path を扱わず、標準音・追加音・欠損音を区別できる状態。

## Task 4: 既存の選択欄と追加・管理画面

**変更:** `ui/page/sound_interruption_settings_page.dart`、`ui/page/override_edit_page.dart`。

**新規:** `ui/component/notification_sound_selector.dart`、`ui/page/custom_notification_sound_import_page.dart`、`ui/page/custom_notification_sounds_page.dart`、`ui/action/custom_notification_sound_action.dart`。

- [x] 両既存画面の選択欄を共通化し、標準4種類と追加音を表示する。欠損名は「ファイルが見つかりません」と表示し、別音の選択を可能にする。
- [x] 「ファイルから追加」と「追加した通知音を管理」を追加し、選択・確認・prepare・試聴・commit の順でつなぐ。長い音の切り出しは設計案の文言で確認する。
- [x] 追加はカタログへの保存だけとし、設定の自動変更を行わない。選択時は既存 Notifier へ fileName を渡す。API 失敗時は以前の選択値を維持する。
- [x] 変換中・保存中の重複操作、キャンセル、画面離脱、クラウド source の読取失敗を扱う。追加音の displayName 変更は一覧へ反映する。
- [ ] Light / Dark、大きい文字、長い日本語ファイル名、VoiceOver、Pro 未加入・失効を実機で確認する。

**成果物:** 添付画面の既存操作に、追加・試聴・管理がつながる。

## Task 5: 削除・snapshot・欠損からの復旧

**新規:** `data/repository/notification_sound_usage_repository.dart`。

**参照・必要な箇所のみ変更:** `data/repository/notification_custom_snapshot_repository.dart`、`data/action/notification_preset_applier.dart`、`data/notifier/custom_notification_sounds_notifier.dart`。

**Interfaces:** `Future<bool> isInUse({required String fileName})`。EEW / 地震の既定設定、全 slot override、保存 snapshot を既存 Repository から読み取る。途中の通信失敗は例外とし、false で隠さない。

- [x] 使用中・設定の取得失敗・音選択の保存中は削除を止める。使用中の案内は設計案の文言を使う。削除確認から実行まで、アプリ内の選択保存との競合を直列化する。
- [x] カタログの atomic な更新とファイル削除の途中で終了した場合、次回読込で cleanup する。カタログを正常に読み取れた場合だけカタログ外のファイルを回収する。生成名 namespace 外の音声や他機能のファイルを削除しない。
- [x] カスタムプリセットの保存・復元で任意の fileName をそのまま保持する。ファイル欠損でも API 値を勝手にデフォルトへ更新しない。
- [ ] 元ファイル削除、アプリ再起動、API 保存失敗、snapshot 内だけの参照、欠損ファイル、壊れたカタログを確認する。カタログ破損時は保存済み音声を維持してエラーを表示する。

**成果物:** 使用中の音を失わず、失敗後に再試行できる管理操作。

## Task 6: 既存検証と実通知での受け入れ

- [x] 実装 worktree で pinned Flutter/Dart を使い、`git submodule update --init third_party/flutter_scene` → `mise exec -- dart pub get --enforce-lockfile` → `mise exec -- dart run melos bootstrap`、`mise exec -- tool/asset_pack/stage_from_r2.sh --target bundled` を実行した。任意の codemagic tool が未取得のため `MISE_AUTO_INSTALL=0` を付け、27 package の bootstrap と Asset Pack 検証が成功した。
- [x] app で `mise exec -- dart run build_runner build --delete-conflicting-outputs`、root で変更した Dart に `mise exec -- dart format <paths>` と `mise exec -- dart analyze app --fatal-infos --format machine`。既存失敗があれば差分起因かを分けて記録する。
- [x] app で `mise exec -- flutter test test/feature/settings/features/notification_settings --dart-define=CI=true` を実行した。91件成功・3件失敗。3件は基準 commit `4e853b5b1` の別 worktree でも再現した既存文言不一致で、通知音変更による失敗はない。失敗名は `slot_detail_page_test.dart` の現在地・全国警報の2件と、`notification_preset_selector_test.dart` の権限ダイアログの1件。
- [ ] macOS で SPM を有効にし、Runner と FcmServiceExtension を含む Simulator build と署名済み実機 build を行う。共有 source の所属、生成 Flutter 設定、App Group の entitlement を確認する。
- [ ] テスト端末へ実際の EEW 予報・地震情報・override の通知を送り、保存した fileName、最終 APNs payload、端末の再生音を照合する。前面・バックグラウンド・終了・ロック・端末再起動後、passive、critical、続報上書き、欠損時 fallback を確認する。固定の「通常テスト通知」が設定音を使わない場合は、それだけで受け入れ確認を代替しない。
- [x] 実機未確認の条件は `docs/todo/800_ui_and_navigation.md` に残す。文書と差分を確認し、意図した変更を stage して `mise exec -- hk check`、論理単位の commit / push、`YumNumm/EQMonitor` の `develop` 向け PR へ進める。

**完了の判断:** UI の試聴、静的解析、build、APNs の受付成功と、実通知の音再生を区別して報告する。受け入れ結果がそろった条件だけを完了とする。

## 実装後の確認範囲

Dart の静的解析はエラー・警告・info なし。既存テストの3件の失敗は変更前でも再現した。Swift 6.3.3 の `swiftc -frontend -parse` は成功したが、Apple SDK での型確認・Simulator build・実機再生は未実施。ユーザーの指定により今回の作業では追加の実機確認を行わず、PR をレビュー可能な状態へ進める。Task 1・2・4・5・6 の実機条件は未検証として TODO に残す。

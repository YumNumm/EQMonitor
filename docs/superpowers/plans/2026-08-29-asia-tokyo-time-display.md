# Asia/Tokyo Time Display Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Flutter app で絶対時刻を表示する全経路を、端末設定に依存しない `Asia/Tokyo` 表示へ統一する。

**Architecture:** Domain/Data 層の `DateTime` は維持し、表示境界の extension method で `TZDateTime` へ変換する。Primary Constructor を使う `DateTimeFormat` enum が表示パターンとキャッシュ済み `DateFormat` を管理し、通常画面、デバッグ画面、診断情報から同じ API を利用する。

**Tech Stack:** Dart 3.14、Flutter、`intl`、`timezone`、`flutter_test`

**Spec:** `docs/superpowers/specs/2026-08-29-asia-tokyo-time-display-design.md`

## Global Constraints

- 絶対時刻は文字列化の直前に `Asia/Tokyo` の `TZDateTime` へ変換する。
- Domain/Data モデル、比較、API、永続化、生成済みシリアライザーは変更しない。
- 暦日、経過時間、識別子、API パスはタイムゾーン変換しない。
- 「頃」「発表」などの画面固有文言は enum のパターンへ含めない。
- `dynamic`、`Object`、null assertion、`print()`、クラス内 private method を追加しない。
- Flutter/Dart コマンドは `mise exec --` 経由で実行する。
- 全面 TDD は行わず、共通 API と表示文字列ロジックに必要な単体テストを追加する。

---

### Task 1: Tokyo timezone formatting API

**Files:**
- Create: `app/lib/core/util/date_time_format.dart`
- Create: `app/test/core/util/date_time_format_test.dart`

**Interfaces:**
- Consumes: 起動時に実行済みの `core.initializeTimeZones()`
- Produces: `DateTimeFormat`, `DateTimeFormatting.formatWithTz(DateTimeFormat)`, `DateTimeFormatting.tokyoDateTime`

- [ ] **Step 1: 共通 API の単体テストを追加する**

```dart
void main() {
  setUpAll(core.initializeTimeZones);

  test('UTC 15:00 は Tokyo の翌日 00:00 になる', () {
    final value = DateTime.utc(2026, 8, 18, 15);
    expect(
      value.formatWithTz(DateTimeFormat.yearMonthDayHourMinuteSecond),
      '2026/08/19 00:00:00',
    );
  });

  test('別 timezone の TZDateTime も Tokyo 表示になる', () {
    final value = tz.TZDateTime(
      tz.getLocation('America/Los_Angeles'),
      2026,
      8,
      18,
      8,
    );
    expect(value.formatWithTz(DateTimeFormat.hourMinute), '00:00');
  });

  test('Tokyo ISO 8601 は UTC offset を含む', () {
    final value = DateTime.utc(2026, 8, 18, 15).tokyoDateTime;
    expect(value.timeZoneOffset, const Duration(hours: 9));
    expect(value.toIso8601String(), contains('2026-08-19T00:00:00'));
  });
}
```

- [ ] **Step 2: テストが共通 API 未定義で失敗することを確認する**

Run: `mise exec -- flutter test app/test/core/util/date_time_format_test.dart`

Expected: `DateTimeFormat` と `formatWithTz` が未定義のため FAIL

- [ ] **Step 3: Primary Constructor を使う enum と extension を実装する**

```dart
enum DateTimeFormat(final String pattern) {
  yearMonthDay('yyyy/MM/dd'),
  yearMonthDayJapanese('yyyy年MM月dd日'),
  monthDay('MM/dd'),
  hourMinute('HH:mm'),
  hourMinuteSecond('HH:mm:ss'),
  monthDayHourMinute('MM/dd HH:mm'),
  monthDayHourMinuteSecond('MM/dd HH:mm:ss'),
  yearMonthDayHourMinute('yyyy/MM/dd HH:mm'),
  yearMonthDayHourMinuteJapanese('yyyy年MM月dd日 HH:mm'),
  yearMonthDayHourMinuteSecond('yyyy/MM/dd HH:mm:ss'),
  yearMonthDayHourMinuteSecondHyphen('yyyy-MM-dd HH:mm:ss'),
  yearMonthDayHourMinuteSecondMillisecond('yyyy/MM/dd HH:mm:ss.SSS'),
  ;

  static final _formatters = values
      .map((value) => DateFormat(value.pattern))
      .toList(growable: false);

  DateFormat get formatter => _formatters[index];
}

extension DateTimeFormatting on DateTime {
  static final _tokyo = tz.getLocation('Asia/Tokyo');

  tz.TZDateTime get tokyoDateTime => tz.TZDateTime.from(this, _tokyo);

  String formatWithTz(DateTimeFormat format) =>
      format.formatter.format(tokyoDateTime);
}
```

- [ ] **Step 4: 共通 API テストを通す**

Run: `mise exec -- flutter test app/test/core/util/date_time_format_test.dart`

Expected: PASS

- [ ] **Step 5: 共通 API をコミット・pushする**

```bash
git add app/lib/core/util/date_time_format.dart app/test/core/util/date_time_format_test.dart
git commit -m "feat: Tokyo時刻フォーマッターを追加する"
git push
```

---

### Task 2: Earthquake history displays

**Files:**
- Modify: `app/lib/feature/earthquake_history/data/notifier/earthquake_history_data_source.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_list_tile.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_summary_header.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/shindo_db_hypocenter_information_card.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/shindo_db_station_detail_sheet.dart`
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_activity_page.dart`
- Modify: `app/lib/feature/intensity_history/ui/components/city_detail_modal.dart`

**Interfaces:**
- Consumes: Task 1 の `formatWithTz` と `DateTimeFormat`
- Produces: 地震履歴、活動度、観測点詳細の Tokyo 時刻表示

- [ ] **Step 1: DateFormat と toLocal を共通 API へ置換する**

```dart
final text = originTime.formatWithTz(
  DateTimeFormat.yearMonthDayHourMinute,
);
final millisecondText = originTime.formatWithTz(
  DateTimeFormat.yearMonthDayHourMinuteSecondMillisecond,
);
```

表示文言の `頃発生`、`頃検知`、`発生時刻:`、`最大加速度時刻:` は既存位置で付加する。

- [ ] **Step 2: 対象ファイルから表示用 DateFormat/toLocal が消えたことを確認する**

Run: `rg -n 'DateFormat|toLocal\(' app/lib/feature/earthquake_history app/lib/feature/intensity_history/ui/components/city_detail_modal.dart`

Expected: API リクエストや比較以外の表示用一致なし

- [ ] **Step 3: format と analyze を実行する**

Run: `mise exec -- dart format app/lib/feature/earthquake_history app/lib/feature/intensity_history/ui/components/city_detail_modal.dart`

Run: `mise exec -- dart analyze app/lib/feature/earthquake_history app/lib/feature/intensity_history/ui/components/city_detail_modal.dart --fatal-infos`

Expected: 両方成功

- [ ] **Step 4: コミット・pushする**

```bash
git add app/lib/feature/earthquake_history app/lib/feature/intensity_history/ui/components/city_detail_modal.dart
git commit -m "fix: 地震履歴をTokyo時刻表示に統一する"
git push
```

---

### Task 3: EEW, telegram, home, and live monitor displays

**Files:**
- Modify: `app/lib/feature/eew/ui/components/eew_table.dart`
- Modify: `app/lib/feature/eew/ui/page/eew_details_page.dart`
- Modify: `app/lib/feature/eew_history/data/notifier/eew_list_data_source.dart`
- Modify: `app/lib/feature/eew_history/ui/components/eew_history_list_tile.dart`
- Modify: `app/lib/feature/telegram_list/ui/components/earthquake_telegram_tile.dart`
- Modify: `app/lib/feature/telegram_list/ui/components/hypocenter_summary.dart`
- Modify: `app/lib/feature/telegram_list/ui/components/telegram_list_tile.dart`
- Modify: `app/lib/feature/home/ui/component/eew/eew_card.dart`
- Modify: `app/lib/feature/home/ui/component/shake_detection/shake_detection_card.dart`
- Modify: `app/lib/feature/live_monitor/data/logic/live_monitor_publication_time_formatter.dart`
- Test: `app/test/feature/live_monitor/data/logic/live_monitor_publication_time_formatter_test.dart`

**Interfaces:**
- Consumes: Task 1 の共通 API
- Produces: EEW、電文、ホーム、ライブモニターの Tokyo 時刻表示

- [ ] **Step 1: 既存 formatter test を UTC 日付境界の期待値へ更新する**

```dart
expect(
  formatter.format(
    reportedAt: DateTime.utc(2026, 8, 18, 15),
    now: DateTime.utc(2026, 8, 18, 15, 1),
  ),
  '2026/08/19 00:00 (01:00前)',
);
```

- [ ] **Step 2: 表示コードを formatWithTz へ移行する**

`DateFormat` import と `.toLocal()` を削除し、既存の各パターンに対応する enum 値を使う。
`eew_card.dart` の日付と時刻は同じ元 `DateTime` に対して `monthDay` と
`hourMinuteSecond` を個別に適用する。

- [ ] **Step 3: 関連テストと analyze を実行する**

Run: `mise exec -- flutter test app/test/feature/live_monitor/data/logic/live_monitor_publication_time_formatter_test.dart`

Run: `mise exec -- dart analyze app/lib/feature/eew app/lib/feature/eew_history app/lib/feature/telegram_list app/lib/feature/home/ui/component app/lib/feature/live_monitor --fatal-infos`

Expected: PASS、analyze 成功

- [ ] **Step 4: コミット・pushする**

```bash
git add app/lib/feature/eew app/lib/feature/eew_history app/lib/feature/telegram_list app/lib/feature/home/ui/component app/lib/feature/live_monitor app/test/feature/live_monitor
git commit -m "fix: EEWと電文をTokyo時刻表示に統一する"
git push
```

---

### Task 4: Tsunami, Kyoshin monitor, and seismicity displays

**Files:**
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_earthquake_card.dart`
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_observation_station_tile.dart`
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_region_list.dart`
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_timeline_overlay.dart`
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_warning_history_overlay.dart`
- Modify: `app/lib/feature/tsunami/ui/components/tsunami_warning_status_card.dart`
- Modify: `app/lib/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart`
- Modify: `app/lib/feature/seismicity/ui/seismicity_page.dart`

**Interfaces:**
- Consumes: Task 1 の共通 API
- Produces: 津波、強震モニタ、震源分布の Tokyo 時刻表示

- [ ] **Step 1: 津波表示を formatWithTz へ移行する**

```dart
final arrivalText = arrivalTime.formatWithTz(DateTimeFormat.hourMinute);
final updateText = updatedAt.formatWithTz(
  DateTimeFormat.yearMonthDayHourMinute,
);
```

タイムラインの範囲計算は瞬間の比較を維持し、目盛りラベルの文字列化だけを Tokyo にする。

- [ ] **Step 2: 強震モニタと震源分布表示を移行する**

`latestTime` と `generatedAt` を直接 `formatWithTz` へ渡す。画像 URL の時刻計算や
Kyoshin Monitor API の JST 変換には触れない。

- [ ] **Step 3: format と analyze を実行する**

Run: `mise exec -- dart format app/lib/feature/tsunami app/lib/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart app/lib/feature/seismicity/ui/seismicity_page.dart`

Run: `mise exec -- dart analyze app/lib/feature/tsunami app/lib/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart app/lib/feature/seismicity/ui/seismicity_page.dart --fatal-infos`

Expected: 成功

- [ ] **Step 4: コミット・pushする**

```bash
git add app/lib/feature/tsunami app/lib/feature/kyoshin_monitor/page/components/kyoshin_monitor_status_card.dart app/lib/feature/seismicity/ui/seismicity_page.dart
git commit -m "fix: 津波と観測情報をTokyo時刻表示に統一する"
git push
```

---

### Task 5: Catalog, waveform, feed, notification, and app information displays

**Files:**
- Modify: `app/lib/feature/nied/ui/aqua/aqua_catalog_page.dart`
- Modify: `app/lib/feature/nied/ui/fnet/fnet_catalog_page.dart`
- Modify: `app/lib/feature/fnet_catalog/ui/components/fnet_catalog_list_tile.dart`
- Modify: `app/lib/feature/knet_waveform/ui/knet_waveform_page.dart`
- Modify: `app/lib/feature/knet_waveform/ui/media/knet_media_page.dart`
- Modify: `app/lib/feature/knet_waveform/ui/record/knet_record_list_page.dart`
- Modify: `app/lib/feature/feed/ui/component/feed_item_card.dart`
- Modify: `app/lib/feature/feed/ui/component/feed_item_list_tile.dart`
- Modify: `app/lib/feature/feed/ui/page/feed_details_page.dart`
- Modify: `app/lib/feature/notification/data/logic/notification_delivery_log_detail_builder.dart`
- Modify: `app/lib/feature/qzss_dcr/ui/qzss_dcr_report_widget.dart`
- Modify: `app/lib/feature/changelog/ui/page/changelog_page.dart`
- Modify: `app/lib/feature/subscription/ui/page/subscription_settings_page.dart`
- Modify: `app/lib/feature/settings/children/application_info/about_this_app_page.dart`
- Modify: `app/lib/feature/settings/children/application_info/license_page.dart`

**Interfaces:**
- Consumes: Task 1 の共通 API
- Produces: カタログ、波形、フィード、通知、アプリ情報の Tokyo 時刻表示

- [ ] **Step 1: カタログと波形の DateFormat を共通 API へ移行する**

NIED の既存 `tz.getLocation('Asia/Tokyo')` と `TZDateTime.from` は削除し、同じ
`DateTime` に `formatWithTz(DateTimeFormat.yearMonthDayHourMinuteSecondHyphen)` を使う。
F-net 詳細の Tokyo へ変換した時刻に付いている誤った `(UTC)` 表記は `(JST)` へ直す。

- [ ] **Step 2: フィード、通知、QZSS、更新履歴を移行する**

各既存パターンへ対応する enum 値を使い、`頃発表` は整形後の文字列へ付加する。

- [ ] **Step 3: 現在年と購読期限日を Tokyo 基準へする**

```dart
final currentYear = DateTime.now().tokyoDateTime.year;
final expirationDate = expiresAt.formatWithTz(DateTimeFormat.yearMonthDay);
```

- [ ] **Step 4: format と analyze を実行する**

Run: `mise exec -- dart format app/lib/feature/nied app/lib/feature/fnet_catalog app/lib/feature/knet_waveform app/lib/feature/feed app/lib/feature/notification/data/logic app/lib/feature/qzss_dcr app/lib/feature/changelog app/lib/feature/subscription app/lib/feature/settings/children/application_info`

Run: `mise exec -- dart analyze app/lib/feature/nied app/lib/feature/fnet_catalog app/lib/feature/knet_waveform app/lib/feature/feed app/lib/feature/notification/data/logic app/lib/feature/qzss_dcr app/lib/feature/changelog app/lib/feature/subscription app/lib/feature/settings/children/application_info --fatal-infos`

Expected: 成功

- [ ] **Step 5: コミット・pushする**

```bash
git add app/lib/feature/nied app/lib/feature/fnet_catalog app/lib/feature/knet_waveform app/lib/feature/feed app/lib/feature/notification/data/logic app/lib/feature/qzss_dcr app/lib/feature/changelog app/lib/feature/subscription app/lib/feature/settings/children/application_info
git commit -m "fix: カタログとアプリ情報をTokyo時刻表示に統一する"
git push
```

---

### Task 6: Debug and diagnostic displays

**Files:**
- Modify: `app/lib/core/component/error/error_diagnostics.dart`
- Modify: `app/lib/feature/settings/children/config/debug/kyoshin_monitor/debug_kyoshin_monitor.dart`
- Modify: `app/lib/feature/settings/children/config/debug/telemetry/debug_telemetry_page.dart`
- Modify: `app/lib/feature/settings/children/config/debug/websocket/debug_websocket_page.dart`
- Modify: `app/lib/feature/settings/children/config/debug/tsunami/data/tsunami_history_data_source.dart`
- Modify: `app/lib/feature/settings/children/config/debug/tsunami/debug_tsunami_details_page.dart`
- Modify: `app/lib/feature/settings/children/config/debug/tsunami/tsunami_telegram_timeline_debug_page.dart`
- Modify: `app/lib/feature/settings/children/config/debug/shake_detection/debug_shake_detection_card_page.dart`
- Modify: `app/lib/feature/settings/children/config/debug/eew/debug_eew_card_page.dart`
- Modify: `app/lib/feature/settings/children/config/debug/http_cache/debug_http_cache_page.dart`
- Modify: `app/lib/feature/settings/children/config/debug/live_activity/data/repository/debug_live_activity_content_builder.dart`
- Modify: `app/lib/feature/devices/ui/page/debug_device_settings_page.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/modal/earthquake_vxse_debug_editor.dart`
- Test: `app/test/core/component/error/error_diagnostics_test.dart`

**Interfaces:**
- Consumes: `formatWithTz` と `tokyoDateTime`
- Produces: Tokyo 表示の診断時刻、デバッグ時刻、編集可能な ISO 8601 値

- [ ] **Step 1: 診断文字列テストを Tokyo ISO 8601 期待値へ更新する**

```dart
expect(
  diagnostics,
  contains('発生時刻: 2026-08-19T00:00:00'),
);
```

- [ ] **Step 2: ISO 8601 の表示値を tokyoDateTime 経由へ変更する**

```dart
value: reportedAt.tokyoDateTime.toIso8601String(),
```

生成済み `.g.dart` と reducer の識別子用 ISO 文字列は変更しない。

- [ ] **Step 3: 手組み日時と toString 表示を formatWithTz へ変更する**

Telemetry と WebSocket のミリ秒表示は、共通 enum の秒表示へ
`.${millisecond.toString().padLeft(3, '0')}` を付加する。端末 local の `.toString()` は
Tokyo の ISO 8601 または既存粒度に対応する enum へ置換する。

- [ ] **Step 4: 関連テストと analyze を実行する**

Run: `mise exec -- flutter test app/test/core/component/error/error_diagnostics_test.dart app/test/core/util/date_time_format_test.dart`

Run: `mise exec -- dart analyze app/lib/core/component/error app/lib/feature/settings/children/config/debug app/lib/feature/devices/ui/page/debug_device_settings_page.dart app/lib/feature/earthquake_history/ui/components/modal/earthquake_vxse_debug_editor.dart --fatal-infos`

Expected: PASS、analyze 成功

- [ ] **Step 5: コミット・pushする**

```bash
git add app/lib/core/component/error app/lib/feature/settings/children/config/debug app/lib/feature/devices/ui/page/debug_device_settings_page.dart app/lib/feature/earthquake_history/ui/components/modal/earthquake_vxse_debug_editor.dart app/test/core/component/error app/test/core/util/date_time_format_test.dart
git commit -m "fix: デバッグと診断時刻をTokyo表示に統一する"
git push
```

---

### Task 7: Repository-wide audit and verification

**Files:**
- No planned repository file changes; a display leak returns to the owning task before verification continues

**Interfaces:**
- Consumes: 全移行済み表示コード
- Produces: 表示用の端末 local 依存と直接 `DateFormat` のない Flutter app

- [ ] **Step 1: 表示漏れを機械検索する**

Run: `rg -n --glob '*.dart' 'DateFormat\(|toLocal\(\)|toIso8601String\(\)|\.toString\(\)' app/lib`

Expected: 暦日、比較、API/JSON、生成済みコード、識別子用途だけが残る

- [ ] **Step 2: 残存一致を1件ずつ分類し、表示漏れだけを修正する**

表示用途は `formatWithTz` または `tokyoDateTime.toIso8601String()` へ変更する。
非表示用途は変更せず、最終報告で代表的な除外理由を説明する。

- [ ] **Step 3: 変更ファイルを format する**

Run: `mise exec -- dart format app/lib app/test/core/util/date_time_format_test.dart`

Expected: 成功

- [ ] **Step 4: 対象単体テストを実行する**

Run: `mise exec -- flutter test app/test/core/util/date_time_format_test.dart app/test/core/component/error/error_diagnostics_test.dart app/test/feature/live_monitor/data/logic/live_monitor_publication_time_formatter_test.dart app/test/feature/notification/data/logic/notification_delivery_log_detail_builder_test.dart`

Expected: PASS

- [ ] **Step 5: Flutter app を静的解析する**

Run: `mise exec -- dart analyze app --fatal-infos`

Expected: 既知の基準外失敗がなければ成功。失敗時は今回差分由来か既存かを切り分ける。

- [ ] **Step 6: 最終差分を確認する**

Run: `git --no-pager diff develop...HEAD --check`

Run: `git --no-pager diff develop...HEAD --stat`

Run: `git --no-pager status --short`

Expected: whitespace error なし、意図したファイルのみ、worktree clean

### Task 8: Pull request

**Files:**
- No repository file changes

**Interfaces:**
- Consumes: push 済み `fix/display-times-asia-tokyo`
- Produces: `YumNumm/EQMonitor` の `develop` 向け修正 PR

- [ ] **Step 1: branch と remote を確認する**

Run: `git branch --show-current`

Run: `git remote -v`

Expected: `fix/display-times-asia-tokyo`、送信先が `YumNumm/EQMonitor`

- [ ] **Step 2: PR を作成する**

```bash
gh pr create \
  --repo YumNumm/EQMonitor \
  --base develop \
  --head fix/display-times-asia-tokyo \
  --title "fix: 時刻表示をAsia/Tokyoに統一する" \
  --body-file /tmp/eqmonitor-asia-tokyo-pr-body.md
```

PR 本文には変更概要、追加テスト、静的解析結果、変更前から存在する全体テスト失敗を記載する。

- [ ] **Step 3: PR の送信先・base・head を読み戻す**

Run: `gh pr view --repo YumNumm/EQMonitor --json url,baseRefName,headRefName,title`

Expected: base=`develop`、head=`fix/display-times-asia-tokyo`

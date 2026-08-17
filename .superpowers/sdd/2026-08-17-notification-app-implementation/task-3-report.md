# Task 3 Report: EEW予報しきい値policy・表記・subtitle

## Status

DONE

## Implemented

- Added `EewForecastThresholdPolicy` using the existing `JmaIntensity` and
  `NotificationSlotType` models.
- Limited current-location and region thresholds to `all`, `4`, `5弱`, `5強`,
  `6弱`, `6強`, and `7`; nationwide also includes `1`, `2`, and `3`.
- Added `NotificationSlotFormatter` for the exact Japanese intensity labels,
  slot display names, and threshold subtitles.
- Joined region and city names without whitespace and rejected missing region
  names instead of substituting a generic location.
- Rejected unknown intensity variants and slot-specific invalid thresholds with
  `StateError`. A nullable disabled threshold stays null and is never converted
  to `all`.
- Connected both EEW forecast screens to the shared policy and formatter.
  `SlotDetailPage` keeps the earthquake-information threshold title and choices
  unchanged.

## TDD Evidence

### RED: policy and formatter did not exist

Command from `app`:

```text
mise exec -- flutter test test/feature/settings/features/notification_settings/eew_forecast_threshold_policy_test.dart test/feature/settings/features/notification_settings/notification_slot_formatter_test.dart
```

Result: exit 1. Both test files failed to load because
`eew_forecast_threshold_policy.dart` and `notification_slot_formatter.dart`
did not exist, with the expected undefined-class diagnostics.

### GREEN: pure policy and formatter

The same command passed after the minimal implementation: exit 0, 14/14 tests
passed.

### RED: screens were not connected

Command from `app`:

```text
mise exec -- flutter test test/feature/settings/features/notification_settings/eew_forecast_settings_page_test.dart test/feature/settings/features/notification_settings/slot_detail_page_test.dart
```

Result: exit 1. Both tests rendered the real pages and failed because
`通知する予想震度のしきい値` was absent, proving the new presentation had not
yet been connected.

### GREEN: policy, formatter, and both screens

Command from `app`:

```text
mise exec -- flutter test test/feature/settings/features/notification_settings/eew_forecast_threshold_policy_test.dart test/feature/settings/features/notification_settings/notification_slot_formatter_test.dart test/feature/settings/features/notification_settings/eew_forecast_settings_page_test.dart test/feature/settings/features/notification_settings/slot_detail_page_test.dart
```

Result after formatting: exit 0, 16/16 tests passed.

## Verification

- `mise exec -- dart format` on the eight Task 3 Dart files: exit 0.
- `mise exec -- dart analyze` on the four Task 3 production files: exit 0,
  `No issues found!`.
- `git diff --check`: exit 0.
- Null-assertion audit on all eight Task 3 Dart files found no `!` operators.
- Existing user changes in root/package analysis options and `mise.lock` were
  left untouched and will not be staged.

## Files Changed

```text
app/lib/feature/settings/features/notification_settings/data/model/eew_forecast_threshold_policy.dart
app/lib/feature/settings/features/notification_settings/ui/formatter/notification_slot_formatter.dart
app/lib/feature/settings/features/notification_settings/ui/page/eew_forecast_settings_page.dart
app/lib/feature/settings/features/notification_settings/ui/page/slot_detail_page.dart
app/test/feature/settings/features/notification_settings/eew_forecast_threshold_policy_test.dart
app/test/feature/settings/features/notification_settings/notification_slot_formatter_test.dart
app/test/feature/settings/features/notification_settings/eew_forecast_settings_page_test.dart
app/test/feature/settings/features/notification_settings/slot_detail_page_test.dart
```

## Self-review and Concerns

- The widgets enumerate only values supplied by the policy and use the formatter
  for every EEW threshold label.
- Nullable thresholds remain unselected rather than receiving a fabricated
  threshold; non-null invalid values fail immediately.
- No Task 4 or later platform visibility/channel code was changed.
- No remaining correctness concern.

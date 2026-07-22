# Default Map Labels Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Disable home-map region and city labels for users without a saved preference.

**Architecture:** The immutable `HomeMapLabelParameter` model is the single source of default values. Its existing notifier returns this model only when the shared-preferences value is absent or invalid, so changing the model defaults preserves all stored user preferences.

**Tech Stack:** Flutter, Dart, Freezed, json_serializable, flutter_test.

## Global Constraints

- Set both `showRegionLabel` and `showCityLabel` defaults to `false`.
- Do not alter the shared-preferences key, deserialization behavior, or saved preferences.
- Regenerate checked-in Freezed and JSON files with `mise exec -- dart run build_runner build --delete-conflicting-outputs`.
- Run Flutter/Dart commands through `mise exec --`.

---

### Task 1: Disable the default home-map labels

**Files:**
- Modify: `app/lib/feature/home/data/model/home_map_label_parameter.dart:8-16`
- Modify: `app/lib/feature/home/data/model/home_map_label_parameter.freezed.dart` (generated)
- Modify: `app/lib/feature/home/data/model/home_map_label_parameter.g.dart` (generated if changed)
- Create: `app/test/feature/home/data/model/home_map_label_parameter_test.dart`

**Interfaces:**
- Consumes: `const HomeMapLabelParameter()`.
- Produces: defaults where `showRegionLabel == false` and `showCityLabel == false`.

- [ ] **Step 1: Write the failing test**

```dart
import 'package:eqmonitor/feature/home/data/model/home_map_label_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('disables both home map labels by default', () {
    const parameter = HomeMapLabelParameter();

    expect(parameter.showRegionLabel, isFalse);
    expect(parameter.showCityLabel, isFalse);
    expect(parameter.regionLabelMinZoom, 5.0);
    expect(parameter.cityLabelMinZoom, 9.0);
  });
}
```

- [ ] **Step 2: Run the focused test and verify it fails**

Run: `mise exec -- flutter test test/feature/home/data/model/home_map_label_parameter_test.dart`

Expected: FAIL because the current defaults are `true`.

- [ ] **Step 3: Implement the minimal default change and regenerate code**

```dart
const factory HomeMapLabelParameter({
  @Default(false) bool showRegionLabel,
  @Default(false) bool showCityLabel,
  // Existing numeric defaults unchanged.
}) = _HomeMapLabelParameter;
```

Run: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 4: Run focused validation**

Run:

```bash
mise exec -- flutter test test/feature/home/data/model/home_map_label_parameter_test.dart
mise exec -- dart analyze lib/feature/home/data/model/home_map_label_parameter.dart test/feature/home/data/model/home_map_label_parameter_test.dart
```

Expected: both commands exit with status 0.

- [ ] **Step 5: Commit the implementation**

```bash
git add app/lib/feature/home/data/model/home_map_label_parameter.dart \
  app/lib/feature/home/data/model/home_map_label_parameter.freezed.dart \
  app/lib/feature/home/data/model/home_map_label_parameter.g.dart \
  app/test/feature/home/data/model/home_map_label_parameter_test.dart
git commit -m "fix: 地図ラベルの初期表示を無効化"
```

### Task 2: Preserve legacy partial preference deserialization

**Files:**
- Modify: `app/lib/feature/home/data/model/home_map_label_parameter.dart:8-12`
- Modify: `app/lib/feature/home/data/model/home_map_label_parameter.freezed.dart` (generated)
- Modify: `app/lib/feature/home/data/model/home_map_label_parameter.g.dart` (generated)
- Modify: `app/test/feature/home/data/model/home_map_label_parameter_test.dart`

**Interfaces:**
- Consumes: `const HomeMapLabelParameter()` and `HomeMapLabelParameter.fromJson(Map<String, dynamic>)`.
- Produces: constructor defaults of `false`, while JSON that omits either legacy label field restores it as `true`.

- [ ] **Step 1: Extend the failing regression test**

```dart
test('keeps legacy label defaults when deserializing missing fields', () {
  final parameter = HomeMapLabelParameter.fromJson(<String, dynamic>{});

  expect(parameter.showRegionLabel, isTrue);
  expect(parameter.showCityLabel, isTrue);
});
```

- [ ] **Step 2: Run the focused test and verify it fails**

Run: `mise exec -- flutter test app/test/feature/home/data/model/home_map_label_parameter_test.dart`

Expected: FAIL because the current generated JSON defaults deserialize omitted label fields as `false`.

- [ ] **Step 3: Preserve the JSON defaults and regenerate code**

```dart
@JsonKey(defaultValue: true) @Default(false) bool showRegionLabel,
@JsonKey(defaultValue: true) @Default(false) bool showCityLabel,
```

Run: `mise exec -- dart run build_runner build --delete-conflicting-outputs`

- [ ] **Step 4: Run focused validation**

Run:

```bash
mise exec -- flutter test app/test/feature/home/data/model/home_map_label_parameter_test.dart
mise exec -- dart analyze app/lib/feature/home/data/model/home_map_label_parameter.dart app/test/feature/home/data/model/home_map_label_parameter_test.dart
```

Expected: the focused test exits with status 0; report any analyzer failure unrelated to this change with its exact configuration error.

- [ ] **Step 5: Commit the repair**

```bash
git add app/lib/feature/home/data/model/home_map_label_parameter.dart \
  app/lib/feature/home/data/model/home_map_label_parameter.freezed.dart \
  app/lib/feature/home/data/model/home_map_label_parameter.g.dart \
  app/test/feature/home/data/model/home_map_label_parameter_test.dart
git commit -m "fix: 旧地図ラベル設定の復元を維持"
```

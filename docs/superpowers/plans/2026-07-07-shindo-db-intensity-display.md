# 地震履歴詳細ページ 震度データベース表示統合 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 地震履歴詳細ページに「防災情報XML ⇔ 震度データベース」のソース切り替えを追加し、震度DBの観測点・震源情報を専用ツリー/カード/地図レイヤーで表示する(旧「震度データベース詳細」カードは削除)。

**Architecture:** API の `catalog` をアプリ側ドメインモデル(`EarthquakeCatalog` 作り直し)として保持し、Repository 層で観測点→市区町村を `ShindoDbStationItem.cityCode`(backend が事前計算)で解決して `ShindoDbIntensityTree` を構築。DB 表示に切り替えたときに別 Provider が遅延計算する。UI・地図は既存の LPGM/塗り分けパターンを流用。

**Tech Stack:** Flutter 3.44 / Riverpod (riverpod_annotation) / Freezed / MapLibre (flutter-maplibre) / flutter_test

**Spec:** `docs/superpowers/specs/2026-07-07-shindo-db-intensity-display-design.md`(必読)

## Global Constraints

- `dart analyze` は警告ゼロを維持(ローカルで exit 4 + plugin クラッシュが出る場合は既知の eqmonitor_lints 競合。**エラー一覧が develop と同じであること**を確認する)
- `dart format` 準拠(CI 強制)
- Freezed/Riverpod の生成コードはコミットする。生成コマンド: `cd app && dart run build_runner build --delete-conflicting-outputs`
- 公開 Riverpod Provider は 1 ファイルに 1 つまで
- コードから自明なコメントは書かない(「なぜ」だけ書く)
- API 型(`package:eqmonitor_api`)を UI・Notifier の状態に露出させない(変換は model/repository 層で行う)
- クロスパッケージ import は package import
- コミットメッセージ末尾: `Claude-Session: https://claude.ai/code/session_01MTgm7LTGwiY327MzpFAyC9`
- **backend 依存**: `shindo_db_stations.json` の `city_code` フィールド(nullable、キー省略あり)は別 subagent が backend で実装中。アプリ側は `json['city_code'] as String?` で読む(省略・null 両対応)。最終報告でキー名が変わった場合は Task 3 を合わせる

---

### Task 1: 設計ドキュメントのコミットと `ShindoDbIntensityClass` enum

**Files:**
- Copy: `docs/superpowers/specs/2026-07-07-shindo-db-intensity-display-design.md`、`docs/superpowers/plans/2026-07-07-shindo-db-intensity-display.md`、`.memo/20260707/`(メインチェックアウト `/Users/ryotaro.onoue/dev/github.com/YumNumm/EQMonitor` から worktree へ。無ければ既にある)
- Create: `app/lib/feature/earthquake_history/data/model/shindo_db_intensity_class.dart`
- Test: `app/test/feature/earthquake_history/data/shindo_db_intensity_class_test.dart`

**Interfaces:**
- Produces: `ShindoDbIntensityClass`(enum, 18値)、`ApiCatalogIntensityClassConverter.toShindoDbIntensityClass`(extension on `api.CatalogIntensityClass`)。プロパティ: `String label` / `String sectionTitle` / `String? historicalDescription` / `JmaIntensity? exactJmaIntensity` / `JmaIntensity? colorJmaIntensity` / `int orderIndex` / `bool isNumeric`

- [ ] **Step 1: docs を worktree にコピーしてコミット**

```bash
git add docs/superpowers/specs/2026-07-07-shindo-db-intensity-display-design.md \
        docs/superpowers/plans/2026-07-07-shindo-db-intensity-display.md .memo/20260707/
git commit -m "docs: 震度データベース表示統合の設計書・実装計画を追加"
```

- [ ] **Step 2: 失敗するテストを書く**

```dart
// app/test/feature/earthquake_history/data/shindo_db_intensity_class_test.dart
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShindoDbIntensityClass', () {
    test('API の全階級コードが変換されること', () {
      const cases = <api.CatalogIntensityClass, ShindoDbIntensityClass>{
        api.CatalogIntensityClass.value1: ShindoDbIntensityClass.one,
        api.CatalogIntensityClass.value2: ShindoDbIntensityClass.two,
        api.CatalogIntensityClass.value3: ShindoDbIntensityClass.three,
        api.CatalogIntensityClass.value4: ShindoDbIntensityClass.four,
        api.CatalogIntensityClass.value5: ShindoDbIntensityClass.five,
        api.CatalogIntensityClass.value6: ShindoDbIntensityClass.six,
        api.CatalogIntensityClass.value7: ShindoDbIntensityClass.seven,
        api.CatalogIntensityClass.value9: ShindoDbIntensityClass.unknownFelt,
        api.CatalogIntensityClass.a: ShindoDbIntensityClass.fiveLower,
        api.CatalogIntensityClass.b: ShindoDbIntensityClass.fiveUpper,
        api.CatalogIntensityClass.c: ShindoDbIntensityClass.sixLower,
        api.CatalogIntensityClass.d: ShindoDbIntensityClass.sixUpper,
        api.CatalogIntensityClass.l: ShindoDbIntensityClass.local,
        api.CatalogIntensityClass.s: ShindoDbIntensityClass.semiLocal,
        api.CatalogIntensityClass.m: ShindoDbIntensityClass.semiConspicuous,
        api.CatalogIntensityClass.r: ShindoDbIntensityClass.conspicuous,
        api.CatalogIntensityClass.f: ShindoDbIntensityClass.felt,
        api.CatalogIntensityClass.x: ShindoDbIntensityClass.nearbyFelt,
      };
      expect(cases.length, api.CatalogIntensityClass.values.length);
      for (final entry in cases.entries) {
        expect(
          entry.key.toShindoDbIntensityClass,
          entry.value,
          reason: '${entry.key}',
        );
      }
    });

    test('orderIndex は仕様の表示順で単調であること', () {
      const ordered = [
        ShindoDbIntensityClass.seven,
        ShindoDbIntensityClass.sixUpper,
        ShindoDbIntensityClass.sixLower,
        ShindoDbIntensityClass.six,
        ShindoDbIntensityClass.fiveUpper,
        ShindoDbIntensityClass.fiveLower,
        ShindoDbIntensityClass.five,
        ShindoDbIntensityClass.four,
        ShindoDbIntensityClass.three,
        ShindoDbIntensityClass.two,
        ShindoDbIntensityClass.one,
        ShindoDbIntensityClass.unknownFelt,
        ShindoDbIntensityClass.conspicuous,
        ShindoDbIntensityClass.semiConspicuous,
        ShindoDbIntensityClass.semiLocal,
        ShindoDbIntensityClass.local,
        ShindoDbIntensityClass.felt,
        ShindoDbIntensityClass.nearbyFelt,
      ];
      expect(ordered.toSet().length, ShindoDbIntensityClass.values.length);
      for (var i = 0; i + 1 < ordered.length; i++) {
        expect(
          ordered[i].orderIndex > ordered[i + 1].orderIndex,
          isTrue,
          reason: '${ordered[i]} > ${ordered[i + 1]}',
        );
      }
    });

    test('数値階級は色を持ち、歴史的階級は色を持たないこと', () {
      expect(
        ShindoDbIntensityClass.five.colorJmaIntensity,
        JmaIntensity.fiveLower,
      );
      expect(ShindoDbIntensityClass.six.colorJmaIntensity, JmaIntensity.sixLower);
      expect(ShindoDbIntensityClass.five.exactJmaIntensity, isNull);
      expect(
        ShindoDbIntensityClass.fiveLower.exactJmaIntensity,
        JmaIntensity.fiveLower,
      );
      for (final v in [
        ShindoDbIntensityClass.unknownFelt,
        ShindoDbIntensityClass.local,
        ShindoDbIntensityClass.felt,
        ShindoDbIntensityClass.nearbyFelt,
      ]) {
        expect(v.colorJmaIntensity, isNull, reason: '$v');
        expect(v.isNumeric, isFalse, reason: '$v');
        expect(v.historicalDescription, isNotNull, reason: '$v');
      }
    });
  });
}
```

- [ ] **Step 3: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/data/shindo_db_intensity_class_test.dart`
Expected: FAIL(`shindo_db_intensity_class.dart` が存在しない)

- [ ] **Step 4: enum を実装**

```dart
// app/lib/feature/earthquake_history/data/model/shindo_db_intensity_class.dart
import 'package:eqmonitor/core/model/intensity/jma_intensity.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;

/// 震度データベースの震度階級コード
/// https://www.data.jma.go.jp/eqev/data/bulletin/data/shindo/format_j.txt
enum ShindoDbIntensityClass {
  one,
  two,
  three,
  four,

  /// 1996年9月以前の細分化されていない震度5
  five,
  fiveLower,
  fiveUpper,

  /// 1996年9月以前の細分化されていない震度6
  six,
  sixLower,
  sixUpper,
  seven,

  /// 有感だが震度不明 (9)
  unknownFelt,

  /// 顕著地震: 最大有感距離300km以上 (R)
  conspicuous,

  /// やや顕著地震: 最大有感距離200km以上300km未満 (M)
  semiConspicuous,

  /// 小局発地震: 最大有感距離100km以上200km未満 (S)
  semiLocal,

  /// 局発地震: 最大有感距離100km未満 (L)
  local,

  /// 有感地震 (F, 1984年まで)
  felt,

  /// 付近有感 (X, 1996年9月まで)
  nearbyFelt;

  String get label => switch (this) {
    .one => '1',
    .two => '2',
    .three => '3',
    .four => '4',
    .five => '5',
    .fiveLower => '5弱',
    .fiveUpper => '5強',
    .six => '6',
    .sixLower => '6弱',
    .sixUpper => '6強',
    .seven => '7',
    .unknownFelt => '震度不明',
    .conspicuous => '顕著',
    .semiConspicuous => 'やや顕著',
    .semiLocal => '小局発',
    .local => '局発',
    .felt => '有感',
    .nearbyFelt => '付近有感',
  };

  String get sectionTitle => switch (this) {
    .unknownFelt => '震度不明(有感)',
    .conspicuous => '顕著地震',
    .semiConspicuous => 'やや顕著地震',
    .semiLocal => '小局発地震',
    .local => '局発地震',
    .felt => '有感',
    .nearbyFelt => '付近有感',
    _ => '震度$label',
  };

  /// 歴史的階級の説明。数値階級は null
  String? get historicalDescription => switch (this) {
    .unknownFelt => '有感であったが震度は不明',
    .conspicuous => '最大有感距離300km以上の地震 (歴史的分類)',
    .semiConspicuous => '最大有感距離200km以上300km未満の地震 (歴史的分類)',
    .semiLocal => '最大有感距離100km以上200km未満の地震 (歴史的分類)',
    .local => '最大有感距離100km未満の地震 (歴史的分類)',
    .felt => '有感地震 (1984年までの分類)',
    .nearbyFelt => '付近有感 (1996年9月までの分類)',
    _ => null,
  };

  /// アイコンをそのまま流用できる JMA 震度。5/6 (旧階級) と歴史的階級は null
  JmaIntensity? get exactJmaIntensity => switch (this) {
    .one => .one,
    .two => .two,
    .three => .three,
    .four => .four,
    .fiveLower => .fiveLower,
    .fiveUpper => .fiveUpper,
    .sixLower => .sixLower,
    .sixUpper => .sixUpper,
    .seven => .seven,
    _ => null,
  };

  /// 塗り分け・チップの配色に使う JMA 震度。旧階級 5/6 は弱側の色で代替。
  /// 歴史的階級は null (グレー表現)
  JmaIntensity? get colorJmaIntensity => switch (this) {
    .five => .fiveLower,
    .six => .sixLower,
    _ => exactJmaIntensity,
  };

  bool get isNumeric => colorJmaIntensity != null;

  /// 表示順 (大きいほど上に表示)
  int get orderIndex => switch (this) {
    .seven => 17,
    .sixUpper => 16,
    .sixLower => 15,
    .six => 14,
    .fiveUpper => 13,
    .fiveLower => 12,
    .five => 11,
    .four => 10,
    .three => 9,
    .two => 8,
    .one => 7,
    .unknownFelt => 6,
    .conspicuous => 5,
    .semiConspicuous => 4,
    .semiLocal => 3,
    .local => 2,
    .felt => 1,
    .nearbyFelt => 0,
  };
}

extension ApiCatalogIntensityClassConverter on api.CatalogIntensityClass {
  ShindoDbIntensityClass get toShindoDbIntensityClass => switch (this) {
    .value1 => .one,
    .value2 => .two,
    .value3 => .three,
    .value4 => .four,
    .value5 => .five,
    .value6 => .six,
    .value7 => .seven,
    .value9 => .unknownFelt,
    .a => .fiveLower,
    .b => .fiveUpper,
    .c => .sixLower,
    .d => .sixUpper,
    .l => .local,
    .s => .semiLocal,
    .m => .semiConspicuous,
    .r => .conspicuous,
    .f => .felt,
    .x => .nearbyFelt,
  };
}
```

- [ ] **Step 5: テストが通ることを確認**

Run: `cd app && flutter test test/feature/earthquake_history/data/shindo_db_intensity_class_test.dart`
Expected: PASS

- [ ] **Step 6: コミット**

```bash
git add app/lib/feature/earthquake_history/data/model/shindo_db_intensity_class.dart \
        app/test/feature/earthquake_history/data/shindo_db_intensity_class_test.dart
git commit -m "feat: 震度データベースの震度階級 enum を追加"
```

---

### Task 2: `EarthquakeCatalog` ドメインモデル作り直しと旧カード削除

**Files:**
- Rewrite: `app/lib/feature/earthquake_history/data/model/earthquake_catalog.dart`(全置換)
- Delete: `app/lib/feature/earthquake_history/ui/components/earthquake_catalog_card.dart`
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart`(`EarthquakeCatalogCard(catalog: earthquake.catalog),` の行 137 と import 行 12 を削除)
- Modify: `app/lib/feature/earthquake_history/data/model/earthquake.dart`(変更不要のはず — `catalog: catalog?.toEarthquakeCatalog` のまま。extension 名が変わらないことを確認)
- Test: `app/test/feature/earthquake_history/data/earthquake_catalog_test.dart`

**Interfaces:**
- Consumes: `ShindoDbIntensityClass`(Task 1)
- Produces(すべて freezed、`fromJson` なし):
  - `EarthquakeCatalog { List<EarthquakeCatalogHypocenter> hypocenters, List<EarthquakeCatalogStationRecord> stationRecords, String? damageScaleLabel, String? tsunamiScaleLabel, double? linkMatchConfidence }`
  - `EarthquakeCatalogHypocenter { int seq, String epicenterName, int stationCount, String recordTypeLabel, DateTime? originTime, double? originTimeStderrSeconds, double? latitude, double? longitude, double? depthKm, bool depthIsFree, double? depthStderrKm, ShindoDbIntensityClass? maxIntensity, String? determinationFlagLabel, String? evaluationLabel, List<EarthquakeCatalogMagnitude> magnitudes }`
  - `EarthquakeCatalogMagnitude { String typeLabel, double value }`
  - `EarthquakeCatalogStationRecord { String stationCode, ShindoDbIntensityClass intensityClass, double? instrumentalIntensity, DateTime? observedAt, EarthquakeCatalogMaxAcceleration? maxAcceleration, DateTime? maxAccelTime, EarthquakeCatalogPeriods? periods, int? observationCount }`
  - `EarthquakeCatalogMaxAcceleration { double? synthesizedGal, double? nsGal, double? ewGal, double? udGal }`
  - `EarthquakeCatalogPeriods { EarthquakeCatalogPeriodComponent? ns, ew, ud }`
  - `EarthquakeCatalogPeriodComponent { String? maxAccelPeriodText, String? predominantPeriodText }`
  - `extension EarthquakeCatalogApiExtension on api.Catalog { EarthquakeCatalog get toEarthquakeCatalog }`

**変換仕様(ラベルは API enum の doc コメント/format_j.txt 準拠):**
- recordType: `A→'震源', B→'群発地震の震源', D→'震源が離れた地震の組の震源'`
- determinationFlag: `K→'気象庁震源', S→'気象庁参考震源', k→'簡易気象庁震源', s→'簡易参考震源', A→'自動処理震源', a→'自動処理参考震源', N→'震源固定・不定・未計算', U→'USGS震源', I→'ISC震源', H→'観測時刻が時間単位', D→'観測時刻が日単位', M→'観測時刻が月単位'`
- evaluation: `1→'深さフリー', 2→'深さ刻み', 3→'人の判断(深さ固定等)', 4→'Depth phase使用', 5→'S-P使用', 7→'参考', 8→'決定不能・不採用'`
- magnitude type: `J→'坪井変位M(旧観測網)', D→'変位M', d→'変位M(観測点少)', V→'速度M', v→'速度M(観測点少)', W→'モーメントM', B→'実体波M', S→'表面波M'`
- damageScale: `1→'1: 壁や地面の亀裂程度の微小被害', 2→'2: 家屋・道路の破損など小被害', 3→'3: 複数の死者または複数の全壊家屋', 4→'4: 死者20人以上または全壊1千戸以上', 5→'5: 死者200人以上または全壊1万戸以上', 6→'6: 死者2千人以上または全壊10万戸以上', 7→'7: 死者2万人以上または全壊100万戸以上', X→'被害あり(程度不明)', Y→'前後の地震の被害と区別不能'`
- tsunamiScale: `1→'1: 波高50cm以下または被害なし', 2→'2: 波高1m前後', 3→'3: 波高2m前後', 4→'4: 波高4〜6m程度', 5→'5: 波高10〜20m程度', 6→'6: 波高30m以上', T→'津波あり'`
- period: `CatalogPeriodValue` → `value == null → '欠測'`、`kind == FREQUENCY → '${value}Hz'`、`kind == PERIOD → '${value}秒'`
- `auxiliaryInfo` / `travelTimeTable` / `largeAreaCode` / `smallAreaCode` / `link` の confidence 以外は**ドメインモデルに持たない**(UI に出さないため。YAGNI)

- [ ] **Step 1: 失敗するテストを書く**

```dart
// app/test/feature/earthquake_history/data/earthquake_catalog_test.dart
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_catalog.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EarthquakeCatalogApiExtension', () {
    test('震源レコード・観測点レコード・規模が変換されること', () {
      final catalog = api.Catalog(
        hypocenters: [
          api.CatalogHypocenter(
            seq: 0,
            recordType: api.CatalogHypocenterRecordType.a,
            magnitudes: const [
              api.CatalogHypocenterMagnitude(
                type: api.CatalogMagnitudeType.upperD,
                value: 6.5,
              ),
            ],
            epicenterName: '兵庫県南部',
            stationCount: 100,
            originTime: DateTime(1995, 1, 17, 5, 46),
            originTimeStderrSeconds: 0.2,
            depth: const api.CatalogHypocenterDepth(value: 16, isFree: false),
            maxIntensity: api.CatalogIntensityClass.value7,
            determinationFlag: api.CatalogDeterminationFlag.upperK,
            evaluation: api.CatalogHypocenterEvaluation.value3,
          ),
        ],
        stationRecords: [
          api.CatalogStationRecord(
            stationCode: '6310000',
            intensity: const api.CatalogStationIntensity(
              classValue: api.CatalogIntensityClass.value6,
              instrumental: 6.4,
            ),
            observedAt: DateTime(1995, 1, 17, 5, 46, 30),
            maxAcceleration: const api.CatalogStationMaxAcceleration(
              synthesizedGal: 891,
              nsGal: 818,
            ),
            periods: const api.CatalogStationPeriods(
              ns: api.CatalogStationPeriodComponent(
                maxAccelPeriod: api.CatalogPeriodValue(
                  kind: api.CatalogPeriodKind.period,
                  value: 0.4,
                ),
                predominantPeriod: api.CatalogPeriodValue(
                  kind: api.CatalogPeriodKind.frequency,
                ),
              ),
            ),
          ),
        ],
        damageScale: api.CatalogDamageScale.value7,
        tsunamiScale: api.CatalogTsunamiScale.value1,
        link: const api.CatalogLink(
          matchConfidence: 0.98,
          matchMethod: api.CatalogLinkMatchMethod.auto,
          timeDiffSeconds: 1.2,
          distanceKm: 3.4,
        ),
      );

      final result = catalog.toEarthquakeCatalog;

      final hypocenter = result.hypocenters.single;
      expect(hypocenter.epicenterName, '兵庫県南部');
      expect(hypocenter.recordTypeLabel, '震源');
      expect(hypocenter.originTimeStderrSeconds, 0.2);
      expect(hypocenter.depthKm, 16);
      expect(hypocenter.depthIsFree, isFalse);
      expect(hypocenter.maxIntensity, ShindoDbIntensityClass.seven);
      expect(hypocenter.determinationFlagLabel, '気象庁震源');
      expect(hypocenter.magnitudes.single.typeLabel, '変位M');
      expect(hypocenter.magnitudes.single.value, 6.5);

      final station = result.stationRecords.single;
      expect(station.stationCode, '6310000');
      expect(station.intensityClass, ShindoDbIntensityClass.six);
      expect(station.instrumentalIntensity, 6.4);
      expect(station.maxAcceleration?.synthesizedGal, 891);
      expect(station.periods?.ns?.maxAccelPeriodText, '0.4秒');
      expect(station.periods?.ns?.predominantPeriodText, '欠測');
      expect(station.periods?.ew, isNull);

      expect(result.damageScaleLabel, startsWith('7:'));
      expect(result.tsunamiScaleLabel, startsWith('1:'));
      expect(result.linkMatchConfidence, 0.98);
    });
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/data/earthquake_catalog_test.dart`
Expected: FAIL(新フィールドが存在しない)

- [ ] **Step 3: `earthquake_catalog.dart` を全置換**

freezed で上記 Interfaces のクラス群と変換 extension を実装する。骨子:

```dart
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_class.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'earthquake_catalog.freezed.dart';

/// 震度データベース (i####.zip カタログ) 由来の詳細情報
@freezed
abstract class EarthquakeCatalog with _$EarthquakeCatalog {
  const factory EarthquakeCatalog({
    required List<EarthquakeCatalogHypocenter> hypocenters,
    required List<EarthquakeCatalogStationRecord> stationRecords,
    required String? damageScaleLabel,
    required String? tsunamiScaleLabel,
    required double? linkMatchConfidence,
  }) = _EarthquakeCatalog;
}
// ...(Interfaces 記載の残りのクラスも同形式で定義)

extension EarthquakeCatalogApiExtension on api.Catalog {
  EarthquakeCatalog get toEarthquakeCatalog => EarthquakeCatalog(
    hypocenters: hypocenters.map((e) => e.toEarthquakeCatalogHypocenter).toList(),
    stationRecords: stationRecords
        .map((e) => e.toEarthquakeCatalogStationRecord)
        .toList(),
    damageScaleLabel: damageScale?.label,
    tsunamiScaleLabel: tsunamiScale?.label,
    linkMatchConfidence: link?.matchConfidence.toDouble(),
  );
}
```

ラベル変換は本タスク冒頭の「変換仕様」の表を private extension
(`extension on api.CatalogDamageScale { String get label => switch (this) {...} }` 等)で実装。
`CatalogPeriodValue` → String は top-level 関数 `String formatCatalogPeriodValue(api.CatalogPeriodValue value)` にする。

- [ ] **Step 4: 旧カードと参照を削除**

1. `app/lib/feature/earthquake_history/ui/components/earthquake_catalog_card.dart` を削除
2. `earthquake_history_details_page.dart` から `EarthquakeCatalogCard(...)` 行と import を削除
3. 残参照が無いことを確認: `grep -rn "EarthquakeCatalogCard\|EarthquakeCatalogSection\|EarthquakeCatalogRow\|buildCatalog" app/lib app/test`
   ヒットした場合はすべて削除・修正する

- [ ] **Step 5: コード生成 → テスト**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs
flutter test test/feature/earthquake_history/data/earthquake_catalog_test.dart
```
Expected: PASS

- [ ] **Step 6: アプリ全体のコンパイル確認とコミット**

```bash
cd app && dart analyze   # エラー一覧が develop 比で増えていないこと
git add -A app/lib/feature/earthquake_history app/test/feature/earthquake_history
git commit -m "feat: EarthquakeCatalog をドメインモデルに作り直し、震度データベース詳細カードを削除"
```

---

### Task 3: `ShindoDbStationItem.cityCode` と既存プレフィックス照合の置き換え

**Files:**
- Modify: `app/lib/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart`
- Modify: `app/lib/feature/earthquake_history/data/model/intensity_tree_converter.dart:55-98`
- Test: `app/test/feature/earthquake_history/data/shindo_db_stations_parameter_test.dart`

**Interfaces:**
- Produces: `ShindoDbStationItem.cityCode`(`String?`、JSON キー `city_code`、キー省略/null 両対応)
- 背景: 既存の `_cityIdentificationPrefixMap`(観測点コード上5桁と市区町村コード先頭5桁の照合)は誤った仮説に基づいており偶然衝突する(`.memo/20260707/shindo-db-city-mapping-調査.md` 検証1)。backend が事前計算した `city_code` の直引きに置き換える

- [ ] **Step 1: 失敗するテストを書く**

```dart
// app/test/feature/earthquake_history/data/shindo_db_stations_parameter_test.dart
import 'package:eqmonitor/feature/parameter/data/model/shindo_db/shindo_db_stations_parameter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ShindoDbStationItem.fromJson', () {
    test('city_code があれば読み、無ければ null', () {
      final withCity = ShindoDbStationItem.fromJson(const {
        'code': '6310000',
        'name': '神戸中央区中山手',
        'latitude': 34.69,
        'longitude': 135.18,
        'city_code': '2811000',
      });
      expect(withCity.cityCode, '2811000');

      final withoutCity = ShindoDbStationItem.fromJson(const {
        'code': '5399900',
        'name': '神戸市等阪神淡路地域',
        'latitude': 34.7,
        'longitude': 135.2,
      });
      expect(withoutCity.cityCode, isNull);

      final nullCity = ShindoDbStationItem.fromJson(const {
        'code': '5399900',
        'name': '神戸市等阪神淡路地域',
        'latitude': 34.7,
        'longitude': 135.2,
        'city_code': null,
      });
      expect(nullCity.cityCode, isNull);
    });
  });
}
```

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/data/shindo_db_stations_parameter_test.dart`
Expected: FAIL(`cityCode` が存在しない)

- [ ] **Step 3: モデルに `cityCode` を追加**

`ShindoDbStationItem` の factory に `required String? cityCode` を追加し、`fromJson` に
`cityCode: json['city_code'] as String?,` を追加。

- [ ] **Step 4: `intensity_tree_converter.dart` の照合を置き換え**

1. `_stationCityCodeMap()` の shindoDbStations ループを以下に置き換える:

```dart
if (shindoDbStations != null) {
  for (final station in shindoDbStations!.stations) {
    final cityCode = station.cityCode;
    if (cityCode != null) {
      map.putIfAbsent(station.code, () => cityCode);
    }
  }
}
```

2. `_cityIdentificationPrefixMap()` を削除
3. `convertToLpgmIntensityTree` → `_buildLpgmPrefectureCityStations` の
   `cityPrefixToCityCode` パラメータ(渡しているが未使用)を削除

- [ ] **Step 5: コード生成 → テスト → コミット**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs
flutter test test/feature/earthquake_history/ test/feature/parameter/ 2>/dev/null; flutter test test/feature/earthquake_history/
```
Expected: PASS(既存の converter 関連テストも含む)

```bash
git add -A app/lib app/test
git commit -m "feat: 震度DB観測点に city_code を追加し誤った先頭5桁照合を置き換え"
```

---

### Task 4: `ShindoDbIntensityTree` モデルと Repository のツリー構築

**Files:**
- Create: `app/lib/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart`
- Modify: `app/lib/feature/earthquake_history/data/repository/earthquake_history_repository.dart`(メソッド追加)
- Test: `app/test/feature/earthquake_history/data/shindo_db_intensity_tree_test.dart`

**Interfaces:**
- Consumes: `EarthquakeCatalog`(Task 2)、`ShindoDbStationItem.cityCode`(Task 3)
- Produces(freezed、`fromJson` なし):
  - `ShindoDbIntensityTree { Map<ShindoDbIntensityClass, List<ShindoDbPrefectureNode>> tree, Map<ShindoDbIntensityClass, List<ShindoDbStationNode>> unresolvedStations, int totalStationCount }`
  - `ShindoDbPrefectureNode { EarthquakeParameterPrefectureItem prefecture, List<ShindoDbCityNode> cities }`
  - `ShindoDbCityNode { EarthquakeParameterCityItem city, EarthquakeParameterRegionItem region, List<ShindoDbStationNode> stations }`
  - `ShindoDbStationNode { EarthquakeCatalogStationRecord record, String name, LatLng? location }`
  - `EarthquakeHistoryRepository.buildShindoDbIntensityTree({required EarthquakeCatalog catalog}) → ShindoDbIntensityTree`

**構築仕様:**
- `shindoDbStations.stations` から `code → item` 索引を作る
- `earthquakeParameter.prefectures` を1回走査して `cityCode → (city, region, prefecture)` 索引を作る
- 各 `stationRecords` を `intensityClass` → prefecture → city に集約。
  観測点が索引に無い / `cityCode == null` / cityCode が parameter に無い場合は `unresolvedStations[class]` へ
  (name は観測点があれば `item.name`、無ければ `record.stationCode`)
- `tree` のキーは `orderIndex` 降順、都道府県・市区町村はコード昇順、観測点はコード昇順でソート
- 同期実装。計測は Task 11 で行い、必要な場合のみ isolate 化(その際 `EarthquakeParameter` 丸ごとではなく構築済み索引のみ渡す)

- [ ] **Step 1: 失敗するテストを書く**

パラメータのフィクスチャは `EarthquakeParameter` / `ShindoDbStationsParameter` を最小構成で直接組み立てる
(コンストラクタの必須フィールドは `app/lib/core/provider/jma_parameter/jma_parameter.dart` と
`app/lib/feature/parameter/data/model/` の定義に合わせる。既存の
`app/test/feature/earthquake_history/earthquake_history_parameter_x_test.dart` などの組み立て例を参照):

```dart
// app/test/feature/earthquake_history/data/shindo_db_intensity_tree_test.dart
// テスト観点:
void main() {
  group('buildShindoDbIntensityTree', () {
    test('階級→都道府県→市区町村→観測点に集約されること', () {
      // 観測点2つ (別市区町村・同一階級 six) + 1つ (階級 unknownFelt)
      // → tree[six] に都道府県1件・市区町村2件、tree[unknownFelt] に1件
    });
    test('cityCode が null の観測点は unresolvedStations に入ること', () {
      // 53999 相当 (cityCode: null) → unresolvedStations[class] に入り name が解決される
    });
    test('shindoDbStations に無い観測点コードは name がコードのまま unresolved になること', () {});
    test('tree のキーが orderIndex 降順で並ぶこと', () {});
  });
}
```

上記観点それぞれに assertion を実装する(コメントだけのテストは不可)。

- [ ] **Step 2: テストが失敗することを確認**

Run: `cd app && flutter test test/feature/earthquake_history/data/shindo_db_intensity_tree_test.dart`
Expected: FAIL

- [ ] **Step 3: モデルと Repository メソッドを実装**

`buildShindoDbIntensityTree` の骨子:

```dart
ShindoDbIntensityTree buildShindoDbIntensityTree({
  required EarthquakeCatalog catalog,
}) {
  final stationByCode = {
    for (final station in shindoDbStations.stations) station.code: station,
  };
  final cityIndex =
      <String,
          ({
            EarthquakeParameterCityItem city,
            EarthquakeParameterRegionItem region,
            EarthquakeParameterPrefectureItem prefecture,
          })>{};
  for (final prefecture in earthquakeParameter.prefectures) {
    for (final region in prefecture.regions) {
      for (final city in region.cities) {
        cityIndex[city.code] =
            (city: city, region: region, prefecture: prefecture);
      }
    }
  }

  // class → prefectureCode → cityCode → List<ShindoDbStationNode> に集約後、
  // ソートして freezed ノードを組み立てる (実装は _Mutable* ヘルパーでも可)
  ...
}
```

- [ ] **Step 4: コード生成 → テスト**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs
flutter test test/feature/earthquake_history/data/shindo_db_intensity_tree_test.dart
```
Expected: PASS

- [ ] **Step 5: コミット**

```bash
git add -A app/lib app/test
git commit -m "feat: 震度DBカタログから階級ツリーを構築する Repository メソッドを追加"
```

---

### Task 5: `shindoDbIntensityTreeProvider`(遅延計算)

**Files:**
- Create: `app/lib/feature/earthquake_history/data/provider/shindo_db_intensity_tree_provider.dart`
- Test: `app/test/feature/earthquake_history/data/shindo_db_intensity_tree_provider_test.dart`

**Interfaces:**
- Consumes: `earthquakeHistoryDetailsProvider(eventId)`、`earthquakeHistoryRepositoryProvider`、`buildShindoDbIntensityTree`(Task 4)
- Produces: `shindoDbIntensityTreeProvider(String eventId) → AsyncValue<ShindoDbIntensityTree?>`(catalog が無いイベントでは null)

- [ ] **Step 1: Provider を実装**

```dart
// app/lib/feature/earthquake_history/data/provider/shindo_db_intensity_tree_provider.dart
import 'package:eqmonitor/feature/earthquake_history/data/model/shindo_db_intensity_tree.dart';
import 'package:eqmonitor/feature/earthquake_history/data/notifier/earthquake_history_details_notifier.dart';
import 'package:eqmonitor/feature/earthquake_history/data/repository/earthquake_history_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shindo_db_intensity_tree_provider.g.dart';

/// 震度データベース表示に切り替えたときに初めて watch され、遅延計算される
@riverpod
Future<ShindoDbIntensityTree?> shindoDbIntensityTree(
  Ref ref,
  String eventId,
) async {
  final earthquake = await ref.watch(
    earthquakeHistoryDetailsProvider(eventId).future,
  );
  final catalog = earthquake.catalog;
  if (catalog == null) {
    return null;
  }
  final repository = await ref.watch(
    earthquakeHistoryRepositoryProvider.future,
  );
  return repository.buildShindoDbIntensityTree(catalog: catalog);
}
```

- [ ] **Step 2: ProviderContainer ベースのテストを書く**

`earthquakeHistoryDetailsProvider` / `earthquakeHistoryRepositoryProvider` を override して、
catalog あり → ツリーが返る / catalog なし → null を検証する。既存 provider テストの
override パターン(`app/test/` 内の `ProviderContainer(overrides: [...])` 使用例)に合わせる。

- [ ] **Step 3: コード生成 → テスト → コミット**

```bash
cd app && dart run build_runner build --delete-conflicting-outputs
flutter test test/feature/earthquake_history/data/shindo_db_intensity_tree_provider_test.dart
git add -A app/lib app/test
git commit -m "feat: 震度DBツリーの遅延計算 Provider を追加"
```

---

### Task 6: 階級アイコンと観測点詳細シート

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart`
- Create: `app/lib/feature/earthquake_history/ui/components/shindo_db_station_detail_sheet.dart`

**Interfaces:**
- Consumes: `ShindoDbIntensityClass`、`ShindoDbStationNode`
- Produces:
  - `ShindoDbIntensityClassIcon { required ShindoDbIntensityClass intensityClass, double size = 40 }`
  - `ShindoDbStationDetailSheet { required ShindoDbStationNode station }`(`showModalBottomSheet` で表示)

- [ ] **Step 1: `ShindoDbIntensityClassIcon` を実装**

```dart
// 表示分岐:
// exactJmaIntensity != null → JmaIntensityIcon(intensity: exact, type: .filled, size: size)
// colorJmaIntensity != null (旧階級 5/6) → 震度色の角丸 Container + 中央に label('5'/'6')
// それ以外 (歴史的階級) → surfaceContainerHighest のグレー角丸 Container + 中央に label
//   (label が長い場合に備え FittedBox(fit: .scaleDown) で収める)
```

色は `context.designSystem.colorTheme.intensity.fromJmaIntensity(colorJma)` の
`background`/`resolvedForeground` を使用(`region_intensity.dart` と同じ取り方)。
角丸は `BorderRadius.circular(size * 0.25)`、テキストは `FontFamily.googleSansCode`
+ fallback `FontFamily.notoSansJP`、bold。

- [ ] **Step 2: `ShindoDbStationDetailSheet` を実装**

`lpgm_station_detail_sheet.dart` の構造(ドラッグハンドル → ヘッダー → 表 → 関連リンク)を踏襲:

- ヘッダー: `ShindoDbIntensityClassIcon(size: 44)` + 観測点名(`station.name`) +
  `計測震度 ${instrumentalIntensity.toStringAsFixed(1)}`(null なら非表示)+
  `historicalDescription`(歴史的階級のみ、bodySmall)
- 情報行(label/value の 2 カラム、`_CatalogRowView` 相当を private で再実装):
  観測時刻(`DateFormat('yyyy/MM/dd HH:mm:ss')`、null 非表示)、観測回数(null 非表示)
- 最大加速度 Table(`maxAcceleration != null` のみ): 列 = 合成/南北/東西/上下、値 = `${gal}gal`
  (null セルは '-')。下に最大加速度時刻(null 非表示)
- 周期 Table(`periods != null` のみ): 行 = NS/EW/UD(null 成分はスキップ)、
  列 = 最大加速度周期 / 卓越周期(`maxAccelPeriodText` / `predominantPeriodText`、null は '-')
- 関連リンク(`_RelatedLinksCard` と同構造):
  - 『気象庁 震度データベース検索』 https://www.data.jma.go.jp/svd/eqdb/index.html
  - 『震度データについて(地震月報カタログ編)』 https://www.data.jma.go.jp/eqev/data/bulletin/shindo.html

- [ ] **Step 3: analyze 確認 → コミット**

```bash
cd app && dart analyze
git add app/lib/feature/earthquake_history/ui/components/shindo_db_intensity_class_icon.dart \
        app/lib/feature/earthquake_history/ui/components/shindo_db_station_detail_sheet.dart
git commit -m "feat: 震度DB階級アイコンと観測点詳細シートを追加"
```

---

### Task 7: `ShindoDbIntensityContent`(ツリー表示)

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/shindo_db_intensity_content.dart`
- Test: `app/test/feature/earthquake_history/ui/shindo_db_intensity_content_widget_test.dart`

**Interfaces:**
- Consumes: `ShindoDbIntensityTree`、`ShindoDbIntensityClassIcon`、`ShindoDbStationDetailSheet`
- Produces: `ShindoDbIntensityContent { required ShindoDbIntensityTree tree }`

- [ ] **Step 1: 失敗するウィジェットテストを書く**

`region_intensity_widget_test.dart` のパターンに合わせ、最小ツリーを直接組み立てて:
- 階級セクションのタイトル(例 `震度6`、`局発地震`)が表示される
- セクション展開 → 都道府県 → 市区町村展開で観測点チップが表示される
- チップタップで `showModalBottomSheet` が開く(`ShindoDbStationDetailSheet` が find できる)
- `unresolvedStations` があるとき「市区町村不明」グループが表示される

Run: `cd app && flutter test test/feature/earthquake_history/ui/shindo_db_intensity_content_widget_test.dart`
Expected: FAIL

- [ ] **Step 2: 実装**

`region_intensity.dart` の `_LpgmIntensityLevelSection` / `_LpgmPrefectureTile` / `_LpgmCityTile`
と同じ構造・同じ余白/展開アニメーションで private ウィジェットを組む:

- セクション行: `ShindoDbIntensityClassIcon(size: 40)` + `sectionTitle` +
  subtitle に都道府県名の列挙(4行で ellipsis)。展開矢印は `_buildTrailing` 相当を再実装
- 縦の色帯(`VerticalDivider`): `colorJmaIntensity` があれば震度色、なければ
  `surfaceContainerHighest`
- 市区町村展開時: 観測点チップ(Wrap)。チップは観測点名 + タップで
  `showModalBottomSheet(builder: (_) => ShindoDbStationDetailSheet(station: station))`
  (`_LpgmCityTile` の実装をベースにする)
- 各セクション末尾: `unresolvedStations[class]` が非空なら「市区町村不明」タイルを追加し、
  同じチップ表示を行う
- ツリーが完全に空のとき: 「震度データベースの観測点データはありません」(bodySmall)

- [ ] **Step 3: テストが通ることを確認 → コミット**

```bash
cd app && flutter test test/feature/earthquake_history/ui/shindo_db_intensity_content_widget_test.dart
git add -A app/lib app/test
git commit -m "feat: 震度DBの階級ツリー表示を追加"
```

---

### Task 8: 震源情報カードの DB 版と規模注記

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/components/shindo_db_hypocenter_information_card.dart`
- Create: `app/lib/feature/earthquake_history/ui/components/shindo_db_event_notes.dart`

**Interfaces:**
- Consumes: `EarthquakeCatalog`(Task 2)、`ShindoDbIntensityClassIcon`(Task 6)
- Produces:
  - `ShindoDbHypocenterInformationCard { required EarthquakeCatalog catalog, required DateTime? originTime }`
  - `ShindoDbEventNotes { required EarthquakeCatalog catalog }`(津波・被害規模。両方 null なら `SizedBox.shrink`)

- [ ] **Step 1: `ShindoDbHypocenterInformationCard` を実装**

`earthquake_hypocenter_information_card.dart` の見た目(色付き Card + 左に最大震度 + 右に本文)を踏襲。
主レコード = `catalog.hypocenters` の `seq == 0`(無ければ先頭。hypocenters が空なら
Card ごと `SizedBox.shrink`):

- 左: 『最大震度』+ `ShindoDbIntensityClassIcon(intensityClass: primary.maxIntensity, size: 60)`
  (maxIntensity null なら非表示)。Card 背景色は `colorJmaIntensity` の震度色
  `withValues(alpha: 0.3)`(null ならグレー)
- 本文: M(`magnitudes` 先頭を `M6.5` 形式 + typeLabel を小さく併記。空なら `M不明`)、
  深さ(`${depthKm}km`、`depthStderrKm != null` なら `±${stderr}km` を小さく併記、
  `depthIsFree` なら `(深さフリー)`)、震源地(`epicenterName`)、
  発生時刻(`DateFormat('yyyy/MM/dd HH:mm頃')`、`originTimeStderrSeconds != null` なら
  `±${seconds}秒` 併記)
- 折りたたみ(`ExpansionTile`『詳細』): レコード種別 / 決定フラグ / 震源評価 / 観測点数 /
  M 一覧(typeLabel: value) / 2 レコード目以降(同項目を `震源 N` 見出しで) /
  照合信頼度(`linkMatchConfidence != null` のみ、`(matchConfidence * 100).toStringAsFixed(0)%`)
- 行表示は label/value 2 カラム(Task 6 の情報行と同じ private 実装で良い。共通化したければ
  `shindo_db_catalog_row.dart` に切り出すが、2 箇所のみなら重複可)

- [ ] **Step 2: `ShindoDbEventNotes` を実装**

Card なし。`Padding(horizontal: 16, vertical: 4)` 内の Column:

```dart
// damageScaleLabel != null → Row: Icon(Icons.warning_amber_rounded, size:16) + '被害規模 $damageScaleLabel'
// tsunamiScaleLabel != null → Row: Icon(Icons.waves_rounded, size:16) + '津波規模 $tsunamiScaleLabel'
// style: bodySmall + onSurfaceVariant
```

- [ ] **Step 3: analyze → コミット**

```bash
cd app && dart analyze
git add app/lib/feature/earthquake_history/ui/components/shindo_db_hypocenter_information_card.dart \
        app/lib/feature/earthquake_history/ui/components/shindo_db_event_notes.dart
git commit -m "feat: 震度DBの震源情報カードと規模注記を追加"
```

---

### Task 9: 詳細ページ配線(ソース切り替え)

**Files:**
- Modify: `app/lib/feature/earthquake_history/ui/earthquake_history_details_page.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_intensity_card.dart`

**Interfaces:**
- Consumes: Task 5-8 の全成果物、`EarthquakeDataSource`、`CollapsibleSegmentedControl`
- Produces:
  - `EarthquakeIntensityCard` に追加パラメータ: `required EarthquakeDataSource source`、`required bool showDatabaseBadge`
  - 詳細ページの `_LoadedContent` にソース状態(下記)

- [ ] **Step 1: `_LoadedContent` にソース状態を追加**

```dart
final hasCatalog = earthquake.catalog != null;
final hasXml = earthquake.dataSources.contains(
  EarthquakeDataSource.jmaDisasterInformationXml,
);
final isDbOnly = hasCatalog && !hasXml;
final showSourceToggle = hasCatalog && hasXml;

final source = useState(
  isDbOnly
      ? EarthquakeDataSource.jmaIntensityDatabase
      : EarthquakeDataSource.jmaDisasterInformationXml,
);
final showingDb = source.value == EarthquakeDataSource.jmaIntensityDatabase;
```

- シート内 Column の先頭(`CachedDataBanner` の上)に、`showSourceToggle` のとき:

```dart
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  child: CollapsibleSegmentedControl<EarthquakeDataSource>(
    segments: const [
      SegmentItem(
        value: EarthquakeDataSource.jmaDisasterInformationXml,
        label: '防災情報XML',
      ),
      SegmentItem(
        value: EarthquakeDataSource.jmaIntensityDatabase,
        label: '震度データベース',
      ),
    ],
    selected: source.value,
    onSelected: (v) => source.value = v,
  ),
),
```

- カード切り替え:
  - `showingDb` → `ShindoDbHypocenterInformationCard(catalog: earthquake.catalog!, originTime: earthquake.originTime)` + `ShindoDbEventNotes(catalog: earthquake.catalog!)`
  - それ以外 → 既存 `EarthquakeHypocenterInformationCard`
- `EarthquakeIntensityCard` に `source: source.value`, `showDatabaseBadge: isDbOnly` を渡す
- `EarthquakeHistoryDetailsMapView` に `showingDb`(Task 10 で使用。本タスクではパラメータ追加のみ、
  値は無視して従来表示)を渡す
- 推計震度の初回ダイアログ(`useEffect`)は XML ソース時のみ発火するよう `!showingDb` を条件に加える

- [ ] **Step 2: `EarthquakeIntensityCard` の DB モード**

```dart
// source == jmaIntensityDatabase のとき:
//  - intensity == null でも SizedBox.shrink にしない (DBのみイベント対応)。
//    ガードを「intensity == null && !showingDb → shrink」に変更
//  - title は '各地の震度'。showDatabaseBadge のとき SheetHeader の右に
//    Text('データベース', style: labelSmall + onSurfaceVariant) を並べる
//    (Stack 内に Positioned ではなく SheetHeader を Row に包んで隣接配置)
//  - CollapsibleSegmentedControl (jma/lpgm/estimated) は表示しない
//  - コンテンツ: Consumer で shindoDbIntensityTreeProvider(item.eventId) を watch し、
//      AsyncData(value: tree?) → tree != null ? ShindoDbIntensityContent(tree: tree)
//                                             : SizedBox.shrink()
//      AsyncError → Padding + Text('震度データベースの読み込みに失敗しました')
//      それ以外 → Center(Padding(CircularProgressIndicator.adaptive()))
```

`EarthquakeIntensityCard` は `StatelessWidget` のままで良い(内側に `Consumer` を置く)。

- [ ] **Step 3: 手動確認**

```bash
cd app && flutter run --dart-define-from-file=../environment/.env.dev
```
- XML のみイベント: トグルなし、従来表示
- XML+DB イベント(2020/11/18 以降のリンク成立イベント): シート上部にトグル、切り替えで
  震源カード・震度カードが入れ替わる
- DB のみイベント(古い地震): トグルなし、「データベース」バッジ、DB ツリー表示
(実機確認が難しい場合は widget テストで `_LoadedContent` 相当を検証しても良い)

- [ ] **Step 4: analyze → コミット**

```bash
cd app && dart analyze
git add -A app/lib
git commit -m "feat: 地震履歴詳細にデータソース切り替えを追加"
```

---

### Task 10: 地図レイヤー(DB 塗り分け・観測点)

**Files:**
- Create: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_fill_layer.dart`
- Create: `app/lib/feature/earthquake_history/ui/layer/earthquake_history_shindo_db_station_layer.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_details_map_view.dart`
- Modify: `app/lib/feature/earthquake_history/ui/components/earthquake_history_map_legend.dart`

**Interfaces:**
- Consumes: `ShindoDbIntensityTree`、`shindoDbIntensityTreeProvider`、`EarthquakeHistoryFillLayerBuilder.buildRegionLayers/buildCityLayer`(public)、`EarthquakeHistoryMapLayerParameter`
- Produces:
  - `EarthquakeHistoryShindoDbFillLayer { required ShindoDbIntensityTree tree, required EarthquakeHistoryMapLayerParameter parameter }`
  - `EarthquakeHistoryShindoDbStationLayer { required ShindoDbIntensityTree tree, required EarthquakeHistoryMapLayerParameter parameter }`
  - `EarthquakeHistoryDetailsMapView` / `_MapContent` に `required bool showingDb`

- [ ] **Step 1: fill レイヤーを実装**

`earthquake_history_fill_layer.dart` の `useEffect` + `useMapOperationQueue` パターンを踏襲。
レイヤー構築は `EarthquakeHistoryFillLayerBuilder.buildRegionLayers` / `buildCityLayer` を再利用:

```dart
// 階級ごと (colorJmaIntensity != null のもののみ、orderIndex 昇順に追加して高階級を上に):
//   cityCodes  = tree[class] の全 city.code
//   regionCodes = tree[class] の全 city の region.code のうち、
//                 「その region の最大階級 == class」のもの (事前に region→最大階級を集計)
//   color = intensityColors.fromJmaIntensity(class.colorJmaIntensity!).background.toHexStringRGB()
//   idPrefix = 'eq-history-shindo-db-${class.name}'
//   mode は EarthquakeHistoryMapLayerMode.regionAndCity 相当 (既存 resolver の
//   resolveFillLayerMode を確認し、region+city 両方を出す mode を使う)
```

- [ ] **Step 2: station レイヤーを実装**

`earthquake_history_station_intensity_layer.dart` の GeoJSON 構築 + circle/icon レイヤーを踏襲:

```dart
// feature は tree の全観測点 + unresolvedStations (location != null のみ):
//   color: colorJmaIntensity != null → 震度色 / null → '#9e9e9e' (グレー)
//   iconId: exactJmaIntensity != null → 'JmaIntensity.small.${exact.name}' / それ以外は付与しない
//   sortKey: class.orderIndex
// icon SymbolStyleLayer には filter: ['has', 'iconId'] を付け、iconId の無い観測点は
// circle のみ表示する
// レイヤーID/ソースIDは 'eq-history-shindo-db-station-*' で既存と衝突させない
```

- [ ] **Step 3: map view の配線**

`_MapContent` に `showingDb` を追加し、`showingDb` のとき:

```dart
// ref.watch(shindoDbIntensityTreeProvider(earthquake.eventId)) の AsyncData 時のみ
//   EarthquakeHistoryShindoDbFillLayer / EarthquakeHistoryShindoDbStationLayer を表示。
// 既存の fill/station/estimated レイヤーは表示しない (hypocenterLayer は常に表示)。
// 凡例: EarthquakeHistoryMapLegend に optional な shindoDbTree を追加し、
//   数値階級 (ツリーに存在するもの) + 歴史的階級があれば '不明 (グレー)' 行を表示。
//   既存凡例ファイルの行構造に合わせる。
// _handleTap: showingDb のときは DB ツリーから最寄り観測点を探して
//   showStationPopup(context, stationName: node.name, intensity: class.exactJmaIntensity,
//   lpgmIntensity: null) を呼ぶ。exact が null の階級では popup の表示が欠けるため、
//   showStationPopup に optional な `String? intensityLabel` を追加してラベル表示に
//   フォールバックする (earthquake_history_map_popup.dart を確認して最小変更で)。
// _fitBounds: showingDb のときは DB ツリーの観測点座標 + 震央で bounds を計算。
```

`EarthquakeHistoryDetailsMapView`(公開側)にも `required bool showingDb` を追加し、
Task 9 で渡した値を `_MapContent` へ中継する。

- [ ] **Step 4: 手動確認 → analyze → コミット**

`flutter run` で XML+DB イベントを開き、ソース切り替えで塗り分け・観測点・凡例が入れ替わること、
観測点タップでポップアップが出ること、DB のみイベント(歴史的階級のみを含む)でグレー観測点が
表示されることを確認。

```bash
cd app && dart analyze
git add -A app/lib
git commit -m "feat: 震度DBの地図レイヤー (塗り分け・観測点) を追加"
```

---

### Task 11: asset 取り込み・統合確認・PR 作成

**Files:**
- Modify: `app/assets/parameters/shindo_db_stations.json`(+ `manifest.json` が変わる場合は同時に)
- 全体: `dart format` / `dart analyze` / 全テスト

- [ ] **Step 1: backend 成果物の asset を取り込む**

backend subagent の最終報告に記載されたパスから、`city_code` 付きで再生成された
`shindo_db_stations.json`(と manifest 更新があればそれも)を `app/assets/parameters/` にコピーする。
**まだ成果物が無い場合**: このステップを飛ばし、Step 4 の PR を draft で作成して
本文に「backend PR マージ後に asset を反映」と明記する。

- [ ] **Step 2: 全テスト・整形・解析**

```bash
cd app && dart format lib test && dart analyze
flutter test test/feature/earthquake_history/
flutter test   # 時間があれば全体
```
Expected: 変更起因の失敗ゼロ(analyze は develop 比で増加なし)

- [ ] **Step 3: パフォーマンス確認(compute() 化の要否)**

観測点レコードが多いイベント(例: 東日本大震災 2011-03-11)を DB 表示に切り替え、
切り替え時のジャンク(フレーム落ち)を確認する。体感できるジャンクがある場合のみ、
`buildShindoDbIntensityTree` を `compute()` 化する(構築済み索引 Map のみを isolate に渡す)。
問題なければ何もしない(判断結果を PR 本文に1行記載)。

- [ ] **Step 4: コミット & PR 作成**

```bash
git add -A
git commit -m "chore: city_code 付き震度DB観測点 asset を反映"
git push -u origin feat/shindo-db-intensity-display
gh pr create --repo YumNumm/EQMonitor --base develop \
  --title "feat: 地震履歴詳細に震度データベース表示を統合" \
  --body "<変更概要・スクリーンショット・設計書/計画へのパス・テスト結果。末尾に https://claude.ai/code/session_01MTgm7LTGwiY327MzpFAyC9>"
```

PR 本文には以下を含める: ソース切り替えの3イベント種別ごとの挙動、旧カード削除、
既存 `_cityIdentificationPrefixMap` バグ修正、backend PR への依存(リンク)、
スコープ外(owner 付与等は見送り)。

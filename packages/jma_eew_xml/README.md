# jma_eew_xml

気象庁防災情報 XML の緊急地震速報を読み取る純 Dart のパッケージである。
EQMonitor のアプリやサーバのモデルには依存せず、電文の内容をそのまま型にした `JmaEewTelegram` を返す。
アプリ用のモデルへの変換は利用側（EQMonitor では `JmaEewXmlConverter`）が行う。

| 電文 | `Control/Title` | `JmaEewTelegramKind` |
| --- | --- | --- |
| VXSE43 | 緊急地震速報（警報） | `warning` |
| VXSE44 | 緊急地震速報（予報） | `forecast` |
| VXSE45 | 緊急地震速報（地震動予報） | `seismicMotionForecast` |

緊急地震速報の配信テスト（VXSE42）やリアルタイム震度（VXSE47）など、上記以外の電文は `JmaEewXmlUnsupportedTitleException` になる。
EQRP のフレームのように電文の題名が別にある場合は、`JmaEewTelegramKind.fromTitle` で読む前に振り分けられる。

## 使い方

```dart
import 'package:jma_eew_xml/jma_eew_xml.dart';

const parser = JmaEewXmlParser();
final telegram = parser.parse(xml);
if (telegram.isCanceled) {
  // 取消報。Body は Text だけを持つ。
}
final maxIntensity = telegram.intensityForecast?.maxIntensity;
```

失敗は `JmaEewXmlException` の派生で表す。

- `JmaEewXmlSyntaxException`: XML として読めない（閉じていない要素、DOCTYPE など）。
- `JmaEewXmlStructureException`: 必須の要素がない、値が仕様の値域にない。
- `JmaEewXmlUnsupportedTitleException`: 緊急地震速報の電文ではない。

## 読み方

- 1 回の走査で要素の位置（名前・属性・内容の範囲と親子関係）だけを `Int32List` に記録し、値は読むときに必要な分だけ文字列にする。
- 要素は名前空間の接頭辞を除いた名前で照合する。`Head` と `Body` で既定の名前空間を宣言し直し、`jmx_eb:` の接頭辞も固定ではないため。
- 子要素の順序には依存しない。
- 実体の定義を持ち込ませないため、DOCTYPE は受け付けない。文字参照・定義済み実体参照・CDATA は展開する。
- 値を補わない。M 不明は `JmaEewMagnitude.value == null`、深さ不明は `JmaCoordinate.height == null`、震源要素不明は `JmaEewHypocenter.coordinate == null` になる。

## 電文とモデルの対応

| XML | モデル |
| --- | --- |
| `Control/Status` | `JmaEewTelegram.status` |
| `Control/DateTime` | `JmaEewTelegram.dateTime` |
| `Head/ReportDateTime` | `JmaEewTelegram.reportDateTime` |
| `Head/EventID` | `JmaEewTelegram.eventId` |
| `Head/InfoType` | `JmaEewTelegram.infoType` |
| `Head/Serial` | `JmaEewTelegram.serial`（取消報は取り消した報と同じ番号） |
| `Head/Headline/Text` | `JmaEewTelegram.headlineText`（空なら `null`） |
| `Head/Headline/Information/Item` | `JmaEewTelegram.warningItems`（`LastKind/Code` が `31` なら `hadWarning`） |
| `Body/Earthquake` | `JmaEewTelegram.earthquake` |
| `Body/Earthquake/Condition` | `JmaEewEarthquake.isAssumedHypocenter`（`仮定震源要素`） |
| `Body/Earthquake/Hypocenter/Area/jmx_eb:Coordinate` | `JmaEewHypocenter.coordinate`（ISO 6709、高さは m） |
| `Body/Earthquake/Hypocenter/Accuracy` | `JmaEewHypocenter.accuracy`（`@rank`・`@rank2`） |
| `Body/Earthquake/jmx_eb:Magnitude` | `JmaEewEarthquake.magnitude`（`NaN` は `null`） |
| `Body/Intensity/Forecast/ForecastInt` | `JmaEewIntensityForecast.maxIntensity`（`To` が `over` なら `to == null`） |
| `Body/Intensity/Forecast/Pref/Area` | `JmaEewIntensityForecast.areas` |
| `…/Area/Category/Kind/Code` | `JmaEewForecastArea.isWarning`（1 桁目が `1`）、`isPlum`（2 桁目が `9`） |
| `…/Area/Condition` | `JmaEewForecastArea.isArrived`（`既に主要動到達と推測`） |
| `Body/Text` | `JmaEewTelegram.text`（取消報の本文など） |
| `Body/Comments/WarningComment` | `JmaEewTelegram.warningComment` |
| `Body/NextAdvisory` | `JmaEewTelegram.isLastInfo` |

`JmaEewTelegram.hasWarning` は、取消報でなく、警報電文・見出しの警報対象地域・固定付加文 `0201`・予報区の警報コードのいずれかがあるときに真になる。

根拠は気象庁「地震火山関連 XML 電文解説資料」のⅠ（ヘッダ部）と Ⅱ.21（緊急地震速報）である。

## テスト

```sh
mise exec -- dart test
```

`test/fixtures` の電文は気象庁が公開している防災情報 XML のサンプル電文（2024 年 4 月 17 日の豊後水道の地震）から抜き出した。

## ベンチマーク

```sh
mise exec -- dart run benchmark/jma_eew_xml_parser_benchmark.dart
# AOT
mise exec -- dart compile exe benchmark/jma_eew_xml_parser_benchmark.dart -o /tmp/jma_eew_xml_benchmark
/tmp/jma_eew_xml_benchmark test/fixtures
```

`JmaEewXmlParser.parse` は木の構築と値の取り出しまで、`JmaXmlTreeBuilder.build` は木の構築だけ、`XmlDocument.parse` は比較用に `package:xml` で DOM を作るだけ（値は取り出さない）の時間である。

2026 年 11 月 25 日に Dart 3.14.0（AOT）、Intel Xeon の 4 vCPU 環境で計測した値は次のとおりである。

| 電文 | サイズ | `JmaEewXmlParser.parse` | `JmaXmlTreeBuilder.build` | `XmlDocument.parse` |
| --- | ---: | ---: | ---: | ---: |
| 第1報（予報区なし） | 1.8 KiB | 8.2 µs | 4.9 µs | 68.4 µs |
| 第5報（12 区域） | 8.3 KiB | 42.0 µs | 23.4 µs | 419.8 µs |
| 第17報（41 区域） | 20.8 KiB | 107.3 µs | 60.7 µs | 1132.3 µs |

JIT（`dart run`）では、それぞれ `parse` が 7.0 µs・36.5 µs・90.8 µs だった。値の取り出しまで含めても、`package:xml` で DOM を作るだけの時間の約 1/10 である。

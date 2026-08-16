# 震度DB観測点アイコン表示統一 設計

## 背景

地震履歴詳細マップでは、防災情報XML由来の観測点が `StationDisplayMode.auto` に従い、ズーム閾値未満では最大震度の観測点だけに震度ラベルを表示し、閾値以上では全観測点に表示する。

震度データベース由来の観測点は単一の `iconId` を常に参照しており、この表示要件が適用されていない。XML観測点を `iconIdFull`、`iconIdPlain`、`isMax` と共通の `stationIconImageExpression` へ移行した際、震度DBレイヤーが移行対象から漏れたことが原因である。

## 方針

震度DB観測点にもXML観測点と同じ `stationIconImageExpression` を適用する。震度DB用GeoJSONは各観測点に次のプロパティを持たせる。

- `iconIdFull`: 震度階級ラベル入りアイコン
- `iconIdPlain`: ラベルなしアイコン
- `isMax`: 当該カタログ内で最上位の震度階級か
- `sortKey`: 既存の震度階級表示順

最大階級は、実際に観測点を持つ `tree` と `unresolvedStations` のキーを集約し、`ShindoDbIntensityClass.orderIndex` が最大の階級として求める。固定値や震源レコードへの推測によるフォールバックは行わない。

## アイコンの扱い

現行JMA震度と一致する階級では、既存の `JmaIntensity.small` と `JmaIntensity.smallWithoutText` を再利用する。

旧階級の震度5・6は、ラベル入りでは既存の震度DB専用アイコンを使い、ラベルなしでは対応する `JmaIntensity.fiveUnknown` / `sixUnknown` の `smallWithoutText` を利用する。

震度不明・顕著地震などの歴史的分類は色だけでは分類を区別できない。そのため `iconIdPlain` にもラベル入り専用アイコンを指定し、低ズームでも意味を失わないようにする。

## 表示動作

既定の `StationDisplayMode.auto` では次の表示になる。

- `stationTextZoom` 未満: 最大震度階級だけラベル入り。その他の数値階級はラベルなし
- `stationTextZoom` 以上: 全数値階級をラベル入り
- 歴史的分類: ズームにかかわらず分類ラベルを維持

将来、他の `StationDisplayMode` を呼び出し側から渡す場合も、XMLと震度DBで同じ共通式が適用される。

## 検証

震度DB用GeoJSONビルダーの小さな回帰テストを追加し、最大階級判定とfull/plainアイコンIDの出力を確認する。既存の共通表示式テストとあわせて、XML・震度DBの表示条件が同じ契約に従うことを保証する。

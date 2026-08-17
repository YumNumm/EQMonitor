# EEW 警報地域マッピング修正設計

日付: 2026-08-17
状態: 承認済み

## 目的

EEW の「警報地域」表示と現在地向け警報 overlay で、気象庁区域コードの種類を
正しく対応付ける。初回警報、警報地域の追加、取消を同じ報で即時反映し、
MapLibre レイヤーの initialize / update / dispose 競合を回帰テストで保護する。

## データ契約

backend は DMData の警報区域を次の3段階で保持する。

- `warning.zones`: 地方予報区。例: `9920` 東北
- `warning.prefectures`: EEW の府県予報区。例: `9020` 青森
- `warning.regions`: 地域細分。例: `202` 青森県三八上北

アプリ内の地図データは次の対応とする。

- MapLibre `areaForecastLocalEew` / `JmaMapType.areaForecastLocalEew`
  ↔ `warning.prefectures`
- MapLibre `areaForecastLocalE` / `JmaMapType.areaForecastLocalE`
  ↔ `warning.regions` および `forecastIntensity.regions`

`hadWarning` は DMData の `kind.lastKind.code == '31'` を表し、現在の警報状態ではない。
初回警報と追加直後の区域では `false` になるため、現在警報の抽出条件には使用しない。

## 対象判定

現在警報として扱うイベントは `isWarning == true && !isCanceled` を満たすものに限る。
そのイベントの警報配列に存在する区域は `hadWarning` の値にかかわらず現在報の対象とする。

- ホーム / Live Monitor の「警報地域」塗りつぶし:
  `warning.prefectures` の code を重複排除して使用する。
- EEW 詳細地図の警報表示:
  `warning.prefectures` の code を使用する。
- 現在地向け警報 overlay の候補判定:
  `areaForecastLocalEew` で解決した code と `warning.prefectures` を比較する。
- overlay の警報地方見出し:
  `warning.zones` 全件を code で重複排除し、安定順で表示する。
- 現在地予想震度:
  従来どおり `areaForecastLocalE` と `forecastIntensity.regions` を比較する。

取消報、非警報、警報配列欠損では空集合として扱い、地図 filter を空表示へ更新する。
固定地域や推測値へのフォールバックは行わない。

## 実装構造

地図レイヤー2箇所で共通する区域抽出は、
`feature/eew/data/logic/eew_warning_area_selector.dart` の
`EewWarningAreaSelector` に切り出し、Riverpod で DI する。
selector は外部状態を持たない純粋な処理とし、現在警報イベントの
`warning.prefectures` code を重複なしで返す。

候補選択と表示モデルは既存の責務を維持し、比較対象配列と `hadWarning` 条件だけを
修正する。API モデルの `hadWarning` 自体は履歴情報として残し、名称変更や backend
契約変更は今回の範囲外とする。

## 非同期ライフサイクル

既存の `MapOperationQueueScope` と `latestCodes` の設計を維持する。

- init 中のデータ更新は、レイヤー追加完了直後に最新 code で再更新する。
- update / remove / 再 add はマップ単位の共有キューで登録順に直列化する。
- dispose 後の旧 remove が再 mount 後の add を消さない順序を保証する。
- 空集合は常に空表示 filter を設定し、filter 未指定による全域表示を禁止する。

## テスト

次を自動テストで固定する。

1. 初回警報で全区域が `hadWarning == false` でも府県予報区 code を返す。
2. `warning.regions` と `warning.prefectures` の code が異なる場合、後者だけを採用する。
3. 後続報で追加された府県予報区を同じ報で追加する。
4. 取消・非警報・警報情報欠損を除外する。
5. 複数イベントの府県予報区 code を重複排除する。
6. overlay 候補判定が `warning.prefectures` を使い、`hadWarning` に依存しない。
7. overlay 見出しが `warning.zones` の初回警報地域も含める。
8. init 中更新、dispose → 再 mount、連続更新で最終 filter が残る。
9. 空配列で全域を描画しない。

## 文書更新

既存の overlay 設計書と knowledge にある `hadWarning` / `warning.regions` の誤った
現在警報判定を訂正する。修正完了後は
`docs/todo/950_eew_warning_region_fill_mapping.md` を削除する。

# カスタム通知 地域選択改善 設計

## 背景と目的

現状はregion・市区町村コードが表示され、余白も大きい。市区町村一覧は `jma_code_table.areaInformationCity` を直接参照するため観測点名が混ざり、市区町村のかな検索と地図選択もない。

コード表示と過剰な余白を除き、正しいregion・市区町村を漢字またはふりがなで検索できるようにする。さらに、日本全域からregion、市区町村へ段階的にフォーカスする地図選択を追加し、初期化・選択更新・レイヤー更新・disposeの競合で古い処理が反映されない構造にする。

地域別最大震度マップは参考実装として調査したが、将来、市区町村表示をデフォルトにする予定があるため、今回は変更しない。通知API、backend、既存スロットの一括移行、現在地から選択する新導線も対象外とする。

## 地域カタログ

通知スロットの `regionId` は、現在地更新と同じ `areaForecastLocalEew` のコードを使う。region名・かなは `JmaCodeTableParameter.codeTables.areaForecastLocalEew` を正本とする。市区町村コード・正しい名前・かなは `EarthquakeParameter.prefectures[].regions[].cities[]` を正本とし、`jma_code_table.areaInformationCity` の名前は表示に使わない。

通知用EEW regionと市区町村は次のように結合する。

1. `jma_code_table.areaInformationCity` から観測点コード→親EEW regionコードをindex化する。
2. `EarthquakeParameter` の各市区町村について、配下の観測点コードをindexへ照合する。
3. 得られたEEW regionへ、正しい市区町村コード・名前・かなを登録する。
4. regionと市区町村コードの組で重複排除する。複数regionが実データから得られた場合は各regionへ登録し、1件へ丸めない。
5. 対応不能な市区町村は推測配置せず診断ログへ記録する。

構築結果は一覧検索と地図filterが共有する不変カタログとし、UIごとの再計算を避ける。

## 一覧と検索

現在の「region一覧→region全域または市区町村一覧」という2段階導線を維持し、region一覧のAppBarに地図アイコンを追加する。

- region・市区町村コードのsubtitleを削除する。
- 検索欄の外側余白を上下4、左右12程度へ縮める。
- 行の密度を上げつつ、48 logical pixel以上のタップ領域を維持する。
- region行は名前と遷移アイコン、市区町村行は正しい名前と追加アイコンだけを表示する。
- 市区町村画面先頭の「○○ 全域」と、追加中の二重送信防止・progressは維持する。

検索はWidgetから分離した純粋ロジックを共有する。名前とかなをUnicode NFKCで正規化した後、小文字化、全空白除去、カタカナからひらがなへの変換を行い、部分一致させる。NFKC実装が未導入なら依存は `flutter pub add` で追加する。空文字は元の順序の全件、かな欠損時は名前だけを対象とし、読みを固定値で補わない。

## 地図選択

地図は独立した全画面ページとし、初期cameraで日本全域を表示する。

### 全国

- `areaForecastLocalEew` 境界を表示し、市区町村境界は表示しない。
- 下部に「地図をタップして地域を選択」と表示する。
- JMAポリゴンの内包判定でEEW regionを解決する。海上・データ外では選択を変えず短い案内を出す。

### regionフォーカス

- 選択regionのboundsへpadding付きで `fitBounds` し、輪郭を強調する。
- カタログから当該regionの市区町村コードだけを抽出し、その境界だけ表示する。base mapの全市区町村境界もページ内filterで抑止する。
- 下部にregion名、「この地域全域を選択」、市区町村タップの案内を表示する。

### 市区町村選択

- `areaInformationCity` のタップ結果をコードでカタログへ照合し、フォーカス中regionに属する場合だけ選択する。
- 選択市区町村を線幅4程度・高opacityで強調する。別市区町村タップで選択を置き換える。
- 下部に正しい市区町村名と「この市区町村を選択」を表示する。

AppBarのresetは選択と境界filterを解除し、日本全域へ戻す。確定値は、region全域なら `regionId/regionName`、市区町村ならそれらに `cityCode/cityName` を加え、既存の `NotificationSlotsNotifier.addRegionMutation` へ渡す。

## 状態・非同期・cleanup

地図状態は全国、region、市区町村の3状態を持つpage-scoped auto-dispose notifierで管理し、MapControllerはMap Widgetのライフサイクル内だけで保持する。

style、JMAポリゴン、地域カタログがすべて揃うまで操作を受け付けない。準備後のタップは読み込み済みindexで解決し、タップごとにproviderをawaitしない。

camera操作には世代番号を付ける。選択変更・reset・disposeで世代を進め、実行時または完了時に世代が異なる処理は状態へ反映しない。dispose時はMapController参照もクリアする。

レイヤー追加、base filter更新、選択filter更新、cleanupは `MapOperationQueueScope` のキューで直列化する。選択変更はlayer再作成ではなく `updateFilter` を基本とする。cleanupは追加layerを個別に削除しbase filterを復元する。一操作の失敗で後続cleanupを止めず、破棄済みstyleの失敗は診断ログへ残す。

## エラー表示

- parameter、JMA map、styleの読み込み中はadaptive progress、失敗時は短い説明と再試行を表示する。
- 検索0件は対象に応じた空表示にする。市区町村0件でもregion全域は選べる。
- HTTP 402は既存Pro案内、それ以外の追加失敗は短いSnackBarにする。例外全文を本文へ出さない。
- 解決不能な地図タップは現在選択を保持する。欠損を固定コード、ランダム値、別地域への推測で補わない。

## テスト

- カタログ結合、重複排除、複数region、対応不能データを単体テストする。
- 漢字、ひらがな、カタカナ、全半角、空白を含む検索を単体テストする。
- 全国→region→市区町村→region→全国の遷移とregion/city filter式を単体テストする。
- 古い世代のcamera/tap完了とdispose後の処理が状態を更新しないことを単体テストする。
- ID非表示、正しい市区町村名、かな検索、空・loading・error、二重送信防止、地図下部カードをWidgetテストする。
- 実機またはSimulatorで全国初期表示、regionフォーカス、対象regionだけの市区町村線、選択太線、連続タップ、reset直後のタップ、即時closeを確認する。

## 受け入れ条件

1. region・市区町村一覧にID/codeがなく、余白を縮めても48 logical pixel以上のタップ領域がある。
2. 観測点名ではなく正しい市区町村名が表示され、漢字・ふりがな・ひらがな／カタカナで検索できる。
3. 地図は日本全域から始まり、タップしたEEW regionへフォーカスする。
4. regionフォーカス中は当該regionの市区町村境界だけが表示され、市区町村タップ後は選択境界が太線になる。
5. region全域または市区町村を確定でき、連続操作・rebuild・reset・disposeで古い処理が選択やcameraを上書きしない。
6. 地域別最大震度の実装には変更がない。
7. 関連テスト、format、analyzeが `mise exec --` 経由で成功する。

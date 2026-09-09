# App Intents の情報整合性と音声呼び出しを改善する

2026-09-10調査、一部修正。Issue: https://github.com/YumNumm/EQMonitor/issues/1794 。拡張buildと共有テストの成功だけでは正常動作とは判断しない。

## 優先して修正・検証する項目

1. 【今回修正】地域震度を「最大震度」として返している。
   - `Shared/EarthquakeDisplayItem.swift`の地域検索用initは地域震度をmaxIntensityへ格納。
   - `AppIntentExtension/EarthquakeEntity.swift`はこれを「最大震度」プロパティへ変換。
   - 公開APIのprefecture/13で、event_id=20260830001711は地域震度1・全国最大震度4。
     現実のレスポンスでも差があるため、最大震度と対象地域震度を別フィールドにする。
   - このケースをEntity変換の自動テストで固定する。
2. 保存位置の鮮度と、Snippet更新時の位置を明示する。
   - `GetEarthquakesNearMeIntent`はApp Groupの保存地域を読み、GPS取得はしない。
   - `app_group_settings_writer.dart`は取得一時失敗時に旧地域を維持する。
   - 保存時刻・期限判定がなく、Snippetの見出しにも実際の地域名が出ない。
   - Snippet更新は初回のregionIDを再利用し、移動後も同じ地域を照会する。
   - 不明・古い位置を現在地と断定しない仕様と回帰テストを用意する。
3. Intent戻り値とSnippetの二重取得を整理する。
   - 主Intentでitems取得後、SnippetIntentが同条件で再取得する。
   - 途中で新しい地震が入ると、後続アクションの値とカードが一致しない可能性。
   - 同じスナップショットを表示するか、更新の意味を明示した契約にする。
4. 音声呼び出しのアプリ名を確認する。
   - 拡張のCFBundleDisplayNameと生成NLUのapplicationNameはAppIntentExtension。
   - 「EQMonitorで最新の地震を確認」が実機で解決されるかを確認する。
   - 失敗時は表示名・Provider配置・本体との登録を見直す。

## 追加の改善項目

- `EarthquakeEntityQuery.entities(for:)`が常に空で、IDから地震を復元できない。
  即時の値渡し全体が壊れるとは断定しないが、保存・再解決・OpenIntent連携には不足。
- Entityが訓練・試験状態を落とす。カードの状態バッジだけに依存せず戻り値にも公開する。
- Entityの日時・M・深さ・震度はすべて表示用String。型付きデータを追加する。
- `EarthquakeSnippetIntent.plan`は不正地域IDを全国へフォールバックする。
  nilの全国指定と壊れた指定を区別し、後者は明示エラーにする。
- 地域指定Pro判定は主Intentのみ。Snippet直接実行・更新時の判定を統一する。
- 通信失敗は主Intent/Fetcherからそのままthrowされ、APIError.fromによる正規化を通らない。
  オフライン・デコード失敗を含め、Siri向けの短い日本語案内を検証する。
- 【今回修正】主IntentにProvidesDialogを追加。訓練・試験を先に読み上げ、全体最大震度と地域震度を区別する。
- Intentのperform・Entity復元・Snippet入力検証の専用テストがない。

## 検証記録

`docs/knowledge/20260910_app_intents_verification_and_siri_ai.md`を参照。
追加実装の記録は `docs/knowledge/20260910_siri_dialog_search.md` を参照。

## Flutterとの照合で判明した追加項目

- 【今回修正】Swift APIの`IntensityPartial`に`max_intensity_class`がなく、過去の震度5・6や非数値分類を保持できなかった。元スキーマへ追加し、生成器で対象型を再生成した。
- Flutterの履歴時刻表示も`originTimePrecision`を使わず分まで表示する。粗い歴史時刻を精度以上に表示しない対応を別途行う。今回の音声応答は精度を尊重する。
- 既存Widget/Snippetの`OpenURLIntent`はカスタムスキームを指定しているが、Appleの契約はUniversal Link限定。実機で既存導線を検証し、対応リンクへ移行する。今回の検索はRunnerの`UIApplication.open`で開く。
- Swift APIの元スキーマには生成済みコードの旧Live Activity操作が5件含まれない。全生成で削除されるため、契約の整理が必要。今回の限定生成スクリプトは恒久的な全生成手順の代替ではない。
- 検索連携は地域名の候補選択まで。自然文の日付・震度・複合条件の解釈は未実装。

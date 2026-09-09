# 履歴一覧のタブレット・折りたたみ表示

## 対象と配置

- 地震履歴一覧と緊急地震速報一覧は `HistoryAdaptiveView` を使用する。
- 通常は利用可能幅840dp以上で左右に分割し、一覧幅を30%・320〜440dpに収める。
- 幅が狭い場合は一覧または選択中の詳細だけを表示する。
- 一覧の要素は破棄せず、選択・スクロール・絞り込みを幅変更時にも保持する。
- 詳細はイベントIDでキーを付ける。同じイベントの幅変更では保持し、別イベントでは再作成する。
- 既存の詳細ルートからの直接表示も引き続き利用できる。

## ヒンジの扱い

- `DisplayFeatureSubScreen.avoidBounds` が返す領域を対象にする。
- `PaneViewportObserver` で実表示領域のグローバル原点を計測し、画面座標をローカル座標へ変換する。
- 計測が古い間は描画・入力・セマンティクスを抑制する。
- 縦ヒンジでは左右、横ヒンジでは上下に配置する。端末の縦横で方向を決めない。
- 左右分割は一覧320dp以上・詳細360dp以上、上下分割は幅600dp以上・一覧高280dp以上・詳細高360dp以上を条件とする。
- 両側に収まらない場合は面積の広い片側を利用し、その領域の幅に応じて表示を決める。
- 幅0の折り目も扱うため、交差判定に `Rect.overlaps` だけを使わない。
- ライブモニターは計測部品のみを共有する。ライブモニター独自の分割方向の挙動は変更していない。

## ペイン内の表示

- `HistoryPane` は一覧と詳細に別の `PrimaryScrollController` を与える。
- ローディング中のListViewも対象。共有すると複数のScrollPositionが接続され得る。
- MediaQueryのサイズと余白は各ペインに合わせる。キーボード領域の縮小は外側のScaffoldが担当する。
- 地図上の詳細シートは `BasicModalSheet(expandToPane: true)` とし、横長でも幅を再度半分にしない。
- EEW履歴では各報をシートに表示し、初期表示は最新報とする。
- EEWイベントの選択変更・詳細を閉じる操作では履歴再生を停止する。
- 選択枠は元の震度色を塗り替えず、輪郭とSemanticsで表現する。

## 検証

ユーザー指定により回帰テストの追加・実行は行わない。
静的解析は `app/` から次の形式で行う。

```sh
mise exec -- dart analyze --fatal-infos lib/core/component/layout \
  lib/feature/earthquake_history/ui/earthquake_history_page.dart \
  lib/feature/eew_history/ui lib/feature/eew/ui/page/eew_details_by_event_id_page.dart
```

実機の表示確認は `docs/todo/500_history_tablet_visual_check.md` に記載する。

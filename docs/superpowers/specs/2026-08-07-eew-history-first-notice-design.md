# EEW履歴ページ初回注意ダイアログ 設計

- 作成日: 2026-08-07
- 対象: Flutter アプリ (`app/`)
- ステータス: 設計確定

## 背景・目的

ホームから「緊急地震速報の履歴」(`EewHistoryPage`) を開けるようになった。初回訪問時に、一覧の意味を誤解しないよう注意を表示する。

伝えたいこと:

1. 一覧は過去に発表された緊急地震速報の履歴であり、現在の揺れや警報の状況を示すものではない
2. 各項目は、そのイベントの最終報における予想最大震度・震源・マグニチュードなどを表示している

## 確定要件

| 項目 | 決定 |
|---|---|
| UI | Material 3 `AlertDialog`（`showDialog`） |
| 表示タイミング | ページ入場直後（履歴リストのロードと並行。背後に一覧が見える） |
| 既読 | 一度「OK」で閉じたら端末に永続化し、以降は出さない |
| 閉じ方 | 「OK」ボタンのみ（外側タップ・戻るでは閉じない） |
| 再表示導線 | 今回なし（設定からの再表示はスコープ外） |
| 参考実装 | 推計震度注意（`EstimatedIntensityNoticeDialog` / `EstimatedIntensityNoticeShown`） |

## 非スコープ

- キャンセル報・誤報・精度限界の詳細説明
- 発表中 EEW ピン留めセクションについての言及
- バナー／ボトムシート形式
- バージョン更新時の再表示
- 設定画面からの再表示

## アーキテクチャ

既存の推計震度注意ダイアログと同型にする。

```
app/lib/feature/eew_history/
├── data/notifier/
│   └── eew_history_notice_shown_notifier.dart
└── ui/
    ├── eew_history_page.dart                    # 入場時 useEffect で表示
    └── components/modal/
        └── eew_history_notice_dialog.dart
```

### 永続化

- `SharedPreferencesKey` に `eewHistoryNoticeShown('eew_history_notice_shown')` を追加
- アクセスは `SharedPreferencesDataSource` 経由のみ
- Notifier `EewHistoryNoticeShown`:
  - `build()`: prefs から bool を読む（未設定は `false`）
  - `markShown()`: メモリを `AsyncData(true)` にしてから prefs に `true` を書く

### UI

`EewHistoryNoticeDialog`:

- `static Future<void> show(BuildContext context)` で `showDialog`
- `barrierDismissible: false`
- 戻る操作でも閉じない（`PopScope(canPop: false)` など）
- タイトル・本文・「OK」アクション

`EewHistoryPage`:

- `eewHistoryNoticeShownProvider` を watch
- `AsyncData(false)` のときだけ `useEffect` + `addPostFrameCallback` でダイアログ表示
- prefs 未ロード（`AsyncLoading` / `AsyncError`）の間は出さない（誤表示・チラつき防止）
- ダイアログを閉じた後に `markShown()`（推計震度注意と同じ順序）
- 履歴リストの取得・描画はダイアログ表示と独立して進める

## ダイアログ文言

**タイトル:** 緊急地震速報の履歴について

**本文（箇条書き）:**

- この一覧は過去に発表された緊急地震速報の履歴です。現在の揺れや警報の状況を示すものではありません。
- 各項目は、そのイベントの最終報における予想最大震度・震源・マグニチュードなどを表示しています。

**ボタン:** OK

## データフロー

```
EewHistoryPage 入場
  → watch eewHistoryNoticeShownProvider
  → AsyncData(false)?
      Yes → post-frame で EewHistoryNoticeDialog.show
           → ユーザーが OK
           → markShown()（prefs に true）
      No / Loading / Error → ダイアログなし
  （並行）eewListDataSourceProvider で履歴ロード
```

## エラーハンドリング

- prefs 読取失敗（`AsyncError`）: ダイアログを出さない（誤って毎回出すより安全側）
- prefs 書込失敗: メモリ上は既読（`AsyncData(true)`）のままにし、同一セッションでの再表示を防ぐ。必要なら talker でログ

## テスト

- Notifier: 未設定 → `false`、`markShown` 後 → `true` かつ prefs に保存
- Dialog: 「OK」で閉じること（Widget テスト）
- Page（任意）: 未既読なら post-frame で表示、既読なら表示しない

## 成功条件

- 端末で初めて履歴ページを開くと注意ダイアログが出る
- 「OK」以外では閉じられず、「OK」後は再入場しても出ない
- ダイアログ表示中も背後で履歴リストのロードが進む

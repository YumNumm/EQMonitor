# Overview

EQMonitor は、日本国内向けの地震・防災情報を扱う Flutter モバイルアプリです。UI は「緊急時でも読み取りやすいこと」を最優先にしつつ、Google 純正アプリのような落ち着いたダーク UI を基調にします。Material 3 をベースにしながらも Android に寄りすぎず、iOS でも違和感の少ない、静かで信頼感のある見た目を採用します。

このデザインシステムは、アプリ全体の設定画面、オンボーディング、権限導線、地図まわりのシート、空状態、情報カードに適用します。見た目のキーワードは、`dark`, `calm`, `rounded`, `layered`, `readable`, `mobile-first` です。

## Visual direction

- ベースはダークテーマ。背景は黒に近いが完全な純黒にはしない。
- 面は 1 枚のフラットな黒ではなく、`background`, `surface`, `raised surface`, `card surface` の階層で整理する。
- 大見出しは大胆に、本文は抑制的に、補助文は静かに見せる。
- カード、ボトムシート、入力面は強めの角丸を使い、親しみと可読性を両立する。
- 1 画面 1 目的を徹底し、主要操作は常に 1 つだけ強調する。
- 地震情報の色はブランド色より優先される。震度・警報・危険度を示す色はドメイン固有ルールに従い、通常 UI の装飾色として流用しない。

# Colors

## Core palette

- `background.default`: `#0F141A`
  - アプリ全体の基底面。長時間見ても眩しくない深い青みのある黒。
- `background.subtle`: `#131A21`
  - 全画面系オンボーディングやイラスト面の背景。
- `surface.default`: `#171E26`
  - 通常の `Scaffold` やシート本体。
- `surface.raised`: `#1D2630`
  - セクションやグループ面。
- `surface.card`: `#232D38`
  - 設定カード、リストアイテム、アカウントカード。
- `surface.emphasis`: `#2B3744`
  - 選択中・強調中のカード背景。
- `outline.soft`: `#3A4654`
  - 区切り線やカード境界。
- `outline.strong`: `#506073`
  - フォーカス、強めの境界、選択輪郭。

## Brand and semantic colors

- `brand.primary`: `#4D8DFF`
  - アプリの主要アクセント。CTA、選択状態、主要トグルに使う。
- `brand.primaryContainer`: `#24344A`
  - トーナルボタン、選択済みカード、補助ラベル背景。
- `brand.secondary`: `#8FB7FF`
  - 情報補助、軽いアクセント。
- `brand.tertiary`: `#91D4C8`
  - 穏やかな補助色。成功や正常系の近傍で使う。
- `status.success`: `#63D39B`
- `status.warning`: `#F4C75E`
- `status.danger`: `#FF7A7A`
- `status.info`: `#78B8FF`

## Text colors

- `text.primary`: `#F3F6FA`
  - 見出し、主要本文。
- `text.secondary`: `#C4CCD7`
  - 補助説明、サブタイトル。
- `text.tertiary`: `#98A5B5`
  - ラベル、プレースホルダ、補足。
- `text.inverse`: `#0F141A`
  - 明るいボタン面上の文字。

## Usage rules

- 主要アクションは 1 画面につき 1 つだけ `brand.primary` 系で強調する。
- `surface.card` は設定カードやグループボックスの標準とし、背景との差を明確にする。
- 危険・警告を示す `status.danger` と `status.warning` は、通常の装飾用途には使わない。
- 地震の震度色、津波、EEW 警報色などの防災ドメイン色は、ここで定義するブランド色より優先して維持する。
- 地図上のオーバーレイやライブ情報では、可読性を優先し、半透明色を多用しすぎない。

# Typography

## Font families

- Primary UI font:
  - `Google Sans Flex`
  - fallback: `Noto Sans JP`
- Monospace / code / numeric emphasis:
  - `Google Sans Code`
  - fallback: `Noto Sans JP`

## Global typography rules

- アプリ内のすべての見出し、本文、ラベル、ボタン文言、設定項目名は `Google Sans Flex` を第一選択とする。
- 日本語グリフが必要な箇所では `Noto Sans JP` をフォールバックとして利用する。
- コード、ビルド番号、観測値、時刻、緯度経度、ID、ログ、固定幅で揃えたい数値には `Google Sans Code` を利用する。
- 日本語本文では極端な letter spacing を使わない。標準は `0.0`、英字主体のラベルのみわずかに正方向を許容する。
- 緊急時の読みやすさを優先し、過剰な light weight は使わない。基本は `400`, `500`, `600`, `700` の範囲で構成する。
- 行間は詰めすぎない。日本語を含む本文は十分な line height を確保する。

## Type scale

- `displayLarge`
  - use: フルスクリーンの歓迎画面、重大導線の大見出し
  - size: `40`
  - line height: `48`
  - weight: `600`
- `displayMedium`
  - use: オンボーディング上部、印象的な 2 行見出し
  - size: `36`
  - line height: `44`
  - weight: `600`
- `headlineLarge`
  - use: ページタイトル、シートの大見出し
  - size: `32`
  - line height: `40`
  - weight: `600`
- `headlineMedium`
  - use: セクション主見出し
  - size: `28`
  - line height: `36`
  - weight: `600`
- `headlineSmall`
  - use: ボトムシートやカード群のタイトル
  - size: `24`
  - line height: `30`
  - weight: `600`
- `titleLarge`
  - use: 画面上部タイトル、重要カードのタイトル
  - size: `22`
  - line height: `28`
  - weight: `600`
- `titleMedium`
  - use: セクションカードの見出し、リストグループタイトル
  - size: `18`
  - line height: `24`
  - weight: `600`
- `titleSmall`
  - use: ListTile タイトル、フォーム見出し
  - size: `16`
  - line height: `22`
  - weight: `600`
- `bodyLarge`
  - use: 標準本文、説明文
  - size: `16`
  - line height: `24`
  - weight: `400`
- `bodyMedium`
  - use: 補助本文、カード内説明
  - size: `14`
  - line height: `20`
  - weight: `400`
- `bodySmall`
  - use: 注記、サブコピー、メタ情報
  - size: `13`
  - line height: `18`
  - weight: `400`
- `labelLarge`
  - use: ボタン、セグメント、主要ラベル
  - size: `14`
  - line height: `20`
  - weight: `500`
- `labelMedium`
  - use: バッジ、補助ラベル、フィルタ
  - size: `12`
  - line height: `16`
  - weight: `500`
- `labelSmall`
  - use: キャプション、極小メタ情報
  - size: `11`
  - line height: `14`
  - weight: `500`

## Numeric and code styles

- `monoLarge`
  - family: `Google Sans Code`
  - size: `16`
  - line height: `22`
  - weight: `500`
  - use: 緯度経度、ID、設定値、観測数値
- `monoMedium`
  - family: `Google Sans Code`
  - size: `14`
  - line height: `20`
  - weight: `500`
  - use: ログ、時刻、バージョン、診断情報
- `monoSmall`
  - family: `Google Sans Code`
  - size: `12`
  - line height: `16`
  - weight: `500`
  - use: チップ内メタ情報、小さな数値ラベル

## Typography usage rules

- 日本語の長文を `all caps` 的に扱わない。
- 重要情報はサイズだけでなく weight とコントラストで見せる。
- 情報密度が高い画面でも、`bodyMedium` 未満の本文を主テキストにしない。
- 震度、時刻、座標など比較対象になる情報は `Google Sans Code` で揃える。
- 1 つの画面内で font family をむやみに混在させない。通常は `Google Sans Flex`、数値強調だけ `Google Sans Code` に切り替える。

# Spacing

## Base grid

- ベースグリッドは `4dp`。
- 標準余白スケール:
  - `xs`: `4`
  - `sm`: `8`
  - `md`: `12`
  - `lg`: `16`
  - `xl`: `20`
  - `2xl`: `24`
  - `3xl`: `28`
  - `4xl`: `32`

## Layout rules

- スマートフォン画面の左右パディングは `16` を標準、没入感を出したい画面は `20` を使う。
- 設定カードやシート内コンテンツの内部余白は `20` を基本とする。
- セクション間の縦間隔は `16`。大きな画面ブロックの分離は `24` 以上を使う。
- タイトルと本文の間は `4` から `8`。
- カード内の操作群と説明文の間は `12` から `16`。
- 画面下部の主要 CTA の上には `24` 以上の余白を確保する。

## Shape

- 標準カード半径: `24`
- 強調カード半径: `28`
- ボタン半径: `20` から `24`
- シート上端半径: `28`
- 小さなバッジ、トグル背景、補助ピルは `999` の完全ピルを許容する

# Components

## App bars and sheet headers

- 画面上部は詰め込みすぎず、`戻る or 閉じる`, `タイトル`, `必要なら 1 個の補助アクション` に留める。
- ボトムシートの先頭にはドラッグハンドルを置いてよい。
- ボトムシート見出しは、大見出し + 1 行から 2 行の説明 + 右上の閉じるボタン、の構成を標準にする。
- ヘッダー内の補助ラベルは `labelMedium` を使い、`brand.primaryContainer` または `surface.emphasis` 上に置く。

## Cards and grouped surfaces

- 設定、情報グループ、オンボーディング下部アカウント面などは、面ごとに独立したカードとして見せる。
- カード背景は `surface.card`、必要に応じて `surface.emphasis` で選択状態を見せる。
- カード境界は濃すぎない 1px 相当の `outline.soft` を使う。
- 影は最小限。ダークテーマでは elevation より面の色差で階層を出す。

## Settings rows

- 設定行は `title + subtitle + trailing control` を基本構成とする。
- タイトルは `titleSmall`、補助文は `bodySmall` を基本とする。
- 行全体をタップ可能にしつつ、スイッチやナビゲーションアイコンも明確に見せる。
- 1 行に情報を詰め込みすぎない。2 行説明は許容する。

## Accordion sections

- 大きな設定群はアコーディオンを標準にする。
- 同時に展開するのは原則 1 セクションのみ。新しいセクションを開いたら他を閉じる。
- セクションヘッダーは `48dp` 以上のタップ可能領域を確保する。
- 開閉アイコンは回転で状態変化を示し、開閉本体はサイズ変化で表現する。
- 開閉状態が重要な画面では、将来的に状態保持を検討してよい。

## Buttons

- 主要 CTA は `FilledButton` 相当の明るい面で、画面内に 1 つを原則とする。
- 二次 CTA は `FilledButton.tonal` または `OutlinedButton` を使う。
- 破壊的操作は赤い塗りボタンを乱用せず、通常はトーナルまたはテキストボタンで確認導線を挟む。
- ボタン内文字は `labelLarge` を使う。
- プラットフォーム差を自然に吸収したい操作部品では [`adaptive_platform_ui`](https://pub.dev/packages/adaptive_platform_ui) を優先し、`AdaptiveButton` を第一候補とする。

## Segmented controls and chips

- モード切り替え、表示種別切り替え、フィルタ切り替えにはセグメント UI を使う。
- 最大 3 から 4 選択肢までを推奨する。それ以上はメニューや別画面に分離する。
- 選択中は背景と文字色の両方で状態を示す。
- セグメント UI は `SegmentedButton` や `CupertinoSlidingSegmentedControl` を個別に直接使い分けるのではなく、原則として [`adaptive_platform_ui`](https://pub.dev/packages/adaptive_platform_ui) の `AdaptiveSegmentedControl` を利用する。

## Dialogs, feedback, and platform-adaptive controls

- すべての `AlertDialog` / `CupertinoAlertDialog` 相当の確認ダイアログは、原則として [`adaptive_platform_ui`](https://pub.dev/packages/adaptive_platform_ui) の `AdaptiveAlertDialog` を利用する。
- 一時的な通知は `SnackBar` を直接使わず、原則として `AdaptiveSnackBar` を利用する。
- 長押しメニューや文脈依存アクションは `AdaptiveContextMenu` を優先する。
- 日付選択は `AdaptiveDatePicker`、時刻選択は `AdaptiveTimePicker` を標準とする。
- チェックボックス、スライダー、ラジオ、セグメント、スイッチなど、プラットフォーム差が体験に影響しやすい入力部品は `AdaptiveCheckbox`, `AdaptiveSlider`, `AdaptiveRadio`, `AdaptiveSegmentedControl`, `AdaptiveSwitch` を優先する。
- テキスト入力は `TextField` / `CupertinoTextField` / `TextFormField` を直接使い分けるのではなく、原則として `AdaptiveTextField` と `AdaptiveTextFormField` を利用する。
- フォームのグルーピングには `AdaptiveFormSection` を使い、iOS では `CupertinoFormSection` らしいまとまり、Android では Material 的なカードグループとして見せる。
- 例外的に純正 Material / Cupertino ウィジェットを直接使う場合は、`adaptive_platform_ui` で満たせない要件があるときに限る。

## Onboarding and welcome screens

- 1 画面 1 メッセージを徹底する。
- 上部は大見出し、中央はイラストまたは象徴的なビジュアル、下部はアカウント面または主要 CTA の構成を基本とする。
- 説明文は短く、読み切れる長さに抑える。長文の規約説明は CTA 付近に二次情報として置く。
- アカウント選択面や許諾カードは、ヒーローセクションとは別のカードに分離して読みやすくする。

## Permission and opt-in screens

- 権限要求は OS ダイアログの前に、なぜ必要かを人間向けの文で説明する。
- 防災・位置情報・通知のような重要権限では、ベネフィットを先に示す。
- 主要 CTA は 1 つ、副次的な「あとで」導線は控えめに置く。

## Loading states

- 読み込み中の表示には [`skeletonizer`](https://pub.dev/packages/skeletonizer) を利用する。
- ローディング中は、最終的に表示されるレイアウトに近い skeleton を出し、読み込み完了後のレイアウトジャンプを最小限に抑える。
- カード、設定行、リスト、情報ブロックは、可能な限り実 UI をそのまま skeletonize する。
- 画面全体を単一の `CircularProgressIndicator` だけで済ませるのは、初期起動や極めて短い待機を除き避ける。
- 空状態とローディング状態を混同しない。データが未取得なのか、取得結果が空なのかを UI で明確に分ける。
- 画像、地図、ネットワークリソースなど fake data で崩れやすい要素は、必要に応じて `Skeleton.replace` などの annotation を使って安全に置き換える。
- Skeleton の色と shimmer はダークテーマの階層を壊さないよう控えめにし、情報色や警告色と競合させない。

## Empty, passive, and informational states

- 空状態は冷たい無表示にしない。1 つの説明文と、可能なら次の行動を用意する。
- イラストやシンボルを使う場合も、過剰に賑やかにしない。
- 地図やライブデータの文脈では、空状態より「現在データなし」の説明を優先する。

## Data-heavy and map-adjacent UI

- 地図上の補助シートや設定シートは、地図を邪魔しすぎない短い情報単位で構成する。
- 数値、時刻、座標、状態コードは `Google Sans Code` を優先する。
- 地図レイヤー設定はセクション化し、関連するトグルやセグメントをカード単位で束ねる。

# Motion

- 基本アニメーション時間:
  - micro interaction: `150ms`
  - accordion / content reveal: `200ms`
  - sheet / panel transition: `240ms` から `280ms`
- 標準カーブは `easeOutCubic` または Material 3 に近い減速系カーブを使う。
- 状態変化は派手な演出ではなく、位置、サイズ、透明度、回転の最小限で伝える。
- 緊急情報を扱う画面では、注意を奪う不要なアニメーションを入れない。

# Flutter mobile notes

- Flutter 実装では、通常テキストを `Google Sans Flex`、日本語フォールバックを `Noto Sans JP` とする前提で `TextTheme` を構成する。
- 数値・コード系スタイルは `Google Sans Code` を明示的に適用する。
- タイポグラフィ、色、角丸、余白は `ThemeData` と `ThemeExtension` で一元化する。
- iPhone の Safe Area、Android のシステム UI、テキストスケール拡大を前提に、固定高さに依存しない。
- 設定行、カード、シートは `ListTile`, `Card`, `BottomSheet`, `SegmentedButton` をベースにしてもよいが、余白と shape はこのドキュメントに合わせて調整する。
- 読み込み中 UI は [`skeletonizer`](https://pub.dev/packages/skeletonizer) を標準採用とし、`Skeletonizer`, `Skeletonizer.sliver`, annotation 群を用いて既存レイアウトから skeleton を生成する。
- Skeleton 用の fake data が必要なケースでは、本番レイアウトを崩さない最小限のダミーデータを用意し、`NetworkImage` などは `Skeleton.replace` や条件分岐で安全に扱う。
- プラットフォーム適応が必要な UI 部品は [`adaptive_platform_ui`](https://pub.dev/packages/adaptive_platform_ui) を標準採用とする。特に `AdaptiveAlertDialog`, `AdaptiveCheckbox`, `AdaptiveSlider`, `AdaptiveSegmentedControl`, `AdaptiveRadio`, `AdaptiveSnackBar`, `AdaptiveContextMenu`, `AdaptiveDatePicker`, `AdaptiveTimePicker`, `AdaptiveTextField`, `AdaptiveTextFormField`, `AdaptiveFormSection` を優先する。
- `AlertDialog`, `CupertinoAlertDialog`, `SnackBar`, `showDatePicker`, `showTimePicker`, `TextField`, `TextFormField`, `CupertinoTextField` を新規実装で直接使うのは原則避け、adaptive なラッパーを優先する。
- `adaptive_platform_ui` を使う画面では、日付・時刻・ボタン文言のローカライズが崩れないよう localization delegates を正しく設定する。

# Do's and Don'ts

## Do

- 大見出しで画面目的を明確にする
- ダーク面の階層差で情報構造を見せる
- カード単位で情報を束ねる
- 主要 CTA を 1 つに絞る
- 日本語の読みやすさを優先して十分な行間を取る
- 数値や時刻は `Google Sans Code` で揃えて比較しやすくする
- 防災情報の色はブランド装飾より優先する

## Don't

- 画面内に複数の強いアクセント色を混在させない
- 純黒背景と純白文字だけで構成しない
- 1 行に情報を詰め込みすぎない
- 日本語本文を小さすぎる文字で長く表示しない
- Android 専用の見た目に寄せすぎて iOS で浮く UI にしない
- 危険色を通常の装飾や選択状態に使わない
- 防災ドメイン色をブランドカラーへ無理に寄せない

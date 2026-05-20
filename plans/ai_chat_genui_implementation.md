# AI チャット (GenUI / A2UI) 実装計画

## ゴール

EQMonitor に LLM ベースのアシスタント機能を追加し、ユーザが自然言語で地震情報を探索できるようにする。AI の応答は単なるテキストではなく、`flutter/genui` パッケージを介して **A2UI プロトコル** で動的にレンダリングされた Flutter ウィジェット（地震カード、リスト、震源マップ等）として表示する。

### 対象ユースケース（最初の PR）

1. **自然言語による地震履歴検索** — 「先週東北で起きた M5 以上の地震を見せて」「最大震度 5 弱以上の最近の地震は？」
2. **地震ごとの近隣震央／過去地震の探索** — 詳細画面から「この震源付近で過去に発生した地震は？」と聞ける

スコープ外（将来）: EEW の解説、リアルタイム情報の AI 連携、防災行動アドバイス、課金連携。

---

## 制約 / リスクの明記

| 項目 | 内容 |
|------|------|
| **`genui` パッケージのステータス** | **0.9.1 / Alpha**。将来破壊的変更あり。`pubspec.yaml` でバージョン固定する |
| **Firebase AI Logic は使わない** | ユーザ指示。Anthropic / Gemini / OpenAI を直接アプリから叩く |
| **API キーの保管** | `flutter_secure_storage`（既にアプリに導入済み）。デバッグメニュー経由のみ。**正式リリース時はサーバプロキシ要検討** |
| **System Prompt のサイズ** | `PromptBuilder.chat(catalog: ...)` は ~3〜5k トークンの system prompt を生成。チャットごとにコスト発生 |
| **モデル選定** | 小さいモデルは A2UI JSON を壊しやすい。Claude Sonnet / Gemini 2.5 Pro / GPT-4o 以上を推奨し、デフォルトとする |
| **デバッグ画面からのみ起動** | 一般ユーザには非公開。kDebugMode / Beta ビルドでのみ表示 |

---

## アーキテクチャ概要

```
┌───────────────────────────────────────────────────┐
│  AiChatPage  (HookConsumerWidget)                 │
│   ├─ ChatMessageView / Surface ウィジェット表示    │
│   └─ TextField + Send                              │
└───────────────────────────────────────────────────┘
                 │
                 ▼ Conversation.sendRequest(ChatMessage)
┌───────────────────────────────────────────────────┐
│  Conversation (genui)                              │
│   ├─ SurfaceController                             │
│   └─ Transport = A2uiTransportAdapter              │
│         onSend: (msg) ──▶ LlmClient.chat(...)      │
│         addChunk(text) ◀── stream                  │
└───────────────────────────────────────────────────┘
                 │
                 ▼ プロバイダ抽象
┌───────────────────────────────────────────────────┐
│  LlmClient (interface)                             │
│   ├─ AnthropicLlmClient                            │
│   ├─ GeminiLlmClient                               │
│   └─ OpenAiLlmClient                               │
│      tool_use / functionCall を捌き、               │
│      EqToolRunner にディスパッチ                    │
└───────────────────────────────────────────────────┘
                 │
                 ▼
┌───────────────────────────────────────────────────┐
│  EqToolRunner                                     │
│   ├─ searchEarthquakes(...)                       │
│   ├─ getEarthquakeDetail(eventId)                 │
│   └─ searchByEpicenter(code)                      │
│   ※ 中身は EarthquakeHistoryRepository を呼ぶだけ  │
└───────────────────────────────────────────────────┘
```

### A2UI と tool calling の役割分担（重要）

- **tool calling** … LLM がデータを取りに行く手段。`EarthquakeHistoryRepository` の呼び出し。
- **A2UI** … LLM がそのデータをどう表示するか。`createSurface` 等の JSON コマンドを **テキストストリーム内** に流す。

両者は同じ LLM ターンで同居する。各プロバイダごとに「tool_use 検知 → 関数実行 → 結果を会話に戻す → 続きのテキストを A2UI として addChunk」というループを書く必要がある。

---

## ディレクトリ構成

```
app/lib/feature/ai_chat/
├── data/
│   ├── model/
│   │   ├── ai_provider.dart            # enum: anthropic / gemini / openai
│   │   ├── ai_credentials.dart         # freezed: apiKey, model, provider
│   │   └── eq_tool_definitions.dart    # JSON-schema による tool 定義
│   ├── llm/
│   │   ├── llm_client.dart             # abstract interface
│   │   ├── anthropic_llm_client.dart
│   │   ├── gemini_llm_client.dart
│   │   └── openai_llm_client.dart
│   ├── tool/
│   │   └── eq_tool_runner.dart         # EarthquakeHistoryRepository に委譲
│   ├── repository/
│   │   └── ai_credentials_repository.dart  # flutter_secure_storage
│   └── provider/
│       ├── ai_credentials_provider.dart
│       ├── llm_client_provider.dart
│       └── ai_conversation_provider.dart
└── ui/
    ├── ai_chat_page.dart               # メインチャット画面
    ├── ai_chat_settings_page.dart      # APIキー・モデル選択
    └── component/
        ├── chat_input.dart
        └── chat_surface_list.dart      # Surface を順に表示
```

`packages/` には切り出さず、`app/lib/feature/ai_chat/` 配下で完結させる（実験段階のため）。

---

## 依存関係の追加（`app/pubspec.yaml`）

```yaml
dependencies:
  genui: ^0.9.1                # AlphaなのでCaret許容範囲は要観察
  # LLMプロバイダ: SDK は薄いラッパで十分なため、まずはDio直叩きの自前実装で行う
  # （将来 langchain_dart 等への切り替え余地を確保）
```

LLM プロバイダ用 SDK は **採用しない**。理由:
- 各 SDK は依存が重く、ストリーミング tool 呼び出しの挙動も微妙に異なる
- EQMonitor は既に `dio` を使っており、HTTP の自前ラップが現実的
- 3社の最小 API（chat completion + streaming + tool_use）だけサポートすれば足りる

---

## フェーズ別実装

### Phase 0: パッケージ追加 / 動作確認 (~30 分)

1. `app/pubspec.yaml` に `genui: ^0.9.1` を追加
2. `melos bootstrap` → ビルド通ることを確認
3. `app/lib/feature/ai_chat/ui/ai_chat_page.dart` に最小骨格（送信→`A2uiTransportAdapter`にダミーチャンクを流す）を作り、Surface 表示確認

### Phase 1: API キー・モデル設定 UI (~1h)

4. `AiCredentials`（freezed: provider, apiKey, model）を `flutter_secure_storage` に保存／復元する `AiCredentialsRepository` を追加（K-NET 認証の実装パターンに準拠）
5. `AiChatSettingsPage` を実装。3 プロバイダごとに APIキー・モデル名（プルダウン: Anthropic = `claude-sonnet-4-5-20250929` ほか / Gemini = `gemini-2.5-pro` ほか / OpenAI = `gpt-4o`, `gpt-5` ほか）を入力可能
6. デフォルトプロバイダを保存

### Phase 2: LlmClient 抽象と Anthropic 実装 (~3h)

7. `LlmClient` interface 定義
   ```dart
   abstract class LlmClient {
     Stream<String> chat({
       required String systemPrompt,
       required List<LlmMessage> history,
       required List<LlmTool> tools,
       required Future<String> Function(String name, Map<String, dynamic> args) onToolCall,
     });
   }
   ```
8. `AnthropicLlmClient` を実装（`https://api.anthropic.com/v1/messages` SSE ストリーミング, tool_use ブロック検知 → onToolCall → tool_result 送信 → 続き）
9. `GeminiLlmClient` / `OpenAiLlmClient` は **スタブ** として骨格のみ作成し、UI からは選択可能にしておく（実装は次回 PR）

### Phase 3: ツール定義と EqToolRunner (~1h)

10. `eq_tool_definitions.dart` で 3 つのツールを JSON-schema 定義
    - `search_earthquakes(magnitude_gte?, intensity_gte?, origin_time_gte?, origin_time_lte?, limit?)`
    - `get_earthquake_detail(event_id)`
    - `search_by_epicenter(epicenter_code)`
11. `EqToolRunner` が `EarthquakeHistoryRepository` の既存メソッドへ委譲。結果は JSON 文字列にして LLM に返す（最大件数を 10 程度に絞り、トークンを節約）

### Phase 4: GenUI 統合 (~2h)

12. `Catalog`: **basic catalog のみ** （Card, Column, Text, Image, List, Button）でスタート。カスタムウィジェットは Phase 6
13. `PromptBuilder.chat(catalog: ..., systemPromptFragments: [...])` で system prompt を生成
    - `systemPromptFragments` に EQMonitor 特化の追加指示
      - 「あなたは EQMonitor のアシスタント。日本の地震情報の検索・解説を行う」
      - 「データ取得には常に提供されたツールを使うこと」
      - 「結果は createSurface で地震カードのリストとして表示すること」
      - 「震源コードがわかったら近隣震央検索を提案すること」
14. `Conversation` + `SurfaceController` を Riverpod で provide。`AiChatPage` で Surface を `ListView` 表示

### Phase 5: デバッグ画面からの起動 (~30 分)

15. ルート追加: `/settings/debug/ai-chat` (`DebugAiChatRoute`)
16. `debug_page.dart` に「AI チャット (実験)」ListTile を追加。タップで `AiChatSettingsPage` を経由（APIキー未設定なら）または直接 `AiChatPage` へ
17. 地震詳細画面 (`earthquake_history_details_page.dart`) にも debug-only の「AI に質問」ボタンを追加（既知の eventId を初期メッセージに含めて起動）

### Phase 6 (任意): カスタム CatalogItem (~3h)

未着手で OK。次回 PR の候補:
- `EarthquakeCard` — 震度アイコン、震源、M、深さの Flutter ウィジェットで描画
- `EpicenterMiniMap` — MapLibre の小さいマップで震央位置を表示

basic catalog のみでも 文字＋カードで十分意味のあるデモになる。

---

## テスト方針

- `EqToolRunner` のユニットテスト（Repository をモック）
- `AnthropicLlmClient` の SSE 行パーサユニットテスト（実際の Anthropic レスポンスサンプルを fixture 化）
- 結合テストは手動 — デバッグメニューから起動して以下を確認:
  1. 「最大震度5強以上の最近の地震を5件見せて」→ 地震カードリストが Surface として描画される
  2. 詳細画面から「この震源付近の過去地震を見せて」→ 関連地震が表示される

---

## CI / コード生成

- Freezed クラス追加 → `melos run generate`
- `dart analyze` を通す
- `dart format` を通す
- 単体テストを `test/feature/ai_chat/` に追加し `melos run test:flutter` を通す

---

## PR 構成

ブランチ: `feature/ai-chat-genui`（現在の worktree から派生）  
ベース: `develop`（YumNumm リポジトリ）  
タイトル: `feat(ai-chat): AI チャット (GenUI/A2UI) を試験導入 - デバッグメニュー経由`

PR Description には以下を明記:
- 実験機能であること（kDebugMode / Beta のみ）
- API キーは端末ローカル保存、リリース前にサーバプロキシ化が必要
- 対応プロバイダは Anthropic のみフル実装、Gemini/OpenAI はスタブ
- スクリーンショット添付

---

## 想定工数

| Phase | 工数 |
|-------|------|
| 0. パッケージ追加 | 0.5h |
| 1. 認証 UI | 1h |
| 2. LlmClient (Anthropic) | 3h |
| 3. EqToolRunner | 1h |
| 4. GenUI 統合 | 2h |
| 5. デバッグ画面導線 | 0.5h |
| **合計 (MVP)** | **約 8h** |
| 6. カスタムウィジェット | +3h |

---

## オープンクエスチョン

1. **モデルのデフォルト** — Anthropic は `claude-sonnet-4-5-20250929` を推奨で良いか？
2. **会話履歴の永続化** — 今 PR ではメモリ上のみ（画面離脱で消える）でよいか？永続化するなら `shared_preferences` でよい？
3. **コスト保護** — トークン上限・1日のリクエスト数制限を入れるか？（Phase 0 では入れない想定）
4. **デバッグ画面起動位置** — 既存の「Playground」枠に統合するか、独立した ListTile にするか？（独立を想定）

これらは実装中に「現実的にこちらで進めます」と判断してよい場合は明示してください。

---

## ユーザの承認が必要な確認事項

- 上記スコープ（Anthropic フル + Gemini/OpenAI スタブ）でよいか
- API キーを端末保存する方針を許容するか
- ディレクトリ構成 `app/lib/feature/ai_chat/` でよいか
- PR は `feature/ai-chat-genui` ブランチ・タイトル案でよいか

承認をもらえたら Phase 0 から順に実装に入ります。

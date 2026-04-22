# F-net カタログページの実装

## 背景

`feature/nied/ui/fnet/fnet_catalog_page.dart` には `// TODO: 実装` のコメントがあり、データ取得が空のリストを返すスタブ状態になっている。
NIED の F-net（Hi-net 広帯域地震観測網）の波形カタログは AQUA カタログ（同じ NIED ページの隣タブ）に相当する機能であり、AQUA の実装を参考に実装できると思われる。

## 現状

- `fnet_catalog_page.dart:52-53`: `// TODO: 実装` → `return <FnetEvent>[];`
- 画面は「データがありません」を表示するだけ。
- `FnetEvent` 型は定義済み（`nied_api_client` パッケージ）。
- `AquaCatalogPage` は同様の構造で実装済みであり、参考実装として使える。

## やること

1. **API クライアントを確認する**
   - `packages/nied_api_client` に F-net カタログ取得エンドポイントがあるか確認する。
   - なければ `fnet_catalog_page.dart` の実装前に API クライアント側から追加する。

2. **Riverpod プロバイダを追加する**
   - `FnetCatalogNotifier`（または Provider）を `AquaCatalogNotifier` に倣って実装する。
   - ページネーションが必要な場合は `AquaCatalog` と同じ無限スクロールパターンを採用する。

3. **UI を実装する**
   - `AquaCatalogPage` の構造（日付フィルタ、テーブル、詳細ダイアログ）を F-net 向けに調整する。
   - ローディングは `Skeletonizer`、空状態は `AppEmptyState`（→ `078_empty_states.md`）を使う。

4. **テスト**
   - API レスポンスのモック + プロバイダのユニットテストを追加する。

## 参照

- `app/lib/feature/nied/ui/aqua/aqua_catalog_page.dart`（参考実装）
- `app/lib/feature/nied/ui/fnet/fnet_catalog_page.dart`（スタブ）
- `packages/nied_api_client/`（API クライアント）

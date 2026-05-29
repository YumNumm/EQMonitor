# Spec ① 契約 drift テスト — quarantine findings

- 日付: 2026-05-30
- 関連: `2026-05-30-spec1-contract-drift-test-design.md`、テスト `packages/eqmonitor_api/test/contract_drift_test.dart`

## 背景

契約 drift テスト導入時、86 fixtures 中 **74 件がパス、12 件が失敗**した。
失敗 12 件はすべて **Valibot 未検証の fixtures**（`contract.test.ts` は 14 default のみ検証）:
named fixtures、または未検証エンドポイント（start/changelog/parameters）の default。

**Valibot 検証済みの 14 default は全てパス**（earthquake/eew/tsunami/telegram/intensity/epicenter）。
→ アプリモデルは openapi.json に忠実。失敗は「未検証 fixtures が厳密スキーマに準拠していない」
ことに由来する（stub fixture 側の不備）。

スポットチェック（openapi.json と突き合わせ、live backend 不要）の結論:
- **changelog `title`**: openapi `ChangelogSection.title` は required string。fixture が欠落 → stub 不備。
- **tsunami `body`**: openapi `TsunamiTelegramItem.body` は required・非null。fixture が null → stub 不備。
- いずれも **swagger_parser の nullability バグではない**。Dart モデルは正しい。

## 方針

- 74 件を **gate（回帰ロック）** に固定。
- 12 件は **quarantine**（テストで `skip:` し本 doc を参照）。CI を赤にしない。
- quarantine の境界は「default/named」ではなく「**現在判明している乖離**」。

## quarantine 一覧（12件）

| fixture file | endpoint | 乖離フィールド | 推定原因 |
|--------------|----------|----------------|----------|
| `get__v1_changelog__with-entries.json` | GET /v1/changelog | `title` (null/欠落) | stub 不備（openapi: required string） |
| `get__v1_start.json` | GET /v1/start | `required_versions` (Map vs List) | stub or 未検証スキーマ乖離 |
| `get__v1_start__force-update.json` | GET /v1/start | `required_versions` | 同上 |
| `get__v1_start__maintenance.json` | GET /v1/start | `required_versions` | 同上 |
| `get__v2_earthquake_eventId__canceled.json` | GET /v2/earthquake/:eventId | ネスト `event_id` (null) | canceled シナリオで null 化。要確認（多分 stub） |
| `get__v2_parameters_type.json` | GET /v2/parameters/:type | `status` 系 | 未検証。union jma_code_table |
| `get__v2_parameters_manifest__with-parameters.json` | GET /v2/parameters/manifest | `source_urls` (null vs List) | stub 不備 |
| `get__v2_telegram_id__vtse41.json` | GET /v2/telegram/:id | `body`/`warning` | stub 不備 |
| `get__v2_telegram_id__vzse40.json` | GET /v2/telegram/:id | 同上 | stub 不備 |
| `get__v2_telegram_id__with-comments.json` | GET /v2/telegram/:id | 同上 | stub 不備 |
| `get__v2_tsunami_tsunamiId__with-telegrams.json` | GET /v2/tsunami/:tsunamiId | `body` (null vs 非null) | stub 不備（openapi: required） |
| `get__v2_tsunami_byeventid_eventId__with-telegrams.json` | GET /v2/tsunami/by-event-id/:eventId | `body` (null) | stub 不備 |

## follow-up

1. **stub fixtures の修正**（backend）: 上記の named fixtures を実レスポンス形に合わせる。
   修正後、quarantine から外して gate に昇格。
2. **オラクルの拡張**（推奨・本質的）: `backend/api/api-stub/test/contract.test.ts` を
   named fixtures / 未検証エンドポイントにも拡張して Valibot 検証する。これにより
   それらが信頼できる drift オラクルになり、本テストでも gate に昇格できる。
3. `required_versions` / `parameters/:type` は実スキーマと突き合わせて、stub・openapi の
   どちらが古いかを確定する。

# Seismicity Backend Contract Pin Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use `superpowers:subagent-driven-development` for this task and request task review before commit.

**Goal:** 親repositoryのBackend gitlinkを、アプリがすでに利用している震源catalog manifest/PMTiles revision契約を含むcommitへ復旧する。

**Architecture:** Backend実装自体は変更せず、PR #954のmerge commit `0e520aa1`へgitlinkを進める。親側の生成済み`eqmonitor_api`が持つ`query_revision`/`expected_revision`とBackend OpenAPIを照合し、gitlinkだけの独立Stacked PRにする。

**Tech Stack:** Git submodule / pnpm 11 / Vitest / OpenAPI / generated Dart client

---

### Task 1: Restore the catalog-bearing Backend revision

**Files:**
- Modify: `backend` gitlink only

- [ ] `git -C backend merge-base --is-ancestor 93848cd5 0e520aa1`が成功し、fast-forward可能な復旧であることを確認する。
- [ ] `git -C backend switch --detach 0e520aa1`でsubmoduleを固定する。
- [ ] `service/hypocenter-catalog`、`GET /v2/hypocenters/manifest`、`query_revision`、`expected_revision`が固定commitに存在することを確認する。
- [ ] Backend submodule内に変更がなく、親repositoryの差分がgitlink 1件だけであることを確認する。

### Task 2: Verify contract parity

**Files:**
- Verify: `backend/api/api/openapi.json`
- Verify: `packages/eqmonitor_api/lib/src/models/archives.dart`
- Verify: `packages/eqmonitor_api/lib/src/clients/hypocenters_api_client.dart`

- [ ] Backend OpenAPIのarchiveに`query_revision`、hypocenter searchに`expected_revision`がrequired/optionalの意図どおり存在することを確認する。
- [ ] Dart clientの`Archives.queryRevision`とsearch methodの`expectedRevision`へ対応していることを確認する。
- [ ] Backend依存が利用可能なら、次を実行する。

```bash
cd backend
mise exec -- pnpm --filter @eqmonitor-backend/hypocenter-catalog exec vitest run \
  src/pmtiles/archive-planner.test.ts \
  src/pmtiles/generator.test.ts \
  src/pmtiles/validator.test.ts
mise exec -- pnpm --filter @eqmonitor-backend/api exec vitest run \
  test/hypocenter/hypocenter-routes.test.ts \
  test/hypocenter/manifest-datasource.test.ts
```

- [ ] 依存取得や実行環境でtest不能の場合は成功扱いにせず、PRへ`NOT RUN`と静的照合結果を記録する。
- [ ] `git --no-pager diff --submodule=log develop...HEAD`で無関係な親repository差分がないことを確認する。


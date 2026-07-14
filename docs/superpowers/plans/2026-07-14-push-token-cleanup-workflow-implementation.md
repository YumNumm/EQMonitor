# Push Token Cleanup Workflow Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 30日以上更新されていないtokenを毎日03:30 JSTにArgo CronWorkflowで削除し、全実行結果をSlackへ通知する。

**Architecture:** Backend計画で作成したcleanup CLIをnotification-resolverイメージから起動し、そのJSON結果をArgo global output parameterへ保存する。`onExit`は同じイメージ内のテスト済みSlack notifier CLIを成功・失敗で呼び分ける。Webhookはnamespace内Secretのみから取得する。

**Tech Stack:** Argo Workflows, Helm, Kubernetes, TypeScript, Vite, Vitest, Slack Incoming Webhook, yq

## Global Constraints

- client planとbackend lifecycle planを完了・pushした後にこのplanを実行する。
- Backend lifecycle planを先に完了し、`dist/cleanup-device-tokens.mjs`が存在すること。
- scheduleは`30 3 * * *`、timezoneは`Asia/Tokyo`。
- `concurrencyPolicy: Forbid`、`startingDeadlineSeconds: 300`、失敗時retryは2回。
- 成功、削除0件、cleanup失敗、Slack失敗をWorkflow上で区別できること。
- Slack Webhook URLをGit、Helm values、Pod logs、Workflow parametersへ出さない。
- productionは有効、developはデフォルト無効。
- 運用フローを`docs/knowledge/20260714_device_token_cleanup_workflow.md`へ記録し、コミット・pushする。

---

### Task 1: Tested Slack Report CLI

**Files:**
- Create: `backend/service/notification-resolver/src/cli/notify-device-token-cleanup.ts`
- Create: `backend/service/notification-resolver/test/cli/notify-device-token-cleanup.test.ts`
- Modify: `backend/service/notification-resolver/vite.config.ts`
- Modify: `backend/service/notification-resolver/package.json`

**Interfaces:**
- Produces executable: `node dist/notify-device-token-cleanup.mjs`.
- Consumes env: `SLACK_WEBHOOK_URL`, `WORKFLOW_NAME`, `WORKFLOW_NAMESPACE`, `WORKFLOW_STATUS`, optional `CLEANUP_REPORT`, optional `WORKFLOW_FAILURES`.
- Produces Slack JSON using `fetch`; exits 0 only for a 2xx response.

- [ ] **Step 1: Write failing success/failure report tests**

Test an exported `runDeviceTokenCleanupNotification` with injected fetch:

```ts
const response = await runDeviceTokenCleanupNotification({
  webhookUrl: 'https://hooks.slack.test/token',
  workflowName: 'device-token-cleanup-abc',
  workflowNamespace: 'eqmonitor-tokyo-production',
  workflowStatus: 'Succeeded',
  cleanupReport: successReport,
  workflowFailures: undefined,
  send: sendMock,
});
expect(response).toBe(0);
expect(sendMock).toHaveBeenCalledWith(
  'https://hooks.slack.test/token',
  expect.objectContaining({ method: 'POST' }),
);
expect(JSON.stringify(sendMock.mock.calls[0][1])).toContain('apnsPushToStart');
```

Add tests for zero deletion counts, Failed status with `WORKFLOW_FAILURES`, missing webhook, Slack HTTP 500, and malformed cleanup JSON. Missing/malformed input must return exit 1 without calling Slack or logging secrets.

- [ ] **Step 2: Verify RED**

Run: `cd backend && mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver test -- test/cli/notify-device-token-cleanup.test.ts`

Expected: FAIL because notifier CLI does not exist.

- [ ] **Step 3: Implement report validation and Slack blocks**

Validate the success report with Valibot, including timestamp strings and non-negative integer counts. Build a concise Block Kit payload with workflow identity, phase, duration, cutoff, and all deletion counts. Never include token values, database URL, or webhook URL.

```ts
const response = await send(webhookUrl, {
  method: 'POST',
  headers: { 'content-type': 'application/json' },
  body: JSON.stringify(payload),
});
if (!response.ok) {
  throw new Error(`Slack returned HTTP ${response.status}`);
}
```

The process adapter reads env, parses cleanup JSON only for Succeeded status, writes one secret-free status line, and assigns `process.exitCode`.

- [ ] **Step 4: Add Vite entry and verify build**

Add `'notify-device-token-cleanup': 'src/cli/notify-device-token-cleanup.ts'` beside existing named entries, and package script `notify:device-token-cleanup`.

Run focused test and `mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver build` from `backend/`.

Expected: PASS and `dist/notify-device-token-cleanup.mjs` exists.

- [ ] **Step 5: Commit and push backend**

```bash
git -C backend add service/notification-resolver
git -C backend commit -m "feat: トークン削除Slackレポートを追加"
git -C backend push origin main
git add backend
git commit -m "chore: Backend参照を更新"
```

### Task 2: Helm CronWorkflow Template

**Files:**
- Create: `backend/deploy/k8s/charts/eqmonitor/templates/device-token-cleanup-cronworkflow.yaml`
- Modify: `backend/deploy/k8s/charts/eqmonitor/values.yaml`
- Modify: `backend/deploy/k8s/values/tokyo/production.yaml`
- Modify: `backend/deploy/k8s/values/tokyo/develop.yaml`
- Create: `backend/deploy/k8s/charts/eqmonitor/test/device-token-cleanup-cronworkflow.sh`

**Interfaces:**
- Produces: `CronWorkflow/device-token-cleanup`.
- Consumes image: `notificationResolver.image.tag` with cleanup and notifier entries.
- Consumes secrets: `eqmonitor-secrets/POSTGRES_CONNECTION_STRING`, `device-token-cleanup-slack/webhook-url`.

- [ ] **Step 1: Write a failing rendered-manifest test**

The shell test renders production and develop manifests and uses `mise exec -- yq` assertions. Required production assertions include:

```bash
test "$(yq 'select(.kind == "CronWorkflow" and .metadata.name == "device-token-cleanup") | .spec.schedule' "$prod")" = '30 3 * * *'
test "$(yq 'select(.kind == "CronWorkflow" and .metadata.name == "device-token-cleanup") | .spec.timezone' "$prod")" = 'Asia/Tokyo'
test "$(yq 'select(.kind == "CronWorkflow" and .metadata.name == "device-token-cleanup") | .spec.concurrencyPolicy' "$prod")" = 'Forbid'
```

Also assert `onExit: notify`, cleanup command, retry limit 2, DB Secret, Slack Secret, history limits 3, and no CronWorkflow in develop output.

- [ ] **Step 2: Verify RED**

Run: `cd backend && bash deploy/k8s/charts/eqmonitor/test/device-token-cleanup-cronworkflow.sh`

Expected: FAIL because the template is absent.

- [ ] **Step 3: Add values contract**

```yaml
deviceTokenCleanup:
  enabled: false
  suspend: false
  schedule: '30 3 * * *'
  slackSecret:
    name: device-token-cleanup-slack
    key: webhook-url
  resources:
    requests: { cpu: 50m, memory: 128Mi }
    limits: { cpu: 500m, memory: 512Mi }
```

Set `enabled: true` in production and `enabled: false` in develop.

- [ ] **Step 4: Implement cleanup template**

Use existing seismicity CronWorkflow metadata and GC conventions. The cleanup template runs:

```yaml
command: [sh, -ec]
args:
  - node dist/cleanup-device-tokens.mjs | tee /tmp/cleanup-report.json
outputs:
  parameters:
    - name: cleanup-report
      globalName: device-token-cleanup-report
      valueFrom:
        path: /tmp/cleanup-report.json
```

Set `DATABASE_URL` from `eqmonitor-secrets/POSTGRES_CONNECTION_STRING`. Use `retryStrategy.limit: '2'` and `retryPolicy: OnFailure`.

- [ ] **Step 5: Implement onExit templates**

```yaml
- - name: notify-success
    when: '{{workflow.status}} == Succeeded'
    template: slack-success
- - name: notify-failure
    when: '{{workflow.status}} != Succeeded'
    template: slack-failure
```

Both templates use `node dist/notify-device-token-cleanup.mjs`. Inject `SLACK_WEBHOOK_URL` via `secretKeyRef`; pass workflow metadata/status as non-secret env. Only success references `{{workflow.outputs.parameters.device-token-cleanup-report}}`. Failure passes `{{workflow.failures}}` and must work without cleanup output.

- [ ] **Step 6: Verify GREEN and lint chart**

```bash
cd backend
bash deploy/k8s/charts/eqmonitor/test/device-token-cleanup-cronworkflow.sh
mise exec -- helm lint deploy/k8s/charts/eqmonitor -f deploy/k8s/values/tokyo/production.yaml
mise exec -- helm lint deploy/k8s/charts/eqmonitor -f deploy/k8s/values/tokyo/develop.yaml
```

Expected: render test and both lint commands PASS.

- [ ] **Step 7: Commit and push backend**

```bash
git -C backend add deploy/k8s
git -C backend commit -m "feat: トークン削除CronWorkflowを追加"
git -C backend push origin main
git add backend
git commit -m "chore: Backendデプロイ参照を更新"
```

### Task 3: Slack Secret and Operational Knowledge

**Files:**
- Generate: `backend/deploy/k8s/charts/eqmonitor/templates/sealed-device-token-cleanup-slack.yaml`
- Create: `docs/knowledge/20260714_device_token_cleanup_workflow.md`

**Interfaces:**
- Documents production Secret provisioning and manual verification.
- Consumes no secret value in Git.

- [ ] **Step 1: Write the operational document**

Include and execute these commands, with the real webhook supplied only through the shell environment:

```bash
export SLACK_WEBHOOK_URL='https://hooks.slack.com/services/...'
kubectl -n eqmonitor-tokyo-production create secret generic device-token-cleanup-slack \
  --from-literal=webhook-url="$SLACK_WEBHOOK_URL" \
  --dry-run=client -o json \
  | mise exec -- kubeseal \
      --controller-name sealed-secrets-controller \
      --controller-namespace kube-system \
      --format yaml \
  > backend/deploy/k8s/charts/eqmonitor/templates/sealed-device-token-cleanup-slack.yaml
```

The generated SealedSecret is strict-scoped to `eqmonitor-tokyo-production`; commit only its encrypted form. Verify presence after Argo CD sync without printing the value:

Wrap the generated manifest with `{{- if .Values.deviceTokenCleanup.enabled }}` and `{{- end }}` so the production-scoped Secret is not rendered by the develop release. Add a render-test assertion that develop output contains neither the CronWorkflow nor this SealedSecret.

```bash
kubectl -n eqmonitor-tokyo-production get secret device-token-cleanup-slack \
  -o jsonpath='{.data.webhook-url}' | base64 -d | wc -c
```

Include manual execution:

```bash
argo submit --from cronwf/device-token-cleanup \
  -n eqmonitor-tokyo-production --watch
argo logs @latest -n eqmonitor-tokyo-production
```

Include checks for three deletion counts, Slack receipt, failure retry, and rollback by setting `deviceTokenCleanup.suspend: true`.

- [ ] **Step 2: Validate document safety**

Run: `rg -n "hooks\.slack\.com/services/[A-Z0-9]+" docs/knowledge/20260714_device_token_cleanup_workflow.md`

Expected: no match; only the ellipsis example exists.

Run: `git --no-pager diff --check`

Expected: no whitespace errors.

- [ ] **Step 3: Commit and push knowledge**

```bash
git add docs/knowledge/20260714_device_token_cleanup_workflow.md
git -C backend add deploy/k8s/charts/eqmonitor/templates/sealed-device-token-cleanup-slack.yaml
git -C backend commit -m "chore: Slack通知Secretを暗号化"
git -C backend push origin main
git add backend
git commit -m "docs: トークン削除Workflow運用手順を追加"
git push origin develop
```

### Task 4: Workflow End-to-End Verification

**Files:**
- Modify only files required by test, render, or documentation findings from Tasks 1-3.

**Interfaces:**
- Verifies the deployable Workflow; produces no new API.

- [ ] **Step 1: Re-run notifier tests and build**

```bash
cd backend
mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver test -- test/cli/cleanup-device-tokens.test.ts test/cli/notify-device-token-cleanup.test.ts
mise exec -- pnpm --filter @eqmonitor-backend/notification-resolver build
test -f service/notification-resolver/dist/cleanup-device-tokens.mjs
test -f service/notification-resolver/dist/notify-device-token-cleanup.mjs
```

Expected: all commands PASS.

- [ ] **Step 2: Re-run render assertions**

```bash
cd backend
bash deploy/k8s/charts/eqmonitor/test/device-token-cleanup-cronworkflow.sh
mise exec -- helm template eqmonitor deploy/k8s/charts/eqmonitor \
  -f deploy/k8s/values/tokyo/production.yaml > /tmp/eqmonitor-production.yaml
mise exec -- yq 'select(.kind == "CronWorkflow" and .metadata.name == "device-token-cleanup")' \
  /tmp/eqmonitor-production.yaml
```

Expected: exactly one CronWorkflow document with cleanup and onExit templates.

- [ ] **Step 3: Verify no secrets in Git diff**

```bash
git -C backend --no-pager diff --check
git --no-pager diff --check
git -C backend --no-pager diff | rg -n "hooks\.slack\.com/services/"
git --no-pager diff | rg -n "hooks\.slack\.com/services/"
```

Expected: diff checks pass and both webhook searches have no matches.

- [ ] **Step 4: Commit and push verification fixes**

```bash
git -C backend add service/notification-resolver deploy/k8s
git -C backend commit -m "test: トークン削除Workflowを検証"
git -C backend push origin main
git add backend docs/knowledge/20260714_device_token_cleanup_workflow.md
git commit -m "chore: トークン削除Workflow検証を反映"
git push origin develop
```

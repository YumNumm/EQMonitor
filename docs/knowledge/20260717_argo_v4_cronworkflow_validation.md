# Argo Workflows v4 の CronWorkflow 検証

Argo Workflows v4 の `CronWorkflow` は、スケジュールを `spec.schedules` の
リストで定義する。単一スケジュールでも旧 `spec.schedule` は使用しない。

```yaml
spec:
  schedules:
    - '30 3 * * *'
```

テンプレートの global output parameter を参照する場合、v4 の strict lint で
解決できる canonical 形式を使用する。

```yaml
value: '{{io.argoproj.workflow.v1alpha1.outputs.parameters.cleanup-report}}'
```

Helm の描画結果は `.yaml` 拡張子の一時ファイルに保存して検証する。
拡張子がない一時ファイルは `argo lint` の対象として認識されない。

```bash
manifest=$(mktemp --suffix=.yaml)
mise exec -- helm template eqmonitor deploy/k8s/charts/eqmonitor \
  --values deploy/k8s/values/tokyo/production.yaml >"$manifest"
mise exec -- argo lint --offline --strict --kinds=cronworkflows "$manifest"
rm -f "$manifest"
```

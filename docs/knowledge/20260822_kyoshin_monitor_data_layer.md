# 強震モニタ data 層の依存方向

生命に関わる表示時刻・公開遅延を扱う。固定値フォールバックや `effectiveXxx` のような曖昧な算出 getter は置かない。

## ディレクトリ

```text
app/lib/feature/kyoshin_monitor/
  ui/{page,components}
  data/{model,logic,repository,data_source,notifier,provider}
```

`data/flow/` は画面遷移が必要になるまで作らない。

## 依存は下向きのみ

```text
ui            → notifier, provider
notifier      → repository, provider, logic
provider      → notifier, logic（I/O・状態保持なし）
logic         → model のみ（Ref なし、可変フィールドなし）
repository    → data_source / Prefs / Isolate
model         → 他 model / enum のみ
```

Notifier は DataSource を直接呼ばない。

## 処理経路

```text
TimeSync → ImageDelay → TargetTime → Monitor(画像取得) → Adjustment(404学習)
```

- 時刻サンプルの保持: `KyoshinMonitorTimeSyncSamplesNotifier`
- 公開遅延の合成: `kyoshinMonitorImageDelayProvider`（旧 `effectiveOffset`）
- 画像の layer / source / delayProfile: `KyoshinMonitorImageRequest`（旧 Settings の `effectiveXxx`）
- 純粋計算: `data/logic/` の Calculator / Resolver

補正量の実行時正本は Adjustment Notifier。永続化は現状 Settings.`api.offsetAdjustments` へ書き戻している。

## 命名

利用対象を名前に含める。`effectiveXxx` は使わない。

| 禁止 | 使う名前 |
| --- | --- |
| `effectiveRealtimeLayer` | `ImageRequest.layer` |
| `effectiveMonitorSource` | `ImageRequest.source` |
| `kyoshinMonitorEffectiveOffset` | `kyoshinMonitorImageDelay` |

## 確認

```bash
cd app
mise exec -- dart analyze lib/feature/kyoshin_monitor/data
mise exec -- flutter test test/feature/kyoshin_monitor
```

時刻同期を変えるときは `kyoshin_monitor_time_sync_test.dart` の「端末時計が30秒進んでいる場合」を必ず通す。

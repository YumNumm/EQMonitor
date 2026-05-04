# core/realtime — リアルタイムデータ基盤

複数の WebSocket データソースを抽象化し、アプリ全体へドメインイベントとして供給するレイヤー。

## 設計方針

各 feature (`eew`, `earthquake_history`, `shake_detection` 等) はデータの取得元を知らない。
feature が依存するのは `RealtimeEvent` (ドメインイベント) のみであり、接続プロトコルやペイロード形式への依存をここで完全に断ち切る。

## ディレクトリ構成

```
core/realtime/
├── data_source/
│   ├── eqmonitor/
│   │   ├── eqmonitor_ws_data_source.dart    # EQMonitor WebSocket 接続・再接続・ping 管理
│   │   └── eqmonitor_ws_status_notifier.dart # 接続状態 (phase / url / RTT) の一元管理
│   └── dmdata/
│       └── dmdata_ws_data_source.dart        # DMDATA WebSocket (将来実装)
├── model/
│   └── realtime_event.dart                   # sealed class — feature が消費するドメインイベント
└── realtime_event_provider.dart              # 全ソースを集約・マージ・重複排除して emit
```

## レイヤー構造

```
┌─────────────────────────────────────────────────┐
│  Data Source Layer                              │
│  接続管理・プロトコル変換の責務はここに閉じる            │
│                                                 │
│  EqMonitorWsDataSource   DmdataWsDataSource     │
└──────────────────┬──────────────────────────────┘
                   │ raw payload → RealtimeEvent へ変換
┌──────────────────▼──────────────────────────────┐
│  Domain Event Layer                             │
│  RealtimeEventProvider                          │
│  ・複数ソースの Stream をマージ                    │
│  ・Event ID による重複排除 (冗長化対応)             │
│  ・Stream<RealtimeEvent> を公開                  │
└──────────────────┬──────────────────────────────┘
                   │ RealtimeEvent のみを消費
┌──────────────────▼──────────────────────────────┐
│  Feature Layer                                  │
│  feature/eew  feature/earthquake_history  ...   │
└─────────────────────────────────────────────────┘
```

## 冗長化

`RealtimeEventProvider` は EQMonitor WebSocket と DMDATA WebSocket の両方に同時接続できる。
同一イベントが複数ソースから届いた場合は Event ID で重複排除し、feature 側には 1 度だけ流す。

新しいデータソースを追加するには `data_source/` 配下に実装を追加し、
`RealtimeEventProvider` の merge 対象に組み込むだけでよい。feature 側の変更は不要。

## RealtimeEvent

```dart
@freezed
sealed class RealtimeEvent with _$RealtimeEvent {
  const factory RealtimeEvent.eew(EewPayload data, {
    required RealtimeSource source,
  }) = RealtimeEewEvent;

  const factory RealtimeEvent.earthquakeReport(EarthquakePayload data, {
    required RealtimeSource source,
  }) = RealtimeEarthquakeEvent;

  // 必要に応じて追加
}

enum RealtimeSource { eqmonitor, dmdata }
```

## 接続状態の公開

接続状態 (接続中 / 接続済み / 切断) や RTT は各 DataSource の StatusNotifier が保持する。
UI はこれを直接 watch して表示する。`RealtimeEventProvider` は接続状態を持たない。

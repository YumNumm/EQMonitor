# App Launch Telemetry Design

## Goal

Collect device and app version information on each app launch/resume, store in ClickHouse, and visualize version distribution, DAU/MAU, OS breakdown, and device model analytics via Grafana.

## Use Cases

1. **Version migration monitoring** — track adoption rate after new releases
2. **Forced update decision** — know when old versions have few enough users to deprecate
3. **OS/device bug analysis** — correlate crash rates with specific OS versions or device models
4. **DAU/MAU analysis** — track active user trends over time

## Architecture

### Data Flow

```
Flutter App
  ├─ cold_start (main.dart)
  └─ resume (AppLifecycleListener)
        │
        ▼
  AppLaunchRecorder (30s debounce)
        │
        ▼
  TelemetryRecorder → TelemetryDatabase (SQLite)
        │
        ▼
  TelemetryUploader (batch, on startup)
        │
        ▼
  POST /v2/device/me/telemetry/events (existing endpoint)
        │
        ▼
  Backend: event_type routing
  ├─ "app_launch" → ClickHouse eqmonitor.app_launch
  └─ others       → ClickHouse eqmonitor.client_telemetry
        │
        ▼
  Grafana Dashboard (ClickHouse data source)
```

### ClickHouse Table

```sql
CREATE TABLE eqmonitor.app_launch (
    device_id         String CODEC(ZSTD(1)),
    launch_type       Enum8('cold_start' = 1, 'resume' = 2),

    app_version       LowCardinality(String),
    build_number      UInt32,

    platform          Enum8('ios' = 1, 'android' = 2),
    os_version        LowCardinality(String),
    device_model      LowCardinality(String),
    locale            LowCardinality(String),
    is_physical_device Bool,

    physical_ram_mb   UInt32,
    cpu_cores         UInt8,

    manufacturer      LowCardinality(String),
    android_sdk_int   Nullable(UInt16),
    security_patch    Nullable(Date),
    is_low_ram_device Nullable(Bool),
    installer_store   LowCardinality(Nullable(String)),

    launched_at       DateTime64(3, 'Asia/Tokyo') CODEC(Delta, ZSTD(1)),
    received_at       DateTime64(3, 'Asia/Tokyo') DEFAULT now64(3, 'Asia/Tokyo')
                                                  CODEC(Delta, ZSTD(1))
)
ENGINE = MergeTree
PARTITION BY toYYYYMM(launched_at)
ORDER BY (platform, app_version, device_id, launched_at)
TTL toDateTime(launched_at) + INTERVAL 1 YEAR
SETTINGS index_granularity = 8192;
```

### Flutter Client

- Add `AppLaunchEvent` variant to `TelemetryEvent` sealed class in `telemetry_store` package
- `AppLaunchRecorder` class:
  - 30-second debounce via `SharedPreferences` (last send timestamp)
  - Collects device info from existing providers (`androidDeviceInfoProvider`, `iosDeviceInfoProvider`, `packageInfoProvider`)
  - Records via existing `TelemetryRecorder`
- Hook into app lifecycle:
  - `cold_start`: called from `main.dart` after provider initialization
  - `resume`: via `AppLifecycleListener.onStateChange` (resumed state)
- Upload: existing `TelemetryUploader` batch mechanism (flush on startup)

### Backend

- No new endpoint — use existing `POST /v2/device/me/telemetry/events`
- Route `event_type === "app_launch"` to `eqmonitor.app_launch` table
- `device_id` from request header `x-eqmonitor-device-id`
- Validation: semver for app_version, positive int for build_number, enum for platform/launch_type, 256-char max for strings
- Non-fatal on ClickHouse INSERT failure (existing pattern)

### Grafana Dashboard

6 panels using ClickHouse data source:

1. **Version distribution (time series)** — Stacked Area, `uniqExact(device_id)` by `app_version` per day
2. **DAU trend** — Time Series, iOS/Android split
3. **Current version snapshot** — Pie Chart, last 7 days
4. **OS version distribution** — Table, platform x os_version matrix
5. **Top 20 device models** — Horizontal Bar Chart
6. **Low-end device ratio** — Stacked Bar, RAM-based tiers (<=3GB / 3-6GB / >6GB)

Template variables: `$platform` (ios/android/All), `$app_version`

## Error Handling

| Layer | Failure | Response |
|-------|---------|----------|
| Flutter collection | device_info_plus fails | Fallback to defaults (empty string, 0) |
| Flutter send | Network unavailable | Retry via existing TelemetryUploader (SQLite queue) |
| Backend validation | Invalid event | Skip event, process rest of batch |
| Backend insert | ClickHouse down | Log error, non-fatal (analytics data loss acceptable) |

## Data Scale

- ~30K-50K DAU × ~2-3 events/day = ~60K-150K rows/day
- 1 year retention → ~22M-55M rows
- Estimated storage: ~2-5 GB (with LowCardinality + ZSTD compression)

## Testing

- Flutter: unit tests for 30s debounce logic, platform-specific field mapping
- Backend: event routing logic, validation
- E2E: local docker-compose ClickHouse → Grafana verification

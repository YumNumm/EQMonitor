const telemetryEventsCreateDdl = '''
CREATE TABLE IF NOT EXISTS telemetry_events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  event_type TEXT NOT NULL,
  timestamp_ms INTEGER NOT NULL,
  event_id TEXT,
  payload TEXT NOT NULL,
  synced INTEGER NOT NULL DEFAULT 0 CHECK ("synced" IN (0, 1)),
  created_at_ms INTEGER NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_telemetry_synced
  ON telemetry_events(synced) WHERE synced = 0;
CREATE INDEX IF NOT EXISTS idx_telemetry_event_type
  ON telemetry_events(event_type, timestamp_ms);
''';

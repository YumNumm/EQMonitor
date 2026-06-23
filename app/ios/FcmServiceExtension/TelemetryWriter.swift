import Foundation
import SQLite3

final class TelemetryWriter {
    private static let appGroupId = "group.net.yumnumm.eqmonitor"
    private static let dbName = "telemetry.db"

    static func record(
        eventType: String,
        timestampMs: Int64,
        eventId: String?,
        payload: String
    ) {
        guard let dbPath = databasePath() else { return }
        var db: OpaquePointer?
        guard sqlite3_open_v2(
            dbPath,
            &db,
            SQLITE_OPEN_READWRITE | SQLITE_OPEN_CREATE | SQLITE_OPEN_FULLMUTEX,
            nil
        ) == SQLITE_OK else { return }
        defer { sqlite3_close(db) }

        // Enable WAL mode for concurrent access
        sqlite3_exec(db, "PRAGMA journal_mode=WAL;", nil, nil, nil)

        // Ensure table exists
        let createSQL = """
        CREATE TABLE IF NOT EXISTS telemetry_events (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            event_type TEXT NOT NULL,
            timestamp_ms INTEGER NOT NULL,
            event_id TEXT,
            payload TEXT NOT NULL,
            synced INTEGER NOT NULL DEFAULT 0 CHECK ("synced" IN (0, 1)),
            created_at_ms INTEGER NOT NULL
        );
        """
        sqlite3_exec(db, createSQL, nil, nil, nil)

        // Insert event
        let insertSQL = """
        INSERT INTO telemetry_events
            (event_type, timestamp_ms, event_id, payload, synced, created_at_ms)
        VALUES (?, ?, ?, ?, 0, ?);
        """

        var stmt: OpaquePointer?
        guard sqlite3_prepare_v2(db, insertSQL, -1, &stmt, nil) == SQLITE_OK
        else { return }
        defer { sqlite3_finalize(stmt) }

        let nowMs = Int64(Date().timeIntervalSince1970 * 1000)

        sqlite3_bind_text(stmt, 1, (eventType as NSString).utf8String, -1, nil)
        sqlite3_bind_int64(stmt, 2, timestampMs)
        if let eventId {
            sqlite3_bind_text(stmt, 3, (eventId as NSString).utf8String, -1, nil)
        } else {
            sqlite3_bind_null(stmt, 3)
        }
        sqlite3_bind_text(stmt, 4, (payload as NSString).utf8String, -1, nil)
        sqlite3_bind_int64(stmt, 5, nowMs)

        sqlite3_step(stmt)
    }

    private static func databasePath() -> String? {
        guard let containerURL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appGroupId
        ) else { return nil }

        let supportDir = containerURL
            .appendingPathComponent("Library")
            .appendingPathComponent("Application Support")

        try? FileManager.default.createDirectory(
            at: supportDir,
            withIntermediateDirectories: true
        )

        return supportDir
            .appendingPathComponent(dbName)
            .path
    }
}

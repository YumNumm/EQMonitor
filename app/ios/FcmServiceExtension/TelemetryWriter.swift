import Foundation
import SQLite

final class TelemetryWriter {
    private static let appGroupId = "group.net.yumnumm.eqmonitor"
    private static let dbName = "telemetry.db"

    private static let events = Table("telemetry_events")
    private static let colEventType = SQLite.Expression<String>("event_type")
    private static let colTimestampMs = SQLite.Expression<Int64>("timestamp_ms")
    private static let colEventId = SQLite.Expression<String?>("event_id")
    private static let colPayload = SQLite.Expression<String>("payload")
    private static let colSynced = SQLite.Expression<Int64>("synced")
    private static let colCreatedAtMs = SQLite.Expression<Int64>("created_at_ms")

    static func record(
        eventType: String,
        timestampMs: Int64,
        eventId: String?,
        payload: String
    ) {
        guard let db = openDatabase() else { return }

        let nowMs = Int64(Date().timeIntervalSince1970 * 1000)

        do {
            try db.run(events.insert(
                colEventType <- eventType,
                colTimestampMs <- timestampMs,
                colEventId <- eventId,
                colPayload <- payload,
                colSynced <- 0,
                colCreatedAtMs <- nowMs
            ))
        } catch {
            // Fire-and-forget: silently ignore insert failures
        }
    }

    private static func openDatabase() -> Connection? {
        guard let dbPath = databasePath() else { return nil }

        do {
            let db = try Connection(dbPath, readonly: false)
            try db.execute("PRAGMA journal_mode=WAL;")
            try db.run(events.create(ifNotExists: true) { t in
                t.column(SQLite.Expression<Int64>("id"), primaryKey: .autoincrement)
                t.column(colEventType)
                t.column(colTimestampMs)
                t.column(colEventId)
                t.column(colPayload)
                t.column(colSynced, check: [0, 1].contains(colSynced), defaultValue: 0)
                t.column(colCreatedAtMs)
            })
            return db
        } catch {
            return nil
        }
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

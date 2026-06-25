import Foundation
import os.log
import SQLite
import UserNotifications

final class TelemetryWriter {
    private static let appGroupId = "group.net.yumnumm.eqmonitor"
    private static let dbName = "telemetry.db"
    private static let logger = Logger(subsystem: "net.yumnumm.eqmonitor", category: "TelemetryWriter")

    private static var isDebug: Bool {
        UserDefaults(suiteName: appGroupId)?.bool(forKey: "debugMode") ?? false
    }

    private static func notifyError(_ message: String) {
        guard isDebug else { return }
        logger.error("\(message)")
        let content = UNMutableNotificationContent()
        content.title = "[TelemetryWriter] Error"
        content.body = message
        content.sound = .none
        let request = UNNotificationRequest(
            identifier: "telemetry-error-\(UUID().uuidString)",
            content: content,
            trigger: nil
        )
        UNUserNotificationCenter.current().add(request)
    }

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
        guard let db = openDatabase() else {
            notifyError("Failed to open telemetry database")
            return
        }

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
            notifyError("Failed to insert telemetry event: \(error.localizedDescription)")
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
            notifyError("Failed to initialize telemetry database: \(error.localizedDescription)")
            return nil
        }
    }

    private static func databasePath() -> String? {
        guard let containerURL = FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appGroupId
        ) else {
            notifyError("Failed to access App Group container: \(appGroupId)")
            return nil
        }

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

import Foundation

/// The local debug channel uses the same complete snapshot as APNs.
enum LiveActivityDebugRequest {
    case start(attributes: EarthquakeLiveActivityAttributes, state: UnifiedLiveActivityContentState)
    case update(activityId: String, state: UnifiedLiveActivityContentState)
    case end(activityId: String, state: UnifiedLiveActivityContentState?)
    case list

    static func decode(method: String, arguments: [String: Any]?) throws -> Self {
        if method == "list" { return .list }
        guard let arguments else { throw LiveActivityDebugError.invalidArguments }
        let state: UnifiedLiveActivityContentState?
        if let json = arguments["contentState"] as? String,
           let data = json.data(using: .utf8) {
            do {
                state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: data)
            } catch {
                throw LiveActivityDebugError.invalidContentState
            }
        } else if arguments["contentState"] == nil || arguments["contentState"] is NSNull {
            state = nil
        } else {
            throw LiveActivityDebugError.invalidContentState
        }
        if method == "start" {
            guard let raw = arguments["attributes"] as? [String: Any],
                  JSONSerialization.isValidJSONObject(raw) else {
                throw LiveActivityDebugError.invalidArguments
            }
            let attributes: EarthquakeLiveActivityAttributes
            do {
                attributes = try JSONDecoder().decode(
                    EarthquakeLiveActivityAttributes.self,
                    from: JSONSerialization.data(withJSONObject: raw)
                )
            } catch { throw LiveActivityDebugError.invalidArguments }
            guard let state else { throw LiveActivityDebugError.invalidContentState }
            try validateIdentity(attributesId: attributes.id, state: state)
            return .start(attributes: attributes, state: state)
        }
        guard let activityId = arguments["activityId"] as? String, !activityId.isEmpty else {
            throw LiveActivityDebugError.invalidArguments
        }
        switch method {
        case "update":
            guard let state else { throw LiveActivityDebugError.invalidContentState }
            return .update(activityId: activityId, state: state)
        case "end": return .end(activityId: activityId, state: state)
        default: throw LiveActivityDebugError.invalidArguments
        }
    }

    static func validateIdentity(attributesId: String, state: UnifiedLiveActivityContentState?) throws {
        if let state, state.id != attributesId { throw LiveActivityDebugError.logicalIdMismatch }
    }
}

enum LiveActivityDebugError: String, Error {
    case invalidArguments = "invalid_arguments"
    case invalidContentState = "invalid_content_state"
    case logicalIdMismatch = "logical_id_mismatch"
    case activityNotFound = "activity_not_found"

    var message: String {
        switch self {
        case .invalidArguments: "操作の引数が正しくありません"
        case .invalidContentState: "統合Live ActivityのJSON形式が正しくありません"
        case .logicalIdMismatch: "開始時と異なる論理IDの情報では更新できません"
        case .activityNotFound: "対象のLive Activityは終了したか、見つかりません"
        }
    }
}

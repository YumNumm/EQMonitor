import Foundation
import Testing

private final class LiveActivityDebugFixtureMarker {}

struct LiveActivityDebugRequestTests {
    @Test func startRequiresMatchingOpaqueLogicalId() throws {
        let json = try fixture()
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: Data(json.utf8))
        let request = try LiveActivityDebugRequest.decode(method: "start", arguments: [
            "attributes": ["id": state.id], "contentState": json,
        ])
        guard case let .start(attributes, decoded) = request else {
            Issue.record("Expected start"); return
        }
        #expect(attributes.id == state.id)
        #expect(decoded == state)
        #expect(throws: LiveActivityDebugError.logicalIdMismatch) {
            try LiveActivityDebugRequest.decode(method: "start", arguments: [
                "attributes": ["id": "another-logical-id"], "contentState": json,
            ])
        }
    }

    @Test func malformedOrMissingSnapshotsAreRejected() throws {
        for json in ["", "{}", "[]", "not-json"] {
            #expect(throws: LiveActivityDebugError.invalidContentState) {
                try LiveActivityDebugRequest.decode(method: "update", arguments: [
                    "activityId": "os-activity", "contentState": json,
                ])
            }
        }
        #expect(throws: LiveActivityDebugError.invalidContentState) {
            try LiveActivityDebugRequest.decode(method: "update", arguments: ["activityId": "os-activity"])
        }
    }

    @Test func endAllowsOmittedStateButRequiresOsActivityId() throws {
        let request = try LiveActivityDebugRequest.decode(method: "end", arguments: ["activityId": "os-activity"])
        guard case let .end(activityId, state) = request else {
            Issue.record("Expected end"); return
        }
        #expect(activityId == "os-activity")
        #expect(state == nil)
        #expect(throws: LiveActivityDebugError.invalidArguments) {
            try LiveActivityDebugRequest.decode(method: "end", arguments: ["activityId": ""])
        }
    }

    @Test func identityValidationProtectsUpdatesAndFinalState() throws {
        let state = try JSONDecoder().decode(UnifiedLiveActivityContentState.self, from: Data(fixture().utf8))
        try LiveActivityDebugRequest.validateIdentity(attributesId: state.id, state: state)
        try LiveActivityDebugRequest.validateIdentity(attributesId: state.id, state: nil)
        #expect(throws: LiveActivityDebugError.logicalIdMismatch) {
            try LiveActivityDebugRequest.validateIdentity(attributesId: "another-id", state: state)
        }
    }

    private func fixture() throws -> String {
        let url = try #require(Bundle(for: LiveActivityDebugFixtureMarker.self)
            .url(forResource: "canonical", withExtension: "json"))
        return try String(contentsOf: url, encoding: .utf8)
    }
}

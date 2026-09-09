import AppIntents
import Foundation
import Testing
import EQMonitorAPI

struct EarthquakeIntentExecutionTests {
    @Test func snippetCanFetchWithoutExistingSnapshot() async throws {
        let transport = IntentTestTransport(status: .ok, json: #"{"items":[]}"#)
        let service = try EarthquakeIntentTransportTests().makeService(transport: transport)
        let snippet = EarthquakeSnippetIntent(regionID: nil, minIntensity: nil, limit: 3)
        _ = try await snippet.execute(service: service)
        #expect(await transport.requestCount == 1)
    }

    @Test func mainResultAndRepeatedSnippetUseOneRequestUntilExplicitRefresh() async throws {
        let source = try EarthquakeIntentDialogTests().earthquake()
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        let body = String(decoding: try encoder.encode(Components.Schemas.EarthquakeListResponse(items: [source])), as: UTF8.self)
        let transport = IntentTestTransport(status: .ok, json: body)
        let service = try EarthquakeIntentTransportTests().makeService(transport: transport)
        let id = UUID().uuidString
        var main = GetLatestEarthquakesIntent()
        main.limit = 3
        let result = try await main.execute(service: service, snapshotID: id)
        #expect(result.value?.first?.id == source.event_id)
        #expect(result.value?.first?.maxIntensity == "4")
        let snippet = EarthquakeSnippetIntent(regionID: nil, minIntensity: nil, limit: 3, snapshotID: id)
        _ = try await snippet.execute(service: service)
        _ = try await snippet.execute(service: service)
        #expect(await transport.requestCount == 1)

        let updatedTransport = IntentTestTransport(status: .ok, json: #"{"items":[]}"#)
        let updatedService = try EarthquakeIntentTransportTests().makeService(transport: updatedTransport)
        let refresh = RefreshEarthquakeSnippetIntent(regionID: nil, minIntensity: nil, limit: 3, snapshotID: id)
        _ = try await refresh.execute(service: updatedService)
        _ = try await snippet.execute(service: updatedService)
        #expect(await updatedTransport.requestCount == 1)
        #expect(try await EarthquakeSnippetStore.shared.get(id).items.isEmpty)
        #expect(try await EarthquakeSnippetStore.shared.get(id).wasRefreshed)
        #expect(result.value?.first?.id == source.event_id)
    }
}

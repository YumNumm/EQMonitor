import AppIntents
import Foundation
import Testing
import EQMonitorAPI
import HTTPTypes

struct EarthquakeIntentTransportTests {
    @Test func offlineFailureIsNormalizedThroughGeneratedClient() async throws {
        let service = try makeService(transport: .init(status: .ok, json: nil, error: .notConnectedToInternet))
        await #expect(throws: EQIntentError.fetchFailed("インターネットに接続されていません")) {
            try await EarthquakeFetcher.fetch(plan: .nationwide, limit: 3, minIntensity: nil, service: service)
        }
    }

    @Test func decodingFailureIsNormalizedThroughGeneratedClient() async throws {
        let service = try makeService(transport: .init(status: .ok, json: "{invalid private response"))
        await #expect(throws: EQIntentError.fetchFailed(WidgetErrorMessage.unknown)) {
            try await EarthquakeFetcher.fetchEntity("20260830001711", service: service)
        }
    }

    @Test func missingDetailIsNotNetworkFailure() async throws {
        let service = try makeService(transport: .init(status: .notFound, json: #"{"code":"NOT_FOUND","message":"Not found"}"#))
        #expect(try await EarthquakeFetcher.fetchEntity("20260830001711", service: service) == nil)
    }

    @Test(arguments: [Components.Schemas.EarthquakeType.NORMAL, .DISTANT, .VOLCANO])
    func detailRestorationKeepsSourceTypeAndStatus(type: Components.Schemas.EarthquakeType) async throws {
        let json = """
        {"earthquake":{"event_id":"20260830001711","status":"TRAINING","earthquake_type":"\(type.rawValue)",
        "origin_time_precision":"MONTH","datasources":[],"telegrams":[]}}
        """
        let service = try makeService(transport: .init(status: .ok, json: json))
        let item = try #require(await EarthquakeFetcher.fetchEntity("20260830001711", service: service))
        let entity = EarthquakeEntity(item: item)
        #expect(entity.earthquakeType == type.rawValue)
        #expect(entity.isTraining)
        #expect(entity.originTime == nil)
        #expect(entity.timePrecision == "MONTH")
        #expect(entity.maximumIntensityValue == nil)
        #expect(entity.regionalIntensityValue == nil)
    }

    @Test func cancellationIsNotAnnouncedAsCommunicationFailure() {
        #expect(EarthquakeFetcher.normalizedError(CancellationError()) is CancellationError)
    }

    func makeService(transport: IntentTestTransport) throws -> EarthquakeAPIService {
        EarthquakeAPIService(baseURL: try #require(URL(string: "https://example.invalid")), transport: transport)
    }
}


actor IntentTestTransport: ClientTransport {
    let status: HTTPResponse.Status
    let json: String?
    let error: URLError.Code?
    var requestCount = 0

    init(status: HTTPResponse.Status, json: String?, error: URLError.Code? = nil) {
        self.status = status
        self.json = json
        self.error = error
    }

    func send(_ request: HTTPRequest, body: HTTPBody?, baseURL: URL, operationID: String) async throws
        -> (HTTPResponse, HTTPBody?) {
        requestCount += 1
        if let error { throw URLError(error) }
        return (HTTPResponse(status: status, headerFields: [.contentType: "application/json"]), json.map { HTTPBody($0) })
    }
}

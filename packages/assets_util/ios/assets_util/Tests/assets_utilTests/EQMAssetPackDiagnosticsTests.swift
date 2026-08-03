import Foundation
import Testing
@testable import assets_util

@Suite struct EQMAssetPackDiagnosticsTests {
  @Test func invalidManifestReportsManifestInvalid() throws {
    let fixture = try AssetPackFixture(manifest: Data("not json".utf8))

    let result = AssetPackDiagnosticsInspector.inspect(
      manifestURL: fixture.manifestURL,
      packRoot: fixture.root,
      resolveAssetURL: { fixture.root.appendingPathComponent($0) }
    )

    #expect(result.status == .manifestInvalid)
    #expect(result.assets.isEmpty)
  }

  @Test func missingAssetReportsEveryManifestAsset() throws {
    let fixture = try AssetPackFixture(manifest: manifestData())
    try fixture.writeAsset(path: "map/present.pmtiles", bytes: [1, 2, 3])

    let result = AssetPackDiagnosticsInspector.inspect(
      manifestURL: fixture.manifestURL,
      packRoot: fixture.root,
      resolveAssetURL: { fixture.root.appendingPathComponent($0) }
    )

    #expect(result.status == .assetMissing)
    #expect(result.assets.map(\.status) == [.ready, .missing])
  }

  @Test func sizeMismatchReportsExpectedAndActualSizes() throws {
    let fixture = try AssetPackFixture(manifest: manifestData())
    try fixture.writeAsset(path: "map/present.pmtiles", bytes: [1])
    try fixture.writeAsset(path: "map/missing.pmtiles", bytes: [1, 2, 3, 4])

    let result = AssetPackDiagnosticsInspector.inspect(
      manifestURL: fixture.manifestURL,
      packRoot: fixture.root,
      resolveAssetURL: { fixture.root.appendingPathComponent($0) }
    )

    #expect(result.status == .assetSizeMismatch)
    #expect(result.assets[0].expectedSizeBytes == 3)
    #expect(result.assets[0].actualSizeBytes == 1)
  }

  @Test func validAssetsReportReadyAndStableJSONKeys() throws {
    let fixture = try AssetPackFixture(manifest: manifestData())
    try fixture.writeAsset(path: "map/present.pmtiles", bytes: [1, 2, 3])
    try fixture.writeAsset(path: "map/missing.pmtiles", bytes: [1, 2, 3, 4])
    let inspected = AssetPackDiagnosticsInspector.inspect(
      manifestURL: fixture.manifestURL,
      packRoot: fixture.root,
      resolveAssetURL: { fixture.root.appendingPathComponent($0) }
    )
    let envelope = AssetPackDiagnosticsEnvelope(
      platform: "ios",
      osVersion: "26.4",
      packIdentifier: "eqmonitor-assets",
      systemAvailability: .available,
      inspection: inspected,
      nativeError: nil
    )

    #expect(inspected.status == .ready)
    let data = try AssetPackDiagnosticsJSONEncoder.encode(envelope)
    let value = try JSONSerialization.jsonObject(with: data)
    let json = try #require(value as? [String: Any])
    #expect(json["schema_version"] as? Int == 2)
    #expect(json["status"] as? String == "ready")
    #expect(json["pack_id"] as? String == "eqmonitor-assets")
    #expect(json["platform"] != nil)
    #expect(json["os_version"] != nil)
    #expect(json["system_availability"] != nil)
    #expect(json["manifest_url"] != nil)
    #expect(json["pack_root"] != nil)
    #expect(json["manifest"] != nil)
    #expect(json["assets"] != nil)
  }

  @Test func individuallyResolvedAssetsDoNotRequireManifestSiblingPaths() throws {
    let manifestFixture = try AssetPackFixture(manifest: manifestData())
    let assetFixture = try AssetPackFixture(manifest: Data("{}".utf8))
    try assetFixture.writeAsset(path: "map/present.pmtiles", bytes: [1, 2, 3])
    try assetFixture.writeAsset(path: "map/missing.pmtiles", bytes: [1, 2, 3, 4])

    let result = AssetPackDiagnosticsInspector.inspect(
      manifestURL: manifestFixture.manifestURL,
      resolveAssetURL: { relativePath in
        assetFixture.root.appendingPathComponent(relativePath)
      }
    )

    #expect(result.status == .ready)
    #expect(
      result.assets[0].resolvedURL
        == assetFixture.root.appendingPathComponent("map/present.pmtiles")
    )
    #expect(result.assets.map(\.actualSizeBytes) == [3, 4])
  }
}

private final class AssetPackFixture {
  init(manifest: Data) throws {
    root = FileManager.default.temporaryDirectory.appendingPathComponent(
      UUID().uuidString,
      isDirectory: true
    )
    manifestURL = root.appendingPathComponent("manifest.json")
    try FileManager.default.createDirectory(
      at: root,
      withIntermediateDirectories: true
    )
    try manifest.write(to: manifestURL)
  }

  deinit {
    try? FileManager.default.removeItem(at: root)
  }

  let root: URL
  let manifestURL: URL

  func writeAsset(path: String, bytes: [UInt8]) throws {
    let url = root.appendingPathComponent(path)
    try FileManager.default.createDirectory(
      at: url.deletingLastPathComponent(),
      withIntermediateDirectories: true
    )
    try Data(bytes).write(to: url)
  }
}

private func manifestData() -> Data {
  Data(
    """
    {
      "schema_version": 1,
      "pack_version": "test",
      "generated_at": "2026-07-31T00:00:00Z",
      "assets": [
        {"id": "present", "path": "map/present.pmtiles", "size_bytes": 3},
        {"id": "missing", "path": "map/missing.pmtiles", "size_bytes": 4}
      ]
    }
    """.utf8
  )
}

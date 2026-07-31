import Foundation
import System
#if os(iOS)
import BackgroundAssets
#endif

enum AssetPackDiagnosticStatus: String {
  case ready
  case unsupportedOs
  case manifestUrlResolutionFailed
  case manifestMissing
  case manifestUnreadable
  case manifestInvalid
  case assetMissing
  case assetSizeMismatch
}

enum AssetPackSystemAvailability: String {
  case available
  case unavailable
  case apiUnavailable
}

enum AssetPackFileDiagnosticStatus: String {
  case ready
  case missing
  case sizeMismatch
}

struct AssetPackNativeError {
  let domain: String
  let code: Int
  let description: String

  init(error: Error) {
    let nsError = error as NSError
    domain = nsError.domain
    code = nsError.code
    description = nsError.localizedDescription
  }
}

struct AssetPackFileDiagnostic {
  let path: String
  let status: AssetPackFileDiagnosticStatus
  let exists: Bool
  let expectedSizeBytes: Int?
  let actualSizeBytes: Int?
}

struct AssetPackInspection {
  let status: AssetPackDiagnosticStatus
  let detail: String
  let manifestURL: URL?
  let packRoot: URL?
  let manifest: [String: Any]?
  let assets: [AssetPackFileDiagnostic]
  let nativeError: AssetPackNativeError?
}

struct AssetPackDiagnosticsEnvelope {
  let platform: String
  let osVersion: String
  let packIdentifier: String
  let systemAvailability: AssetPackSystemAvailability
  let inspection: AssetPackInspection
  let nativeError: AssetPackNativeError?
}

enum AssetPackDiagnosticsInspector {
  static func inspect(manifestURL: URL, packRoot: URL) -> AssetPackInspection {
    let manifestData: Data
    do {
      manifestData = try Data(contentsOf: manifestURL)
    } catch {
      return AssetPackInspection(
        status: .manifestUnreadable,
        detail: "manifest.json could not be read.",
        manifestURL: manifestURL,
        packRoot: packRoot,
        manifest: nil,
        assets: [],
        nativeError: AssetPackNativeError(error: error)
      )
    }

    guard
      let manifest = try? JSONSerialization.jsonObject(with: manifestData) as? [String: Any],
      let rawAssets = manifest["assets"] as? [[String: Any]],
      !rawAssets.isEmpty
    else {
      return AssetPackInspection(
        status: .manifestInvalid,
        detail: "manifest.json is not a supported non-empty asset manifest.",
        manifestURL: manifestURL,
        packRoot: packRoot,
        manifest: nil,
        assets: [],
        nativeError: nil
      )
    }

    var diagnostics: [AssetPackFileDiagnostic] = []
    for rawAsset in rawAssets {
      guard
        let relativePath = rawAsset["path"] as? String,
        !relativePath.isEmpty,
        let expectedSize = rawAsset["size_bytes"] as? Int
      else {
        return AssetPackInspection(
          status: .manifestInvalid,
          detail: "An asset entry has an invalid path or size_bytes value.",
          manifestURL: manifestURL,
          packRoot: packRoot,
          manifest: manifest,
          assets: diagnostics,
          nativeError: nil
        )
      }

      let assetURL = packRoot.appendingPathComponent(relativePath)
      let exists = FileManager.default.fileExists(atPath: assetURL.path)
      let actualSize = (try? FileManager.default.attributesOfItem(
        atPath: assetURL.path
      )[.size] as? NSNumber)?.intValue
      let status: AssetPackFileDiagnosticStatus
      if !exists {
        status = .missing
      } else if actualSize != expectedSize {
        status = .sizeMismatch
      } else {
        status = .ready
      }
      diagnostics.append(
        AssetPackFileDiagnostic(
          path: relativePath,
          status: status,
          exists: exists,
          expectedSizeBytes: expectedSize,
          actualSizeBytes: actualSize
        )
      )
    }

    let status: AssetPackDiagnosticStatus
    if diagnostics.contains(where: { $0.status == .missing }) {
      status = .assetMissing
    } else if diagnostics.contains(where: { $0.status == .sizeMismatch }) {
      status = .assetSizeMismatch
    } else {
      status = .ready
    }
    return AssetPackInspection(
      status: status,
      detail: status == .ready
        ? "Every manifest asset exists and matches its expected size."
        : "One or more manifest assets are unavailable or invalid.",
      manifestURL: manifestURL,
      packRoot: packRoot,
      manifest: manifest,
      assets: diagnostics,
      nativeError: nil
    )
  }
}

enum AssetPackDiagnosticsJSONEncoder {
  static func encode(_ envelope: AssetPackDiagnosticsEnvelope) throws -> Data {
    let inspection = envelope.inspection
    var json: [String: Any] = [
      "schema_version": 1,
      "platform": envelope.platform,
      "os_version": envelope.osVersion,
      "pack_id": envelope.packIdentifier,
      "status": inspection.status.rawValue,
      "system_availability": envelope.systemAvailability.rawValue,
      "detail": inspection.detail,
      "manifest_url": inspection.manifestURL?.absoluteString ?? NSNull(),
      "pack_root": inspection.packRoot?.path ?? NSNull(),
      "manifest": inspection.manifest ?? NSNull(),
      "assets": inspection.assets.map { asset in
        [
          "path": asset.path,
          "status": asset.status.rawValue,
          "exists": asset.exists,
          "expected_size_bytes": asset.expectedSizeBytes ?? NSNull(),
          "actual_size_bytes": asset.actualSizeBytes ?? NSNull(),
        ] as [String: Any]
      },
    ]
    let nativeError = inspection.nativeError ?? envelope.nativeError
    json["native_error"] = nativeError.map { error in
      [
        "domain": error.domain,
        "code": error.code,
        "description": error.description,
      ]
    } ?? NSNull()
    return try JSONSerialization.data(withJSONObject: json, options: [.sortedKeys])
  }

  static func string(_ envelope: AssetPackDiagnosticsEnvelope) -> String {
    do {
      return String(decoding: try encode(envelope), as: UTF8.self)
    } catch {
      let encodingError = AssetPackNativeError(error: error)
      let json: [String: Any] = [
        "schema_version": 1,
        "platform": envelope.platform,
        "os_version": envelope.osVersion,
        "pack_id": envelope.packIdentifier,
        "status": AssetPackDiagnosticStatus.manifestInvalid.rawValue,
        "system_availability": envelope.systemAvailability.rawValue,
        "detail": "The native diagnostics payload could not be encoded.",
        "manifest_url": NSNull(),
        "pack_root": NSNull(),
        "manifest": NSNull(),
        "assets": [],
        "native_error": [
          "domain": encodingError.domain,
          "code": encodingError.code,
          "description": encodingError.description,
        ],
      ]
      let data = try? JSONSerialization.data(withJSONObject: json, options: [.sortedKeys])
      return data.map { String(decoding: $0, as: UTF8.self) } ?? ""
    }
  }
}

@objc(EQMAssetsUtil)
@objcMembers public class EQMAssetsUtil: NSObject {
  public func resolveLocalPath(fileName: String) -> String? {
    let nsName = fileName as NSString
    let base = nsName.deletingPathExtension
    let ext = nsName.pathExtension
    guard !base.isEmpty else {
      return nil
    }
    if ext.isEmpty {
      return Bundle.main.path(forResource: base, ofType: nil)
    }
    return Bundle.main.path(forResource: base, ofType: ext)
  }

  /// Resolves the absolute path to the Asset Pack root directory.
  ///
  /// - iOS: the on-device directory of the Managed Background Assets pack
  ///   identified by `packIdentifier`, once fully downloaded.
  /// - macOS: the bundled `platform` folder inside `Bundle.main` (a folder
  ///   reference registered in `Runner.xcodeproj`'s Bundle Resources),
  ///   which is always present — macOS has no store-based Asset Pack
  ///   delivery, see `docs/superpowers/specs/2026-07-18-asset-pack-design.md`.
  ///
  /// Returns `nil` if the pack isn't ready / doesn't exist. The Dart side
  /// (`AssetsUtilApple.resolvePackRoot`) turns a `nil` result into
  /// `AssetPackNotReadyException` — there is no fallback here by design.
  public func resolvePackRoot(packIdentifier: String) -> String? {
    #if os(macOS)
    return resolveMacOSBundledPackRoot()
    #elseif os(iOS)
    return resolveIOSManagedAssetPackRoot(packIdentifier: packIdentifier)
    #else
    return nil
    #endif
  }

  public func diagnoseAssetPack(packIdentifier: String) -> String {
    #if os(iOS)
    return diagnoseIOSManagedAssetPack(packIdentifier: packIdentifier)
    #else
    return diagnosticString(
      packIdentifier: packIdentifier,
      systemAvailability: .apiUnavailable,
      inspection: AssetPackInspection(
        status: .unsupportedOs,
        detail: "Managed Background Assets diagnostics are only available on iOS.",
        manifestURL: nil,
        packRoot: nil,
        manifest: nil,
        assets: [],
        nativeError: nil
      )
    )
    #endif
  }

  public func checkForAssetPackUpdates(
    packIdentifier: String,
    completion: @escaping (NSString) -> Void
  ) {
    #if os(iOS)
    guard #available(iOS 26.0, *) else {
      completion(
        updateResultString(
          packIdentifier: packIdentifier,
          updatingIDs: [],
          removedIDs: [],
          error: NSError(
            domain: "EQMAssetsUtil.AssetPack",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "iOS 26.0 or later is required."]
          )
        ) as NSString
      )
      return
    }
    Task { @MainActor in
      do {
        let result = try await AssetPackManager.shared.checkForUpdates()
        completion(
          updateResultString(
            packIdentifier: packIdentifier,
            updatingIDs: result.updatingIDs.sorted(),
            removedIDs: result.removedIDs.sorted(),
            error: nil
          ) as NSString
        )
      } catch {
        completion(
          updateResultString(
            packIdentifier: packIdentifier,
            updatingIDs: [],
            removedIDs: [],
            error: error
          ) as NSString
        )
      }
    }
    #else
    completion(
      updateResultString(
        packIdentifier: packIdentifier,
        updatingIDs: [],
        removedIDs: [],
        error: NSError(
          domain: "EQMAssetsUtil.AssetPack",
          code: 2,
          userInfo: [NSLocalizedDescriptionKey: "Asset Pack updates are only available on iOS."]
        )
      ) as NSString
    )
    #endif
  }

  func diagnosticString(
    packIdentifier: String,
    systemAvailability: AssetPackSystemAvailability,
    inspection: AssetPackInspection,
    nativeError: AssetPackNativeError? = nil
  ) -> String {
    AssetPackDiagnosticsJSONEncoder.string(
      AssetPackDiagnosticsEnvelope(
        platform: platformName,
        osVersion: ProcessInfo.processInfo.operatingSystemVersionString,
        packIdentifier: packIdentifier,
        systemAvailability: systemAvailability,
        inspection: inspection,
        nativeError: nativeError
      )
    )
  }

  var platformName: String {
    #if os(iOS)
    return "ios"
    #elseif os(macOS)
    return "macos"
    #else
    return "unknown"
    #endif
  }

  func updateResultString(
    packIdentifier: String,
    updatingIDs: [String],
    removedIDs: [String],
    error: Error?
  ) -> String {
    let nativeError = error.map(AssetPackNativeError.init(error:))
    let json: [String: Any] = [
      "schema_version": 1,
      "pack_id": packIdentifier,
      "success": error == nil,
      "checked_at": ISO8601DateFormatter().string(from: Date()),
      "updating_ids": updatingIDs,
      "removed_ids": removedIDs,
      "native_error": nativeError.map { value in
        [
          "domain": value.domain,
          "code": value.code,
          "description": value.description,
        ]
      } ?? NSNull(),
    ]
    let data = try? JSONSerialization.data(withJSONObject: json, options: [.sortedKeys])
    return data.map { String(decoding: $0, as: UTF8.self) } ?? ""
  }

  #if os(macOS)
  private func resolveMacOSBundledPackRoot() -> String? {
    guard let resourceURL = Bundle.main.resourceURL else {
      return nil
    }
    let platformDir = resourceURL.appendingPathComponent(
      "platform",
      isDirectory: true
    )
    var isDirectory: ObjCBool = false
    let exists = FileManager.default.fileExists(
      atPath: platformDir.path,
      isDirectory: &isDirectory
    )
    guard exists, isDirectory.boolValue else {
      return nil
    }
    return platformDir.path
  }
  #endif

  #if os(iOS)
  private func diagnoseIOSManagedAssetPack(packIdentifier: String) -> String {
    guard #available(iOS 26.0, *) else {
      return diagnosticString(
        packIdentifier: packIdentifier,
        systemAvailability: .apiUnavailable,
        inspection: AssetPackInspection(
          status: .unsupportedOs,
          detail: "iOS 26.0 or later is required.",
          manifestURL: nil,
          packRoot: nil,
          manifest: nil,
          assets: [],
          nativeError: nil
        )
      )
    }
    let manager = AssetPackManager.shared
    let availability: AssetPackSystemAvailability
    if #available(iOS 26.4, *) {
      availability = manager.assetPackIsAvailableLocally(withID: packIdentifier)
        ? .available
        : .unavailable
    } else {
      availability = .apiUnavailable
    }

    let manifestURL: URL
    do {
      manifestURL = try manager.url(for: FilePath("manifest.json"))
    } catch {
      return diagnosticString(
        packIdentifier: packIdentifier,
        systemAvailability: availability,
        inspection: AssetPackInspection(
          status: .manifestUrlResolutionFailed,
          detail: "Background Assets could not resolve manifest.json.",
          manifestURL: nil,
          packRoot: nil,
          manifest: nil,
          assets: [],
          nativeError: AssetPackNativeError(error: error)
        )
      )
    }
    let packRoot = manifestURL.deletingLastPathComponent()
    guard FileManager.default.fileExists(atPath: manifestURL.path) else {
      return diagnosticString(
        packIdentifier: packIdentifier,
        systemAvailability: availability,
        inspection: AssetPackInspection(
          status: .manifestMissing,
          detail: "manifest.json does not exist at the resolved URL.",
          manifestURL: manifestURL,
          packRoot: packRoot,
          manifest: nil,
          assets: [],
          nativeError: nil
        )
      )
    }
    return diagnosticString(
      packIdentifier: packIdentifier,
      systemAvailability: availability,
      inspection: AssetPackDiagnosticsInspector.inspect(
        manifestURL: manifestURL,
        packRoot: packRoot
      )
    )
  }

  private func resolveIOSManagedAssetPackRoot(packIdentifier: String) -> String? {
    // `AssetPackManager` (the Swift-refined API for the ObjC
    // `BAAssetPackManager`; see docs/knowledge/20260727_background_assets_api_surface.md)
    // is available starting iOS 26 — matches this app's own
    // IPHONEOS_DEPLOYMENT_TARGET, but this package also ships as a
    // standalone xcframework built against a 16.0 minimum, so guard
    // explicitly rather than assuming.
    guard #available(iOS 26.0, *) else {
      return nil
    }
    let manager = AssetPackManager.shared

    // `AssetPackManager.assetPackIsAvailableLocally(withID:)` would be a
    // cheap early-exit readiness signal, but it only exists in the iOS 26.4
    // SDK and referencing it would pin every build (CI included) to Xcode
    // 26.4+. It is also not sufficient on its own: per `BADownload.h`,
    // Background Assets tracks download state per *file*, not per pack, so
    // the manifest-driven completeness check below
    // (`verifyAllManifestAssetsExist`) is what actually establishes
    // readiness — and it runs on every supported OS version (26.0+).

    // There is no "get the pack's root directory" API: `url(for:)` merges
    // *all* downloaded asset packs into a single virtual namespace and
    // Apple's own docs warn against calling it with an empty/root path.
    // Since this app manages exactly one asset pack, resolve the one
    // top-level file the pack layout guarantees
    // (`backend/docs/superpowers/specs/2026-07-18-asset-pack-design.md`:
    // `manifest.json`) and derive its parent directory as the "root".
    guard let manifestURL = try? manager.url(for: FilePath("manifest.json")) else {
      return nil
    }

    // `url(for:)`'s own doc: it "will return a well formed URL even if no
    // item exists at the specified relative path" — so its return value
    // alone isn't a reliable readiness signal. Verify the file is
    // actually there.
    guard FileManager.default.fileExists(atPath: manifestURL.path) else {
      return nil
    }

    let packRoot = manifestURL.deletingLastPathComponent()

    // Background Assets has no "pack is fully, atomically in place" API
    // (readiness is tracked per-file, per `BADownload.h`) — `manifest.json`
    // existing doesn't imply every asset it lists has finished downloading
    // (e.g. `map/all.pmtiles` could still be mid-download on iOS
    // 26.0–26.3, where `assetPackIsAvailableLocally` isn't even available
    // to short-circuit this). So parse the manifest and verify every
    // listed asset is actually present (and correctly sized, when
    // `size_bytes` is given) before declaring the pack root ready.
    guard verifyAllManifestAssetsExist(manifestURL: manifestURL, packRoot: packRoot) else {
      return nil
    }

    return packRoot.path
  }

  /// Parses `manifest.json` (schema: `AssetPackManifest` in
  /// `backend/docs/superpowers/specs/2026-07-18-asset-pack-design.md`, an
  /// object with an `assets` array of `{ path, size_bytes, ... }`) and
  /// verifies every listed asset actually exists under `packRoot`, with
  /// matching file size when `size_bytes` is present. This is the
  /// OS-version-independent completeness check described above — it's
  /// deliberately conservative: any parse failure or missing/mismatched
  /// asset means "not ready" (`false`), never "assume ready".
  private func verifyAllManifestAssetsExist(manifestURL: URL, packRoot: URL) -> Bool {
    guard let manifestData = try? Data(contentsOf: manifestURL) else {
      return false
    }
    guard
      let manifestJSON = try? JSONSerialization.jsonObject(with: manifestData) as? [String: Any],
      let assets = manifestJSON["assets"] as? [[String: Any]],
      !assets.isEmpty
    else {
      return false
    }

    let fileManager = FileManager.default
    for asset in assets {
      guard let relativePath = asset["path"] as? String, !relativePath.isEmpty else {
        return false
      }
      let assetURL = packRoot.appendingPathComponent(relativePath)
      guard fileManager.fileExists(atPath: assetURL.path) else {
        return false
      }
      if let expectedSize = asset["size_bytes"] as? Int {
        guard
          let attributes = try? fileManager.attributesOfItem(atPath: assetURL.path),
          let actualSize = attributes[.size] as? Int,
          actualSize == expectedSize
        else {
          return false
        }
      }
    }
    return true
  }
  #endif
}

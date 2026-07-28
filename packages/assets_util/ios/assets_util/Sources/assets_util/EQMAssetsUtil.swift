import Foundation
import System
#if os(iOS)
import BackgroundAssets
#endif

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

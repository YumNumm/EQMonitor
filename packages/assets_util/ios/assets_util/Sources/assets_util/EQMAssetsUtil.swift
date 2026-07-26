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

    // `assetPackIsAvailableLocally(withID:)` only exists from iOS 26.4;
    // treat it as an extra readiness signal when available, but don't
    // require it (this app's own minimum is 26.0).
    if #available(iOS 26.4, *) {
      guard manager.assetPackIsAvailableLocally(withID: packIdentifier) else {
        return nil
      }
    }

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

    return manifestURL.deletingLastPathComponent().path
  }
  #endif
}

import Foundation

/// Platform-managed local assets resolver for EQMonitor.
///
/// Resolves absolute filesystem paths for files bundled in the Runner app
/// (not this XCFramework's own bundle). Future Background Assets support
/// should replace the implementation of [resolveLocalPath] while keeping
/// the same ObjC surface for Dart FFI.
@objc(EQMAssetsUtil)
@objcMembers public class EQMAssetsUtil: NSObject {
  /// Returns an absolute path to a file in the main app bundle.
  ///
  /// - Parameter fileName: File name including extension (e.g. `earthquake_tsunami_all.pmtiles`).
  /// - Returns: Absolute path, or `nil` if the resource is missing.
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
}

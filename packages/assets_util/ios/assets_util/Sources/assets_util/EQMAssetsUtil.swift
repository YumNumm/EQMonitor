import Foundation

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
}

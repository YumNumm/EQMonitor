import Foundation
import MapLibre
import UIKit

@objc public class MapLibreRegistry: NSObject {
  private static var mapRegistry: [Int64: AnyObject] = [:]

  @objc public static func getMapRegistry() -> [Int64: AnyObject] {
    mapRegistry
  }

  // Method to get the map for a given viewId
  @objc public static func getMap(viewId: Int64) -> AnyObject? {
    print("getMap: \(viewId)")
    return mapRegistry[viewId]
  }

  // Method to add a map to the registry
  public static func addMap(viewId: Int64, map: AnyObject) {
    print("addMap: \(viewId) \(map)")
    mapRegistry[viewId] = map
  }

  // Method to remove a map to the registry
  public static func removeMap(viewId: Int64) {
    print("removeMap: \(viewId)")
    mapRegistry.removeValue(forKey: viewId)
  }

  // Warning: Storing Activity in a static field may lead to memory leaks.
  @objc public static var activity: AnyObject?

  // Warning: Storing Context in a static field may lead to memory leaks.
  @objc public static var context: AnyObject?
}

@objc public class Helpers: NSObject {
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}

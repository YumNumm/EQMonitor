import Foundation
import MapLibre
import UIKit

// Update the header file for this class like this:
// cd ios/map_plugin/Sources/map_plugin/
// swiftc -c MapLibreRegistry.swift -module-name maplibre_ios -emit-objc-header-path MapLibreRegistry.h -emit-library -o libmaplibreios.dylib -target arm64-apple-ios18.4-simulator -sdk $(xcrun --sdk iphonesimulator --show-sdk-path) -F ../../../../temp/MapLibre.xcframework/ios-arm64_x86_64-simulator

@objc public class MapLibreRegistry: NSObject {
  private static var mapRegistry: [Int64: AnyObject] = [:]

  // Method to get the map for a given viewId
  @objc public static func getMap(viewId: Int64) -> AnyObject? {
    mapRegistry[viewId]
  }

  // Method to add a map to the registry
  public static func addMap(viewId: Int64, map: AnyObject) {
    mapRegistry[viewId] = map
  }

  // Method to remove a map to the registry
  public static func removeMap(viewId: Int64) {
    mapRegistry.removeValue(forKey: viewId)
  }

  // Warning: Storing Activity in a static field may lead to memory leaks.
  @objc public static var activity: AnyObject?

  // Warning: Storing Context in a static field may lead to memory leaks.
  @objc public static var context: AnyObject?
}

@objc public class Helpers: NSObject {
  @objc public static func addImageToStyle(
    target: NSObject, field: String, expression: NSExpression
  ) {
    do {
      target.setValue(expression, forKey: field)
    } catch {
      print("Couldn't set expression in Helpers.setExpression()")
    }
  }

  @objc public static func setExpression(
    target: NSObject, field: String, expression: NSExpression
  ) {
    do {
      // https://developer.apple.com/documentation/objectivec/nsobject/1418139-setvalue
      try target.setValue(expression, forKey: field)
    } catch {
      print("Couldn't set expression in Helpers.setExpression()")
    }
  }

  @objc public static func parseExpression(
    propertyName: String, expression: String
  ) -> NSExpression? {
    print("\(propertyName): \(expression)")
    do {
      // can't create an Expression using the default method if the data is a hex string
      if propertyName.contains("color"), expression.first == "#" {
        var color = UIColor(hex: expression)
        return NSExpression(forConstantValue: color)
      }
      if expression.starts(with: "[") {
        // can't create an Expression if the data of a literal is an array
        let json = try JSONSerialization.jsonObject(
          with: expression.data(using: .utf8)!,
          options: .fragmentsAllowed
        )
        // print("json: \(json)")
        if let offset = json as? [Any] {
          if offset.count == 2, offset.first is String,
             offset.first as? String == "literal"
          {
            if let vector = offset.last as? [Any] {
              if vector.count == 2 {
                if let x = vector.first as? Double,
                   let y = vector.last as? Double
                {
                  return NSExpression(
                    forConstantValue: NSValue(
                      cgVector: CGVector(dx: x, dy: y)))
                }
              }
            }
          }
        }
        return NSExpression(mglJSONObject: json)
      }
      // parse as a constant value
      return NSExpression(forConstantValue: expression)

    } catch {
      print("Couldn't parse Expression: " + expression)
    }
    return nil
  }
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

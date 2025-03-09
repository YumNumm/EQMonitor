import Flutter
import MapLibre
import UIKit
import os

let logger = Logger(subsystem: "plugins.net.yumnumm.map_plugin", category: "main")

public class MapPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "maplibre_ios", binaryMessenger: registrar.messenger()
    )
    let instance = MapPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)

    // register MapLibre view factory
    let factory = MapPluginViewFactory(messenger: registrar.messenger())
    registrar.register(factory, withId: "plugins.net.yumnumm.map_plugin")
    logger.log("Registered.")
  }

  public func handle(
    _ call: FlutterMethodCall, result: @escaping FlutterResult
  ) {
    logger.log("MapPlugin handle: %{public}s")
    result(FlutterMethodNotImplemented)
  }
}

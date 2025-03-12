import Flutter
import MapLibre

class MapPluginView: NSObject, FlutterPlatformView, MLNMapViewDelegate,
   UIGestureRecognizerDelegate
{
  private var _view: UIView = .init()
  private var _mapView: MLNMapView!
  private var _viewId: Int64
  private var _methodChannel: FlutterMethodChannel!

  init(
    frame _: CGRect,
    viewId: Int64,
    binaryMessenger: FlutterBinaryMessenger
  ) {
    print("### init new MapViewDelegate ### \(viewId) ###")

    var channelSuffix = String(viewId)
    _viewId = viewId
    super.init()

    // MethodChannelの初期化
    _methodChannel = FlutterMethodChannel(
      name: "plugins.net.yumnumm.map_plugin/map_\(viewId)",
      binaryMessenger: binaryMessenger
    )

    self._mapView = MLNMapView(frame: self._view.bounds)
    MapLibreRegistry.addMap(viewId: viewId, map: self._mapView)
    self._mapView.autoresizingMask = [
      .flexibleWidth, .flexibleHeight,
    ]
    self._view.addSubview(self._mapView)
    self._mapView.delegate = self
  }


  func dispose() throws {
    print("### dispose MapLibre view ### \(_viewId) ###")
    MapLibreRegistry.removeMap(viewId: _viewId)
    _mapView.removeFromSuperview()
    _mapView.delegate = nil
    _mapView = nil
    _view.removeFromSuperview()
  }

  func view() -> UIView {
    _view
  }

  // MLNMapViewDelegate method called when map has finished loading
  func mapView(_ mapView: MLNMapView, didFinishLoading style: MLNStyle) {
    // // setCamera() can only be used after the map did finish loading
    // var camera = _mapView.camera
    // camera.pitch = _mapOptions!.pitch
    // _mapView.setCamera(camera, animated: false)

    _mapView = mapView

    // Dartに通知
    _methodChannel.invokeMethod("onStyleLoaded", arguments: nil)
    print("mapView didFinishLoading, called onStyleLoaded")
  }

  func mapView(_: MLNMapView, regionDidChangeAnimated _: Bool) {
    // Dartに通知
    _methodChannel.invokeMethod("onCameraMoved", arguments: nil)
  }
}

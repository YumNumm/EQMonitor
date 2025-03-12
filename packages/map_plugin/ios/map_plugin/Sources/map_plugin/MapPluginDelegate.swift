import Flutter
import MapLibre

typealias StyleLoadedCallback = @convention(c) (Int64) -> Void

class MapPluginView: NSObject, FlutterPlatformView, MLNMapViewDelegate,
   UIGestureRecognizerDelegate
{
  private var _view: UIView = .init()
  private var _mapView: MLNMapView!
  private var _viewId: Int64
  private var _styleLoadedCallback: StyleLoadedCallback?

  init(
    frame _: CGRect,
    viewId: Int64,
    binaryMessenger: FlutterBinaryMessenger,
    styleLoadedCallback: StyleLoadedCallback?
  ) {
    print("### init new MapViewDelegate ### \(viewId) ###")

    var channelSuffix = String(viewId)
    _viewId = viewId
    super.init()
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
  func mapView(_ mapView: MLNMapView, didFinishLoading _: MLNStyle) {
    // // setCamera() can only be used after the map did finish loading
    // var camera = _mapView.camera
    // camera.pitch = _mapOptions!.pitch
    // _mapView.setCamera(camera, animated: false)

    _mapView = mapView
    // print("mapView didFinishLoading, call onStyleLoaded")
    // _flutterApi.onStyleLoaded { _ in }

    // コールバックがあれば、メインスレッドで呼び出す
    if let callback = _styleLoadedCallback {
      logger.log("### call styleLoadedCallback ### \(self._viewId) ###")
      DispatchQueue.main.async {
        callback(self._viewId)
      }
    }
  }

  func mapView(_: MLNMapView, regionDidChangeAnimated _: Bool) {
    // onCameraMoved()
  }
}

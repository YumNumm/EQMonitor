import Flutter
import MapLibre

class MapPluginView: NSObject, FlutterPlatformView, MLNMapViewDelegate,
  MapLibreHostApi, UIGestureRecognizerDelegate
{
  private var _view: UIView = .init()
  private var _mapView: MLNMapView!
  private var _viewId: Int64

    init(
    frame _: CGRect,
    viewId: Int64,
    binaryMessenger: FlutterBinaryMessenger
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
}

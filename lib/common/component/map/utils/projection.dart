import 'package:eqmonitor/common/component/map/utils/web_mercator_projection.dart';
import 'package:lat_lng/lat_lng.dart';

abstract class Projection {
  const Projection();
  GlobalPoint project(LatLng latLng);
  LatLng unproject(GlobalPoint point);
}

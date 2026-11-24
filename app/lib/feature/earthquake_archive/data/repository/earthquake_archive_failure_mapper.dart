import 'package:eqmonitor/feature/auth/data/model/auth_failure.dart';
import 'package:eqmonitor/feature/earthquake_archive/data/model/earthquake_archive_exception.dart';

final class const EarthquakeArchiveFailureMapper() {
  EarthquakeArchiveException map(AuthFailure failure) =>
      EarthquakeArchiveException(switch ((failure.kind, failure.statusCode)) {
        (.sessionRequired || .unauthorized, _) => .signedOut,
        (_, 403) => .forbidden,
        (_, 404) => .notFound,
        (_, 502 || 503) => .unavailable,
        (.network || .timeout, _) => .network,
        _ => .unknown,
      });
}

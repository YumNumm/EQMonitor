import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';

class const HypocenterArchiveProbeFailure({
  required final HypocenterArchive archive,
  required final HypocenterApiException exception,
});

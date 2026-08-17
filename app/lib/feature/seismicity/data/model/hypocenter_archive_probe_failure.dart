import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';

class HypocenterArchiveProbeFailure {
  const new({
    required this.archive,
    required this.exception,
  });

  final HypocenterArchive archive;
  final HypocenterApiException exception;
}

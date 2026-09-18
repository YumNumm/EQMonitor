const downloadApiControlSource = '''
import 'dart:io';
import 'package:eqmonitor/feature/earthquake_history/data/data_source/estimated_intensity_archive_http_data_source.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';

Future<EstimatedIntensityArchiveDownloadResult> download(
  EstimatedIntensityArchiveDescriptor descriptor,
) => const EstimatedIntensityArchiveHttpDataSource().download(
  descriptor: descriptor,
  temporaryDirectory: Directory.systemTemp,
  limits: EstimatedIntensityArchiveDownloadLimits(
    maxArchiveBytes: 1,
    connectTimeout: const Duration(seconds: 1),
    headerTimeout: const Duration(seconds: 1),
    idleTimeout: const Duration(seconds: 1),
    totalTimeout: const Duration(seconds: 1),
  ),
);

void main() {}
''';

const uncheckedVerifiedConstructorSource = '''
import 'dart:io';
import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_download.dart';

void main() {
  VerifiedEstimatedIntensityArchiveDownload(
    eventId: '20260823020050',
    sha256: 'forged',
    file: File('forged.part'),
    sizeBytes: 1,
  );
}
''';

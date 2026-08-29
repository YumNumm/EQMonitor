import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';

final class EstimatedIntensityArchiveDescriptorTestSupport {
  const new();

  static const eventId = '20260823020050';
  static const allowedHost = 'tiles.example.test';
  static const validator = EstimatedIntensityArchiveDescriptorValidator();

  String get sha256 => 'a' * 64;
  String get otherSha256 => 'b' * 64;
  String get validUrl => 'https://$allowedHost/ixac41/$eventId/$sha256.pmtiles';
  EstimatedIntensityArchiveUrlPolicy get policy =>
      EstimatedIntensityArchiveUrlPolicy(
        allowedHosts: const {allowedHost},
        maxArchiveBytes: 2_000_000,
      );

  EstimatedIntensityArchiveDescriptorInput input({
    String? url,
    int sizeBytes = 1_000_000,
    String? digest,
  }) => EstimatedIntensityArchiveDescriptorInput(
    url: url ?? validUrl,
    sizeBytes: sizeBytes,
    sha256: digest ?? sha256,
  );
}

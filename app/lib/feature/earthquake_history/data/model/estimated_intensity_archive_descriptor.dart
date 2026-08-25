part 'estimated_intensity_archive_failure.dart';
part '../logic/estimated_intensity_archive_descriptor_validator.dart';
part '../logic/estimated_intensity_archive_url_path_validator.dart';
part '../logic/estimated_intensity_archive_url_validator.dart';

final _estimatedIntensityEventIdPattern = RegExp(r'^[0-9]{14}$');
final _estimatedIntensitySha256Pattern = RegExp(r'^[0-9a-f]{64}$');

/// Generated API model から pure validator へ渡す package-neutral input。
///
/// 未検証のため、download や map package へ直接渡してはならない。
final class EstimatedIntensityArchiveDescriptorInput {
  const new({
    required this.url,
    required this.sizeBytes,
    required this.sha256,
  });

  final String url;
  final int sizeBytes;
  final String sha256;

  @override
  String toString() =>
      'EstimatedIntensityArchiveDescriptorInput('
      'sizeBytes: $sizeBytes, identity: redacted)';
}

/// URL、event、size、digest の整合を検証済みの archive descriptor。
///
/// `EstimatedIntensityArchiveDescriptorValidator` が検証後に生成し、downstream は
/// この値を未検証 API input の代わりに使用する。
final class EstimatedIntensityArchiveDescriptor {
  // ignore: unnecessary_type_name_in_constructor
  const EstimatedIntensityArchiveDescriptor._({
    required this.eventId,
    required this.url,
    required this.sizeBytes,
    required this.sha256,
  });

  final String eventId;
  final Uri url;
  final int sizeBytes;
  final String sha256;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EstimatedIntensityArchiveDescriptor &&
          eventId == other.eventId &&
          url == other.url &&
          sizeBytes == other.sizeBytes &&
          sha256 == other.sha256;

  @override
  int get hashCode => Object.hash(eventId, url, sizeBytes, sha256);

  @override
  String toString() =>
      'EstimatedIntensityArchiveDescriptor('
      'eventId: $eventId, sizeBytes: $sizeBytes, identity: redacted)';
}

/// Descriptor URL と archive size に対する caller-owned policy。
final class EstimatedIntensityArchiveUrlPolicy {
  new({
    required Set<String> allowedHosts,
    required this.maxArchiveBytes,
  }) : allowedHosts = Set.unmodifiable(allowedHosts) {
    if (allowedHosts.isEmpty) {
      throw ArgumentError.value(
        allowedHosts,
        'allowedHosts',
        'must not be empty',
      );
    }
    if (maxArchiveBytes <= 0) {
      throw ArgumentError.value(
        maxArchiveBytes,
        'maxArchiveBytes',
        'must be positive',
      );
    }
  }

  /// `Uri.host` と suffix ではなく完全一致で比較する hostname の集合。
  final Set<String> allowedHosts;

  /// Descriptor が宣言できる archive size の上限。既定値は持たない。
  final int maxArchiveBytes;
}

import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_descriptor_test_support.dart';

void main() {
  const support = EstimatedIntensityArchiveDescriptorTestSupport();
  final eventId = EstimatedIntensityArchiveDescriptorTestSupport.eventId;
  final host = EstimatedIntensityArchiveDescriptorTestSupport.allowedHost;
  final sha256 = support.sha256;

  final cases = <({String name, String url, EstimatedIntensityArchiveFailure failure})>[
    (
      name: 'double slash',
      url: 'https://$host/ixac41//$eventId/$sha256.pmtiles',
      failure: EstimatedIntensityArchiveFailure.invalidPath,
    ),
    (
      name: 'trailing slash',
      url: '${support.validUrl}/',
      failure: EstimatedIntensityArchiveFailure.invalidPath,
    ),
    (
      name: 'dot segment',
      url: 'https://$host/ixac41/./$eventId/$sha256.pmtiles',
      failure: EstimatedIntensityArchiveFailure.nonCanonicalUrl,
    ),
    (
      name: 'encoded slash',
      url:
          'https://$host/ixac41/${eventId.substring(0, 13)}%2F0/$sha256.pmtiles',
      failure: EstimatedIntensityArchiveFailure.invalidPath,
    ),
    (
      name: 'encoded backslash',
      url:
          'https://$host/ixac41/${eventId.substring(0, 13)}%5C0/$sha256.pmtiles',
      failure: EstimatedIntensityArchiveFailure.invalidPath,
    ),
    (
      name: 'lowercase encoded separator',
      url:
          'https://$host/ixac41/${eventId.substring(0, 13)}%5c0/$sha256.pmtiles',
      failure: EstimatedIntensityArchiveFailure.invalidPath,
    ),
    (
      name: 'unreserved percent alias',
      url: 'https://$host/%69xac41/$eventId/$sha256.pmtiles',
      failure: EstimatedIntensityArchiveFailure.nonCanonicalUrl,
    ),
    (
      name: 'wrong event',
      url: 'https://$host/ixac41/20260823020051/$sha256.pmtiles',
      failure: EstimatedIntensityArchiveFailure.eventIdMismatch,
    ),
    (
      name: 'extra path segment',
      url: 'https://$host/ixac41/$eventId/$sha256.pmtiles/extra',
      failure: EstimatedIntensityArchiveFailure.invalidPath,
    ),
  ];

  for (final testCase in cases) {
    test('rejects ${testCase.name}', () {
      final result = EstimatedIntensityArchiveDescriptorTestSupport.validator
          .validate(
            eventId: eventId,
            input: support.input(url: testCase.url),
            policy: support.policy,
          );

      expect(result, isA<EstimatedIntensityArchiveValidationInvalid>());
      expect(
        (result as EstimatedIntensityArchiveValidationInvalid).failure,
        testCase.failure,
      );
    });
  }
}

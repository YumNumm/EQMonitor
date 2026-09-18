import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_descriptor_test_support.dart';

void main() {
  const support = EstimatedIntensityArchiveDescriptorTestSupport();
  final eventId = EstimatedIntensityArchiveDescriptorTestSupport.eventId;
  final host = EstimatedIntensityArchiveDescriptorTestSupport.allowedHost;

  final cases = <({String name, String url, EstimatedIntensityArchiveFailure failure})>[
    (
      name: 'non-HTTPS scheme',
      url: 'http://$host/ixac41/$eventId/${support.sha256}.pmtiles',
      failure: EstimatedIntensityArchiveFailure.insecureScheme,
    ),
    (
      name: 'userinfo',
      url: 'https://user@$host/ixac41/$eventId/${support.sha256}.pmtiles',
      failure: EstimatedIntensityArchiveFailure.userInfoNotAllowed,
    ),
    (
      name: 'query',
      url: '${support.validUrl}?token=value',
      failure: EstimatedIntensityArchiveFailure.queryNotAllowed,
    ),
    (
      name: 'fragment',
      url: '${support.validUrl}#fragment',
      failure: EstimatedIntensityArchiveFailure.fragmentNotAllowed,
    ),
    (
      name: 'non-default port',
      url: 'https://$host:8443/ixac41/$eventId/${support.sha256}.pmtiles',
      failure: EstimatedIntensityArchiveFailure.nonDefaultPort,
    ),
    (
      name: 'host outside allowlist',
      url:
          'https://other.example.test/ixac41/$eventId/${support.sha256}.pmtiles',
      failure: EstimatedIntensityArchiveFailure.disallowedHost,
    ),
    (
      name: 'allowlist suffix spoof',
      url:
          'https://$host.attacker.test/ixac41/$eventId/${support.sha256}.pmtiles',
      failure: EstimatedIntensityArchiveFailure.disallowedHost,
    ),
    (
      name: 'malformed absolute URL',
      url: 'https://',
      failure: EstimatedIntensityArchiveFailure.invalidUrl,
    ),
    (
      name: 'missing authority',
      url: 'https:ixac41/$eventId/${support.sha256}.pmtiles',
      failure: EstimatedIntensityArchiveFailure.missingAuthority,
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

import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_descriptor_test_support.dart';

void main() {
  const support = EstimatedIntensityArchiveDescriptorTestSupport();

  test('accepts a canonical descriptor', () {
    final result = EstimatedIntensityArchiveDescriptorTestSupport.validator
        .validate(
          eventId: EstimatedIntensityArchiveDescriptorTestSupport.eventId,
          input: support.input(),
          policy: support.policy,
        );

    expect(result, isA<EstimatedIntensityArchiveValidationValid>());
    final valid = result as EstimatedIntensityArchiveValidationValid;
    expect(
      valid.descriptor.eventId,
      EstimatedIntensityArchiveDescriptorTestSupport.eventId,
    );
    expect(valid.descriptor.url, Uri.parse(support.validUrl));
    expect(valid.descriptor.sizeBytes, 1_000_000);
    expect(valid.descriptor.sha256, support.sha256);
  });

  test('accepts explicit HTTPS port 443', () {
    final url =
        'https://${EstimatedIntensityArchiveDescriptorTestSupport.allowedHost}:443/'
        'ixac41/${EstimatedIntensityArchiveDescriptorTestSupport.eventId}/'
        '${support.sha256}.pmtiles';
    final result = EstimatedIntensityArchiveDescriptorTestSupport.validator
        .validate(
          eventId: EstimatedIntensityArchiveDescriptorTestSupport.eventId,
          input: support.input(url: url),
          policy: support.policy,
        );

    final descriptor =
        (result as EstimatedIntensityArchiveValidationValid).descriptor;
    expect(descriptor.url, Uri.parse(url));
  });

  test('distinguishes an absent API descriptor from an invalid one', () {
    final result = EstimatedIntensityArchiveDescriptorTestSupport.validator
        .validate(
          eventId: EstimatedIntensityArchiveDescriptorTestSupport.eventId,
          input: null,
          policy: support.policy,
        );

    expect(result, isA<EstimatedIntensityArchiveValidationMissing>());
  });

  test('failure text retains neither the raw URL nor SHA-256', () {
    final rawUrl = '${support.validUrl}?secret=value';
    final result = EstimatedIntensityArchiveDescriptorTestSupport.validator
        .validate(
          eventId: EstimatedIntensityArchiveDescriptorTestSupport.eventId,
          input: support.input(url: rawUrl),
          policy: support.policy,
        );

    expect(result.toString(), isNot(contains(rawUrl)));
    expect(result.toString(), isNot(contains(support.sha256)));
  });
}

import 'package:eqmonitor/feature/earthquake_history/data/model/estimated_intensity_archive_descriptor.dart';
import 'package:flutter_test/flutter_test.dart';

import 'estimated_intensity_archive_descriptor_test_support.dart';

void main() {
  const support = EstimatedIntensityArchiveDescriptorTestSupport();

  for (final invalidSize in [0, -1]) {
    test('rejects non-positive size $invalidSize', () {
      final result = EstimatedIntensityArchiveDescriptorTestSupport.validator
          .validate(
            eventId: EstimatedIntensityArchiveDescriptorTestSupport.eventId,
            input: support.input(sizeBytes: invalidSize),
            policy: support.policy,
          );

      expect(
        (result as EstimatedIntensityArchiveValidationInvalid).failure,
        EstimatedIntensityArchiveFailure.invalidSize,
      );
    });
  }

  test('rejects a size above the caller cap', () {
    final result = EstimatedIntensityArchiveDescriptorTestSupport.validator
        .validate(
          eventId: EstimatedIntensityArchiveDescriptorTestSupport.eventId,
          input: support.input(sizeBytes: 2_000_001),
          policy: support.policy,
        );

    expect(
      (result as EstimatedIntensityArchiveValidationInvalid).failure,
      EstimatedIntensityArchiveFailure.archiveTooLarge,
    );
  });

  test('takes a defensive copy of the exact host allowlist', () {
    final hosts = {EstimatedIntensityArchiveDescriptorTestSupport.allowedHost};
    final policy = EstimatedIntensityArchiveUrlPolicy(
      allowedHosts: hosts,
      maxArchiveBytes: 1,
    );

    hosts.add('attacker.test');

    expect(policy.allowedHosts, {
      EstimatedIntensityArchiveDescriptorTestSupport.allowedHost,
    });
    expect(
      () => policy.allowedHosts.add('attacker.test'),
      throwsUnsupportedError,
    );
  });

  test('rejects an empty allowlist and non-positive byte cap', () {
    expect(
      () => EstimatedIntensityArchiveUrlPolicy(
        allowedHosts: const {},
        maxArchiveBytes: 1,
      ),
      throwsArgumentError,
    );
    expect(
      () => EstimatedIntensityArchiveUrlPolicy(
        allowedHosts: const {
          EstimatedIntensityArchiveDescriptorTestSupport.allowedHost,
        },
        maxArchiveBytes: 0,
      ),
      throwsArgumentError,
    );
  });
}

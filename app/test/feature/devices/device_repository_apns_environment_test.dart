import 'package:eqmonitor/feature/devices/data/provider/apns_environment.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  test('apnsEnvironmentProvider follows production iOS entitlements', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(
      container.read(apnsEnvironmentProvider),
      api.ApnsEnvironment.production,
    );
  });
}

import 'package:eqmonitor/core/data/preferences/shared/shared_preferences.dart';
import 'package:eqmonitor/core/data/preferences/shared/shared_preferences_key.dart';
import 'package:eqmonitor/feature/beta_testing/data/notifier/beta_testing_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> _container({
  Map<String, Object> initial = const {},
}) async {
  SharedPreferences.setMockInitialValues(initial);
  final prefs = await SharedPreferences.getInstance();
  return ProviderContainer(
    overrides: [sharedPreferencesProvider.overrideWithValue(AsyncData(prefs))],
  );
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('BetaTestingAgreed', () {
    test('loads saved agreement after the provider has no listeners', () async {
      final container = await _container(
        initial: {SharedPreferencesKey.betaTestingAgreed.key: true},
      );
      addTearDown(container.dispose);

      expect(await container.read(betaTestingAgreedProvider.future), isTrue);

      await container.pump();

      expect(container.read(betaTestingAgreedProvider).value, isTrue);
    });

    test(
      'agree persists agreement and keeps redirect-readable state',
      () async {
        final container = await _container();
        addTearDown(container.dispose);

        await container.read(betaTestingAgreedProvider.notifier).agree();
        await container.pump();

        expect(container.read(betaTestingAgreedProvider).value, isTrue);
        final prefs = await container.read(sharedPreferencesProvider.future);
        expect(
          prefs.getBool(SharedPreferencesKey.betaTestingAgreed.key),
          isTrue,
        );
      },
    );
  });
}

import 'package:eqmonitor/feature/devices/data/repository/device_registration_generation_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  test('registration generationを再生成後も復元する', () async {
    final generated = <String>['registration-1'];
    final first = DeviceRegistrationGenerationRepository(
      preferences: SharedPreferencesAsync(),
      generate: () => generated.removeAt(0),
    );

    expect(await first.readOrCreate(), 'registration-1');

    final recreated = DeviceRegistrationGenerationRepository(
      preferences: SharedPreferencesAsync(),
      generate: () => 'must-not-be-used',
    );
    expect(await recreated.readOrCreate(), 'registration-1');
  });

  test('credential変更前のrotateで新しいgenerationを永続化する', () async {
    final generated = <String>['registration-1', 'registration-2'];
    final repository = DeviceRegistrationGenerationRepository(
      preferences: SharedPreferencesAsync(),
      generate: () => generated.removeAt(0),
    );
    expect(await repository.readOrCreate(), 'registration-1');

    await repository.rotate();

    expect(await repository.readOrCreate(), 'registration-2');
  });
}

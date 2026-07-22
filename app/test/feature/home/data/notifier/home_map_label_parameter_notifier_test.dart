import 'package:eqmonitor/core/provider/log/talker.dart' as talker_lib;
import 'package:eqmonitor/feature/home/data/notifier/home_map_label_parameter_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  talker_lib.talker = Talker();

  test('keeps legacy labels enabled when a saved value is malformed', () async {
    SharedPreferences.setMockInitialValues(<String, Object>{
      'home_map_label_parameter': 'not json',
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final parameter = await container.read(
      homeMapLabelParameterProvider.future,
    );

    expect(parameter.showRegionLabel, isTrue);
    expect(parameter.showCityLabel, isTrue);
  });
}

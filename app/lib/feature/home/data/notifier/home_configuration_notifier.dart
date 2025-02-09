import 'dart:convert';
import 'dart:developer';

import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:eqmonitor/feature/home/data/model/home_configuration_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_configuration_notifier.g.dart';

@riverpod
class HomeConfigurationNotifier extends _$HomeConfigurationNotifier {
  @override
  HomeConfigurationModel build() {
    final saved = load();
    if (saved != null) {
      return saved;
    }
    return const HomeConfigurationModel();
  }

  static const _key = 'home_configuration';

  HomeConfigurationModel? load() {
    try {
      final jsonString = ref.read(sharedPreferencesProvider).getString(_key);
      if (jsonString == null) {
        return null;
      }
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return HomeConfigurationModel.fromJson(json);
    } on Exception catch (e) {
      log('load home configuration failed: $e');
      return null;
    }
  }

  Future<void> save(HomeConfigurationModel configuration) async {
    state = configuration;
    await ref.read(sharedPreferencesProvider).setString(
          _key,
          jsonEncode(configuration.toJson()),
        );
  }
}

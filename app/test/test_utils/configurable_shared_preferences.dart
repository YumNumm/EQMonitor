import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurableSharedPreferences extends Mock implements SharedPreferences {
  ConfigurableSharedPreferences({
    this.boolValue,
    this.setBoolResult = true,
    this.setBoolError,
  });

  final bool? boolValue;
  final bool setBoolResult;
  final Object? setBoolError;

  @override
  bool? getBool(String key) => boolValue;

  @override
  Future<bool> setBool(String key, bool value) {
    final error = setBoolError;
    return error != null
        ? Future<bool>.error(error)
        : Future<bool>.value(setBoolResult);
  }
}

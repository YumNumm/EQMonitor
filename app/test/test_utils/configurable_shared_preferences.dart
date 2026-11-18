import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfigurableSharedPreferences({
  final bool? boolValue,
  final bool setBoolResult = true,
  final Object? setBoolError,
}) extends Mock implements SharedPreferences {
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

import 'dart:convert';

import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/config/theme/intensity_color/model/intensity_color_model.dart';
import 'package:eqmonitor/core/provider/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'intensity_color_provider.g.dart';

@Riverpod(keepAlive: true)
class IntensityColor extends _$IntensityColor {
  @override
  IntensityColorModel build() {
    final result = load();
    if (result != null) {
      return result;
    }
    return IntensityColorModel.eqmonitor();
  }

  static const _key = 'intensity_color';

  Future<void> update(IntensityColorModel model) async {
    state = model;
    await ref
        .read(sharedPreferencesProvider)
        .setString(_key, jsonEncode(model.toJson()));
  }

  String exportAsJsonString() => jsonEncode(state.toJson());

  Future<Result<void, IntensityColorImportException>> importFromJsonString(
    String rawJson,
  ) async {
    try {
      final decoded = jsonDecode(rawJson);
      if (decoded is! Map<String, dynamic>) {
        return const Failure(
          IntensityColorImportException('JSONの形式が不正です'),
        );
      }
      final model = IntensityColorModel.fromJson(decoded);
      await update(model);
      return const Success(null);
    } on FormatException catch (_) {
      return const Failure(IntensityColorImportException('JSONの解析に失敗しました'));
    } on Exception catch (_) {
      return const Failure(
        IntensityColorImportException('震度配色JSONの内容が不正です'),
      );
    }
  }

  IntensityColorModel? load() {
    final value = ref.read(sharedPreferencesProvider).getString(_key);
    if (value == null) {
      return null;
    }
    try {
      return IntensityColorModel.fromJson(
        jsonDecode(value) as Map<String, dynamic>,
      );
    } on Exception catch (_) {
      return null;
    }
  }
}

final class IntensityColorImportException implements Exception {
  const IntensityColorImportException(this.message);
  final String message;
}

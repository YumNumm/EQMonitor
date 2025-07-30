import 'dart:developer';

import 'package:eqapi_types/eqapi_types.dart';
import 'package:eqmonitor/core/api/eq_api.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tsunami_provider.g.dart';

/// 津波情報のサマリーを取得するプロバイダー
@Riverpod(keepAlive: true)
class TsunamiSummary extends _$TsunamiSummary {
  @override
  FutureOr<TsunamiSummaryResponse> build() async {
    return _fetch();
  }

  Future<TsunamiSummaryResponse> _fetch() async {
    try {
      log('津波情報を取得中...');
      final eqApi = ref.read(eqApiProvider);
      final response = await eqApi.v1.getTsunamiSummary();
      log('津波情報取得成功: ${response.data.data.length} items');
      return response.data;
    } catch (e, stackTrace) {
      log('津波情報取得失敗: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  /// 津波情報を強制的に再取得する
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetch());
  }
}
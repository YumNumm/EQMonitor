import 'package:collection/collection.dart';
import 'package:eqmonitor/core/provider/jma_parameter/jma_parameter.dart';
import 'package:eqmonitor/feature/earthquake_history/data/model/earthquake_history_parameter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'region_name_resolver.g.dart';

/// 地域コードから名称を解決する。
class RegionNameResolver {
  const RegionNameResolver();

  /// 見つからなければ null。
  ///
  /// [parameter] JMA 地震パラメータ
  /// [searchType] 検索対象の地域種別
  /// [code] 地域コード
  String? resolve({
    required EarthquakeParameter parameter,
    required RegionSearchType searchType,
    required String code,
  }) {
    switch (searchType) {
      case RegionSearchType.prefecture:
        return parameter.prefectures
            .firstWhereOrNull((p) => p.code == code)
            ?.name
            .ja;
      case RegionSearchType.region:
        return parameter.prefectures
            .expand((p) => p.regions)
            .firstWhereOrNull((r) => r.code == code)
            ?.name
            .ja;
      case RegionSearchType.city:
        return parameter.prefectures
            .expand((p) => p.regions)
            .expand((r) => r.cities)
            .firstWhereOrNull((c) => c.code == code)
            ?.name
            .ja;
      case RegionSearchType.station:
        return parameter.prefectures
            .expand((p) => p.regions)
            .expand((r) => r.cities)
            .expand((c) => c.stations)
            .firstWhereOrNull((s) => s.code == code)
            ?.name
            .ja;
    }
  }
}

/// AsyncValue でラップした riverpod プロバイダ(UI 用)。
///
/// [searchType] 検索対象の地域種別
/// [code] 地域コード
@riverpod
Future<String?> regionName(
  Ref ref,
  RegionSearchType searchType,
  String code,
) async {
  final jmaParam = await ref.watch(jmaParameterProvider.future);
  return const RegionNameResolver().resolve(
    parameter: jmaParam.earthquake,
    searchType: searchType,
    code: code,
  );
}

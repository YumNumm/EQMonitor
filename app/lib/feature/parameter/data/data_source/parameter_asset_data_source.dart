import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_asset_data_source.g.dart';

@Riverpod(keepAlive: true)
ParameterAssetDataSource parameterAssetDataSource(Ref ref) =>
    ParameterAssetDataSource(
      assetPackRepository: ref.watch(assetPackRepositoryProvider),
    );

/// Reads Parameter manifest/data JSON from the active Asset Pack (via
/// [AssetPackRepository]). A downloaded pack that fails verification or
/// parsing falls back to the pack bundled with the app; there is no fake-data
/// fallback.
final class ParameterAssetDataSource {
  const new({
    required AssetPackRepository assetPackRepository,
  }) : _assetPackRepository = assetPackRepository;

  final AssetPackRepository _assetPackRepository;

  /// manifest と全種別のパラメーター JSON を同じ Pack から読み、[parse] に渡す。
  ///
  /// [parse] の失敗もダウンロード版から同梱版へのフォールバック対象になる。
  Future<T> readParameters<T>(
    T Function(
      AssetPackManifest manifest,
      Map<ParameterType, String> parameterJsonByType,
    )
    parse,
  ) => _assetPackRepository.readFromActivePack((reader) async {
    final manifest = await reader.readManifest();
    final parameterJsonByType = <ParameterType, String>{};
    for (final type in ParameterType.values) {
      final file = await reader.resolveAsset(type.toAssetPackAssetId);
      parameterJsonByType[type] = await file.readAsString();
    }
    return parse(manifest, parameterJsonByType);
  });
}

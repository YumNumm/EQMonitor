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

/// Reads Parameter manifest/data JSON from the platform Asset Pack (via
/// [AssetPackRepository]). There is no bundled/fake-data fallback: if the
/// pack isn't ready, [AssetPackNotReadyException] propagates to the
/// caller.
final class ParameterAssetDataSource {
  const ParameterAssetDataSource({
    required AssetPackRepository assetPackRepository,
  }) : _assetPackRepository = assetPackRepository;

  final AssetPackRepository _assetPackRepository;

  Future<AssetPackManifest> readManifest() => _assetPackRepository.readManifest();

  Future<String> readParameterJson(ParameterType type) async {
    final file = await _assetPackRepository.resolveAsset(
      type.toAssetPackAssetId,
    );
    return file.readAsString();
  }
}

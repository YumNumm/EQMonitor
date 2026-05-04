import 'package:eqmonitor/feature/parameter/data/model/common/parameter_type.dart';
import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parameter_asset_data_source.g.dart';

@Riverpod(keepAlive: true)
ParameterAssetDataSource parameterAssetDataSource(Ref ref) =>
    ParameterAssetDataSource(bundle: rootBundle);

final class ParameterAssetDataSource {
  const ParameterAssetDataSource({
    required AssetBundle bundle,
  }) : _bundle = bundle;

  final AssetBundle _bundle;

  Future<String> readManifestJson() =>
      _bundle.loadString('assets/parameters/manifest.json');

  Future<String> readParameterJson(ParameterType type) =>
      _bundle.loadString('assets/parameters/${type.pathSegment}.json');
}

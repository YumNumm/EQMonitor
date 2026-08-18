import 'package:assets_util/assets_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_pack_debug_provider.g.dart';

/// Reads native diagnostics for the app-bundled Asset Pack.
@riverpod
Future<AssetPackDiagnostics> assetPackDiagnostics(Ref ref) =>
    AssetsUtil.diagnosePack();

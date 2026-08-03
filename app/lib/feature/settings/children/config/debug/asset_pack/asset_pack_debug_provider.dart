import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_pack_debug_provider.g.dart';

/// Builds [AssetPackDebugInfo] for the Asset Pack debug page.
@riverpod
Future<AssetPackDebugInfo> assetPackDebugInfo(Ref ref) =>
    ref.watch(assetPackDebugRepositoryProvider).diagnose();

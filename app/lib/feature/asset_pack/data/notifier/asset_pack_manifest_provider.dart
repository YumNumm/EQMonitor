import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_pack_manifest_provider.g.dart';

/// Reads the Asset Pack `manifest.json` via [AssetPackRepository].
///
/// Errors with [AssetPackNotReadyException] (surfaced as `AsyncError`) when
/// the pack is not downloaded yet or is missing/corrupt — callers such as the
/// settings footer should treat that as an informational "未取得" state rather
/// than a hard error.
@riverpod
Future<AssetPackManifest> assetPackManifest(Ref ref) async {
  final repository = ref.watch(assetPackRepositoryProvider);
  return repository.readManifest();
}

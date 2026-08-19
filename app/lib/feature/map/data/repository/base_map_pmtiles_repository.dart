import 'dart:io';

import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'base_map_pmtiles_repository.g.dart';

@Riverpod(keepAlive: true)
BaseMapPmtilesRepository baseMapPmtilesRepository(Ref ref) =>
    BaseMapPmtilesRepository(
      assetPackRepository: ref.watch(assetPackRepositoryProvider),
    );

class BaseMapPmtilesRepository {
  new({
    required AssetPackRepository assetPackRepository,
    bool Function()? isWeb,
    bool Function()? isSupportedPlatform,
  }) : _assetPackRepository = assetPackRepository,
       _isWeb = isWeb ?? (() => kIsWeb),
       _isSupportedPlatform =
           isSupportedPlatform ??
           (() => Platform.isIOS || Platform.isAndroid || Platform.isMacOS);

  final AssetPackRepository _assetPackRepository;

  /// DI seam for [kIsWeb] so the Web error path can be exercised from a
  /// plain VM unit test (Flutter's `kIsWeb` is a compile-time constant
  /// that's always `false` under `flutter test`).
  final bool Function() _isWeb;

  /// DI seam for the iOS/Android/macOS platform check, so tests don't
  /// depend on the host OS running `flutter test` (e.g. CI runs on
  /// Ubuntu, where `Platform.isIOS/isAndroid/isMacOS` are all `false`).
  final bool Function() _isSupportedPlatform;

  /// Returns a MapLibre vector source URI for the base map PMTiles.
  ///
  /// iOS/Android/macOS: `pmtiles://file://...` resolved via
  /// [AssetPackRepository] (verified R2 download, with the bundled
  /// `platform` directory as fallback).
  ///
  /// Throws [UnsupportedError] on Web (地図機能は Web 未サポート) and on any
  /// other platform without an Asset Pack backend.
  Future<String> resolveSourceUri() async {
    if (_isWeb()) {
      throw UnsupportedError('地図機能は Web ではサポートされていません');
    }
    if (!_isSupportedPlatform()) {
      throw UnsupportedError(
        '地図機能は Asset Pack 未対応プラットフォームではサポートされていません',
      );
    }

    final file = await _assetPackRepository.resolveAsset(
      AssetPackAssetId.baseMapPmtiles,
    );
    return 'pmtiles://${Uri.file(file.path)}';
  }
}

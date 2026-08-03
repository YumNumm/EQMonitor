import 'package:assets_util/assets_util.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_provider.dart';
import 'package:eqmonitor/feature/settings/children/config/debug/asset_pack/asset_pack_debug_repository.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_pack_debug_action.g.dart';

@riverpod
AssetPackDebugAction assetPackDebugAction(Ref ref) => AssetPackDebugAction();

@riverpod
class AssetPackLastUpdateResult extends _$AssetPackLastUpdateResult {
  @override
  AssetPackUpdateResult? build() => null;

  void setResult(AssetPackUpdateResult result) => state = result;
}

class AssetPackUpdateCheckException implements Exception {
  const AssetPackUpdateCheckException(this.result);

  final AssetPackUpdateResult result;

  @override
  String toString() =>
      result.nativeError?.description ?? 'Asset Pack update check failed.';
}

class AssetPackDebugAction {
  static final checkForUpdatesMutation = Mutation<AssetPackUpdateResult>();

  Future<void> checkForUpdates(WidgetRef ref, BuildContext context) async {
    try {
      final result = await checkForUpdatesMutation.run(ref, (
        transaction,
      ) async {
        final updateResult = await transaction
            .get(assetPackDebugRepositoryProvider)
            .checkForUpdates();
        if (!updateResult.success) {
          throw AssetPackUpdateCheckException(updateResult);
        }
        return updateResult;
      });
      ref.read(assetPackLastUpdateResultProvider.notifier).setResult(result);
      ref.invalidate(assetPackDebugInfoProvider, asReload: true);
      talker.info(
        '[AssetPack] update check accepted: '
        'updating=${result.updatingIdentifiers}, '
        'removed=${result.removedIdentifiers}',
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('更新確認を実行しました（ダウンロード完了通知ではありません）')),
        );
      }
    } on AssetPackUpdateCheckException catch (error, stackTrace) {
      ref
          .read(assetPackLastUpdateResultProvider.notifier)
          .setResult(error.result);
      talker.error('[AssetPack] update check failed', error, stackTrace);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('更新確認に失敗しました: $error')));
      }
    } on FormatException catch (error, stackTrace) {
      talker.error('[AssetPack] invalid update response', error, stackTrace);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('更新確認結果を解析できません: ${error.message}')),
        );
      }
    } catch (error, stackTrace) {
      talker.error('[AssetPack] unexpected update failure', error, stackTrace);
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('更新確認に失敗しました: $error')));
      }
    }
  }
}

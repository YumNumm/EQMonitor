import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/core/provider/package_info.dart';
import 'package:eqmonitor/feature/asset_pack/data/model/asset_pack_distribution_manifest.dart';
import 'package:eqmonitor/feature/asset_pack/data/notifier/asset_pack_manifest_provider.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_distribution_repository.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_repository.dart';
import 'package:eqmonitor/feature/asset_pack/data/repository/asset_pack_update_installer.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'asset_pack_update_notifier.g.dart';

sealed class AssetPackUpdateState {
  const AssetPackUpdateState();
}

final class AssetPackUpdateIdle extends AssetPackUpdateState {
  const AssetPackUpdateIdle();
}

final class AssetPackUpdateChecking extends AssetPackUpdateState {
  const AssetPackUpdateChecking();
}

final class AssetPackUpdateAvailableState extends AssetPackUpdateState {
  const AssetPackUpdateAvailableState({
    required this.entry,
    required this.changelogEntries,
  });

  final AssetPackDistributionEntry entry;
  final List<AssetPackDistributionEntry> changelogEntries;
}

final class AssetPackUpdateAppRequiredState extends AssetPackUpdateState {
  const AssetPackUpdateAppRequiredState(this.entry);

  final AssetPackDistributionEntry entry;
}

final class AssetPackUpdateInstalling extends AssetPackUpdateState {
  const AssetPackUpdateInstalling({
    required this.entry,
    required this.progress,
  });

  final AssetPackDistributionEntry entry;
  final AssetPackInstallProgress progress;
}

final class AssetPackUpdateCompleted extends AssetPackUpdateState {
  const AssetPackUpdateCompleted(this.version);

  final String version;
}

final class AssetPackUpdateError extends AssetPackUpdateState {
  const AssetPackUpdateError(this.message);

  final String message;
}

@Riverpod(keepAlive: true)
class AssetPackUpdateNotifier extends _$AssetPackUpdateNotifier {
  static final checkMutation = Mutation<void>();
  static final installMutation = Mutation<void>();

  @override
  AssetPackUpdateState build() => const AssetPackUpdateIdle();

  Future<void> check() async {
    if (state is AssetPackUpdateChecking ||
        state is AssetPackUpdateInstalling ||
        state is AssetPackUpdateAvailableState) {
      return;
    }
    state = const AssetPackUpdateChecking();
    try {
      final activeManifest = await ref.read(assetPackManifestProvider.future);
      final repository = await ref.read(
        assetPackDistributionRepositoryProvider.future,
      );
      final result = await repository.checkForUpdate(
        activeVersion: activeManifest.packVersion,
        appVersion: ref.read(packageInfoProvider).version,
      );
      state = switch (result) {
        AssetPackNoUpdate() => const AssetPackUpdateIdle(),
        AssetPackUpdateAvailable(:final manifest, :final entry) =>
          AssetPackUpdateAvailableState(
            entry: entry,
            changelogEntries: manifest.entriesNewerThan(
              activeManifest.packVersion,
            ),
          ),
        AssetPackAppUpdateRequired(:final entry) =>
          AssetPackUpdateAppRequiredState(entry),
      };
    } on Object catch (error, stackTrace) {
      talker.error('[AssetPack] update check failed', error, stackTrace);
      state = const AssetPackUpdateError(
        'Asset Pack の更新情報を確認できませんでした。現在のデータを使用します。',
      );
    }
  }

  Future<void> install(AssetPackDistributionEntry entry) async {
    if (state is AssetPackUpdateInstalling) {
      return;
    }
    try {
      final installer = await ref.read(assetPackUpdateInstallerProvider.future);
      await installer.install(
        entry: entry,
        onProgress: (progress) {
          state = AssetPackUpdateInstalling(entry: entry, progress: progress);
        },
      );
      ref.invalidate(assetPackManifestProvider);
      ref.invalidate(assetPackRepositoryProvider);
      state = AssetPackUpdateCompleted(entry.version);
    } on Object catch (error, stackTrace) {
      talker.error('[AssetPack] update install failed', error, stackTrace);
      state = const AssetPackUpdateError(
        'Asset Pack を更新できませんでした。現在のデータを引き続き使用します。',
      );
    }
  }
}

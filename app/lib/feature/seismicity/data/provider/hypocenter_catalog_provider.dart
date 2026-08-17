import 'package:dio/dio.dart';
import 'package:eqmonitor/core/api/api_client_provider.dart';
import 'package:eqmonitor/core/foundation/result.dart';
import 'package:eqmonitor/core/provider/cached_notifier.dart';
import 'package:eqmonitor/core/provider/log/talker.dart';
import 'package:eqmonitor/feature/seismicity/data/data_source/hypocenter_archive_probe.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/hypocenter_analysis_loader.dart';
import 'package:eqmonitor/feature/seismicity/data/logic/hypocenter_archive_selector.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_analysis_progress.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_analysis_request.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_api_exception.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_archive.dart';
import 'package:eqmonitor/feature/seismicity/data/model/hypocenter_manifest.dart';
import 'package:eqmonitor/feature/seismicity/data/model/seismicity_event.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/hypocenter_analysis_repository.dart';
import 'package:eqmonitor/feature/seismicity/data/repository/hypocenter_manifest_repository.dart';
import 'package:eqmonitor_api/eqmonitor_api.dart' as api;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hypocenter_catalog_provider.g.dart';

@Riverpod(keepAlive: true)
class HypocenterManifestNotifier extends _$HypocenterManifestNotifier
    with CachedNotifier<HypocenterManifest> {
  @override
  Future<HypocenterManifest> build() => cachedBuild();

  @override
  Future<HypocenterManifest> fetch(api.ApiClient client) async {
    final result = await HypocenterManifestRepository(
      client: client.hypocenters,
    ).fetch();
    return switch (result) {
      Success(:final value) => value,
      Failure(:final exception, :final stackTrace) => Error.throwWithStackTrace(
        exception,
        stackTrace ?? StackTrace.current,
      ),
    };
  }
}

@riverpod
Future<void> hypocenterArchiveAvailable(
  Ref ref,
  HypocenterArchive archive,
) async {
  final result = await HypocenterArchiveProbe(
    dio: Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
      ),
    ),
  ).probe(url: archive.url);
  return switch (result) {
    Success() => null,
    Failure(:final exception, :final stackTrace) => Error.throwWithStackTrace(
      exception,
      stackTrace ?? StackTrace.current,
    ),
  };
}

@riverpod
class HypocenterAnalysis extends _$HypocenterAnalysis {
  @override
  Future<List<SeismicityEvent>> build(HypocenterAnalysisRequest request) async {
    if (request.archiveIds.isEmpty) {
      return const [];
    }
    final manifest = await ref.read(hypocenterManifestProvider.future);
    final archives = const HypocenterArchiveSelector().remapComplete(
      selected: request.archiveIds.toSet(),
      archives: manifest.archives,
    );
    if (archives == null) {
      throw const HypocenterApiException(
        message: '選択した期間が利用できなくなりました。期間を選び直してください',
        kind: HypocenterApiErrorKind.periodUnavailable,
      );
    }
    final cancelToken = CancelToken();
    ref.onDispose(() {
      talker.debug('[HypocenterAnalysis] cancel: provider disposed');
      cancelToken.cancel('analysis provider disposed');
    });
    final apiClient = await ref.watch(apiClientProvider.future);
    final progressNotifier = ref.read(
      hypocenterAnalysisProgressProvider(request).notifier,
    );
    progressNotifier.update(
      HypocenterAnalysisProgress(
        completedArchives: 0,
        totalArchives: archives.length,
        fetchedEvents: 0,
      ),
    );
    void onProgress(HypocenterAnalysisProgress progress) {
      if (ref.mounted && !cancelToken.isCancelled) {
        progressNotifier.update(progress);
        state = AsyncLoading(
          progress: progress.completedArchives / progress.totalArchives,
        );
      }
    }

    final result = await HypocenterAnalysisRunner.loadArchives(
      request: request,
      archives: archives,
      apiClient: apiClient,
      cancelToken: cancelToken,
      onProgress: onProgress,
    );
    if (result case Failure(:final exception)
        when exception.isRevisionChanged) {
      talker.info('[HypocenterAnalysis] revision changed; refresh manifest');
      final manifest = await ref
          .read(hypocenterManifestProvider.notifier)
          .forceRefreshCachedValue();
      final remapped = const HypocenterArchiveSelector().remapComplete(
        selected: request.archiveIds.toSet(),
        archives: manifest.archives,
      );
      if (remapped == null) {
        talker.warning(
          '[HypocenterAnalysis] selected archive disappeared after refresh',
        );
        throw const HypocenterApiException(
          message: '選択した期間の一部が利用できなくなりました。期間を選び直してください',
          kind: HypocenterApiErrorKind.periodUnavailable,
        );
      }
      progressNotifier.update(
        HypocenterAnalysisProgress(
          completedArchives: 0,
          totalArchives: remapped.length,
          fetchedEvents: 0,
        ),
      );
      final retry = await HypocenterAnalysisRunner.loadArchives(
        request: request,
        archives: remapped,
        apiClient: apiClient,
        cancelToken: cancelToken,
        onProgress: onProgress,
      );
      return HypocenterAnalysisRunner.unwrap(retry);
    }
    return HypocenterAnalysisRunner.unwrap(result);
  }
}

@riverpod
class HypocenterAnalysisProgressNotifier
    extends _$HypocenterAnalysisProgressNotifier {
  @override
  HypocenterAnalysisProgress build(HypocenterAnalysisRequest request) =>
      HypocenterAnalysisProgress(
        completedArchives: 0,
        totalArchives: request.archiveIds.length,
        fetchedEvents: 0,
      );

  void update(HypocenterAnalysisProgress progress) => state = progress;
}

/// [HypocenterAnalysis.build] から呼び出す震源分析取得処理をまとめる。
class HypocenterAnalysisRunner {
  const new _();

  static Future<Result<List<SeismicityEvent>, HypocenterApiException>>
  loadArchives({
    required HypocenterAnalysisRequest request,
    required List<HypocenterArchive> archives,
    required api.ApiClient apiClient,
    required CancelToken cancelToken,
    required void Function(HypocenterAnalysisProgress progress) onProgress,
  }) =>
      HypocenterAnalysisLoader(
        repository: HypocenterAnalysisRepository(
          client: apiClient.hypocenters,
          logger: talker,
        ),
      ).load(
        archives: archives,
        bounds: request.bounds,
        cancelToken: cancelToken,
        onProgress: onProgress,
      );

  static List<SeismicityEvent> unwrap(
    Result<List<SeismicityEvent>, HypocenterApiException> result,
  ) => switch (result) {
    Success(:final value) => value,
    Failure(:final exception, :final stackTrace) => Error.throwWithStackTrace(
      exception,
      stackTrace ?? StackTrace.current,
    ),
  };
}
